import type { CodeRunnerOutput } from '@slidev/types'
import type { Shelter, WebR } from 'webr'
import { defineCodeRunnersSetup } from '@slidev/types'

/**
 * A single webR instance shared by every `{monaco-run}` block in the deck, so
 * that variables assigned in one block are still bound in the next. Created
 * lazily on the first run: booting webR pulls ~25MB of WASM, and we don't want
 * that happening just because someone paged past the slide.
 */
let webRPromise: Promise<{ webR: WebR, shelter: Shelter }> | undefined

/** R packages already fetched from repo.r-wasm.org this session. */
const installed = new Set<string>()

async function getWebR() {
  webRPromise ??= (async () => {
    const { WebR } = await import('webr')
    // GitHub Pages sends no COOP/COEP headers, so SharedArrayBuffer is
    // unavailable and webR falls back to its PostMessage channel. That channel
    // can't block for input, so R must not think it's interactive.
    const webR = new WebR({ interactive: false })
    await webR.init()
    const shelter = await new webR.Shelter()
    return { webR, shelter }
  })()
  return webRPromise
}

/**
 * `slidev export` forces autorun regardless of `{autorun:false}` and then waits
 * on `.slidev-runner-output`, so without this guard every PDF build downloads
 * and boots R inside headless Chromium. `routerMode: hash` puts the query in
 * the fragment, so match against the whole URL.
 */
function isPrintMode() {
  return /[?&]print\b/.test(location.href) || /\/export\b/.test(location.href)
}

function imageToCanvas(image: ImageBitmap) {
  const canvas = document.createElement('canvas')
  canvas.width = image.width
  canvas.height = image.height
  canvas.style.maxWidth = '100%'
  canvas.style.height = 'auto'
  canvas.getContext('2d')!.drawImage(image, 0, 0)
  return canvas
}

export default defineCodeRunnersSetup(() => {
  return {
    async r(code, ctx) {
      if (isPrintMode())
        return { text: '# Runs live in the browser — open the slides to try it', class: 'op50' }

      try {
        const { webR, shelter } = await getWebR()

        // Opt in per block with e.g. ```r {monaco-run} {runnerOptions:{packages:['ggplot2']}}
        const packages = (ctx.options.packages ?? []) as string[]
        const missing = packages.filter(p => !installed.has(p))
        if (missing.length) {
          await webR.installPackages(missing)
          missing.forEach(p => installed.add(p))
        }

        try {
          const result = await shelter.captureR(code, {
            withAutoprint: true,
            captureStreams: true,
            captureConditions: false,
            captureGraphics: { width: 1000, height: 700, bg: 'transparent' },
            env: webR.objs.globalEnv,
          })

          const outputs: CodeRunnerOutput[] = result.output
            .filter(msg => msg.type === 'stdout' || msg.type === 'stderr')
            .map(msg => msg.type === 'stderr'
              ? { text: String(msg.data), class: 'text-red-500' }
              : { text: String(msg.data) })

          for (const image of result.images)
            outputs.push({ element: imageToCanvas(image) })

          return outputs
        }
        finally {
          // Drops the sheltered result objects only; globalEnv bindings survive,
          // which is what lets one block build on another.
          await shelter.purge()
        }
      }
      catch (e) {
        return { error: String(e) }
      }
    },
  }
})
