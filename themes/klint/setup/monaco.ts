import { defineMonacoSetup } from '@slidev/types'

export default defineMonacoSetup(() => {
  return {
    editorOptions: {
      // Monaco disables ligatures by default, so without this Fira Code renders
      // in the editor but `<-`, `!=` and `>=` stay as separate glyphs while the
      // static code blocks beside them ligate. Decks can override in their own
      // setup/monaco.ts, which slidev applies after the theme's.
      fontLigatures: true,
      // Monaco only re-lays-out on content changes, so an editor sized by
      // flexbox (see layouts/one-col-r.vue) would leave the space it was given
      // blank and unclickable. This makes it track its container.
      automaticLayout: true,
    },
  }
})
