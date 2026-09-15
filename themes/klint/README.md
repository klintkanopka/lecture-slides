# slidev-theme-klint

Seriph, with `Fira Code` as the monospace family instead of `PT Mono`, and a
slide number in the lower right corner.

Everything visual comes from [`@slidev/theme-seriph`](https://github.com/slidevjs/themes):
this package re-exports its layouts and styles unchanged, and only overrides the
font defaults in `package.json`. Upstream seriph fixes are picked up by bumping
that dependency.

## Use it

```yaml
---
theme: klint
---
```

and add the dependency to the deck:

```json
"slidev-theme-klint": "workspace:*"
```

## What it changes

- `fonts.mono` is `Fira Code` rather than seriph's `PT Mono`, so code blocks and
  Monaco editors share one family across every deck.
- `setup/shiki.ts` sets the code highlighting themes (`min-light` /
  `min-dark`) and preloads the languages the decks use, including `r`. This
  used to be copied into every deck; a deck can still add its own to extend or
  override it.
- `setup/monaco.ts` makes Monaco editors (`{monaco}` / `{monaco-run}` blocks)
  read like the static code blocks: `fontLigatures` on so Fira Code ligates
  `<-` and friends the way static blocks do, bracket-pair rainbow colours off
  (a text-model setting Monaco copies from its own configuration, so it is
  switched off there rather than via the editor option slidev passes), and no guide lines, current-line band,
  or occurrence highlights. Token colours come from the same shiki themes.
- `global-bottom.vue` prints the slide number in the lower right corner of
  every slide except the cover. It is rendered inside the scaled slide
  container, so it sits in the same place at any window size and in the
  exported PDF. Hide it on one slide with `hideSlideNo: true` in that slide's
  frontmatter.

Google Fonts is asked for italics of every family slidev manages (seriph sets
`italic: true`) and Fira Code ships none. That is fine — Google returns 200 and
simply serves the upright faces.

A deck can still override any of this in its own headmatter or `setup/` files,
which are applied after the theme's.

## R code

The webR runner and the `one-col-r` / `two-cols-r` / `right-col-r` layouts
live in the `r-runner` addon (`addons/r-runner`), not here. Decks that use them
add `addons: [r-runner]` to their headmatter and depend on
`slidev-addon-r-runner`.
