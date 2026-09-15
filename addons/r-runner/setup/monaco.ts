import { defineMonacoSetup } from '@slidev/types'

export default defineMonacoSetup(() => {
  return {
    editorOptions: {
      // Monaco only re-lays-out on content changes, so an editor sized by
      // flexbox (see layouts/one-col-r.vue) would leave the space it was given
      // blank and unclickable. This makes it track its container.
      //
      // Slidev merges editorOptions from every setup/monaco.ts in root order
      // (theme, addons, deck), so this composes with whatever the theme sets.
      automaticLayout: true,
    },
  }
})
