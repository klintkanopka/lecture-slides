import type { MarkdownTransformContext } from '@slidev/types'
import { defineTransformersSetup } from '@slidev/types'

/**
 * Per-layout defaults for `{monaco-run}` blocks.
 *
 * Slidev builds the `<Monaco>` component from the code fence itself, so a
 * layout cannot set these props on slotted content. Instead we rewrite the
 * fence's options object before slidev's own monaco transformer sees it. Values
 * are raw JS source, since that is what ends up inside `v-bind="{...}"`.
 *
 * Anything written on the fence wins: a key already present there is left
 * alone. Add a layout here to give it its own defaults.
 */
const LAYOUT_DEFAULTS: Record<string, Record<string, string>> = {
  'two-cols-r': {
    autorun: 'false',
    height: `'300px'`,
    outputHeight: `'120px'`,
  },
  // two-cols-header geometry; same runner heights as two-cols-r.
  'right-col-r': {
    autorun: 'false',
    height: `'300px'`,
    outputHeight: `'120px'`,
  },
  // No `height`: one-col-r grows the editor with flexbox to fill the slide.
  'one-col-r': {
    autorun: 'false',
    outputHeight: `'120px'`,
  },
}

/** The fence line, matching what @slidev/cli's transformMonaco picks up. */
const RE_MONACO_RUN_FENCE = /^(```\w+[ \t]*\{monaco-run\}[ \t]*)(\{[^\n]*\})?[ \t]*$/gm

/** Is `key` already set at the top level of an options object's source? */
function hasKey(optionsBody: string, key: string) {
  return new RegExp(`(^|[{,\\s])${key}\\s*:`).test(optionsBody)
}

function applyLayoutDefaults(ctx: MarkdownTransformContext) {
  const defaults = LAYOUT_DEFAULTS[ctx.slide.frontmatter?.layout as string]
  if (!defaults)
    return

  ctx.s.replace(RE_MONACO_RUN_FENCE, (full, fence: string, options = '') => {
    const body = options.slice(1, -1).trim()
    const missing = Object.entries(defaults)
      .filter(([key]) => !hasKey(body, key))
      .map(([key, value]) => `${key}:${value}`)
    if (!missing.length)
      return full
    // Fence options last so they also win on any key we failed to detect.
    return `${fence}{${[...missing, body].filter(Boolean).join(', ')}}`
  })
}

export default defineTransformersSetup(() => ({
  // Runs immediately before slidev's own monaco transformer.
  preCodeblock: [applyLayoutDefaults],
}))
