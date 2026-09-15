import { defineMonacoSetup } from '@slidev/types'
// @ts-expect-error internal Monaco module without types; slidev's own client imports it the same way
import { StandaloneServices } from 'monaco-editor/esm/vs/editor/standalone/browser/standaloneServices'
// @ts-expect-error internal Monaco module without types
import { IConfigurationService } from 'monaco-editor/esm/vs/platform/configuration/common/configuration'

/**
 * Make Monaco editors read like the theme's static code blocks.
 *
 * Token colours already match: slidev feeds the same shiki themes (see
 * setup/shiki.ts) to Monaco through @shikijs/monaco. What differs is what
 * Monaco draws on top of the tokens, so that is what is turned off here. Decks
 * can override any of this in their own setup/monaco.ts, which slidev applies
 * after the theme's.
 */
export default defineMonacoSetup(() => {
  // Bracket pair colourization paints every bracket in Monaco's rainbow
  // colours (bright blue at depth one) over the theme's punctuation colour. It
  // is a *text model* setting that Monaco's model service copies from its own
  // configuration whenever it creates a model or its language changes, so the
  // `bracketPairColorization` editor option slidev passes never reaches it and
  // a per-model override is written back over. Change the configuration.
  StandaloneServices.get(IConfigurationService)
    .updateValue('editor.bracketPairColorization.enabled', false)

  return {
    editorOptions: {
      // Monaco disables ligatures by default, so without this Fira Code renders
      // in the editor but `<-`, `!=` and `>=` stay as separate glyphs while the
      // static code blocks beside them ligate.
      fontLigatures: true,
      // No bracket or indentation guide lines, no current-line band, and no
      // highlighting of other occurrences of the word under the cursor or of
      // the selected text. Static blocks have none of these.
      guides: { bracketPairs: false, indentation: false },
      renderLineHighlight: 'none',
      occurrencesHighlight: 'off',
      selectionHighlight: false,
    },
  }
})
