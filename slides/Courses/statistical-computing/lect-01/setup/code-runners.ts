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

/**
 * webR hands back a bitmap at device resolution (2x the requested size on a
 * retina display), so pin the CSS width to the size the block asked for. Left
 * to itself the canvas lays out at its intrinsic pixel width and runs straight
 * off the bottom of the slide.
 */
function imageToCanvas(image: ImageBitmap, displayWidth: number) {
  const canvas = document.createElement('canvas')
  canvas.width = image.width
  canvas.height = image.height
  canvas.style.width = `${displayWidth}px`
  canvas.style.maxWidth = '100%'
  canvas.style.height = 'auto'
  canvas.getContext('2d')!.drawImage(image, 0, 0)
  return canvas
}

export default defineCodeRunnersSetup(() => {
  return {
    async r(code, ctx) {
      if (isPrintMode())
        return { text: '# This code is interactive when viewed in the browser', class: 'op50' }

      try {
        const { webR, shelter } = await getWebR()

        // Opt in per block with e.g. ```r {monaco-run} {runnerOptions:{packages:['ggplot2']}}
        const packages = (ctx.options.packages ?? []) as string[]
        const missing = packages.filter(p => !installed.has(p))
        if (missing.length) {
          await webR.installPackages(missing)
          missing.forEach(p => installed.add(p))
        }

        // Plot size in slide pixels. Override per block with
        // {runnerOptions:{plotWidth:720, plotHeight:300}}.
        const plotWidth = Number(ctx.options.plotWidth ?? 640)
        const plotHeight = Number(ctx.options.plotHeight ?? 400)

        // With {runnerOptions:{plotTarget:'#some-id'}} the figures are rendered
        // into that element instead of the output pane, so a two-cols slide can
        // put the plot in one column and the console output in the other.
        // Slidev keeps adjacent slides mounted, so write to every match and give
        // each its own canvas rather than moving one node between parents.
        const plotTarget = ctx.options.plotTarget as string | undefined
        const targets = plotTarget
          ? [...document.querySelectorAll<HTMLElement>(plotTarget)]
          : []
        // Clear before running: on an error the stale figure should not survive.
        targets.forEach(t => t.replaceChildren())

        try {
          const result = await shelter.captureR(code, {
            withAutoprint: true,
            captureStreams: true,
            captureConditions: false,
            captureGraphics: { width: plotWidth, height: plotHeight, bg: 'transparent' },
            env: webR.objs.globalEnv,
          })

          const outputs: CodeRunnerOutput[] = result.output
            .filter(msg => msg.type === 'stdout' || msg.type === 'stderr')
            .map(msg => msg.type === 'stderr'
              ? { text: String(msg.data), class: 'text-red-500' }
              : { text: String(msg.data) })

          for (const image of result.images) {
            if (targets.length)
              targets.forEach(t => t.append(imageToCanvas(image, plotWidth)))
            else
              outputs.push({ element: imageToCanvas(image, plotWidth) })
          }

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
