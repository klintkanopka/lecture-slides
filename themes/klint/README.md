# slidev-theme-klint

Seriph, with `Fira Code` as the monospace family instead of `PT Mono`.

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

## What it provides

### R code runner

`setup/code-runners.ts` registers an `r` runner backed by
[webR](https://docs.r-wasm.org/webr/latest/), so any deck can write

````md
```r {monaco-run}
mean(rnorm(20))
```
````

One webR instance is shared across the deck, so variables persist between
blocks. Runner options:

| option | default | meaning |
| --- | --- | --- |
| `packages` | `[]` | R packages to `install` before running, e.g. `['ggplot2']` |
| `plotTarget` | `.r-figure-pane` | element figures are drawn into; falls back to inline output when no such element is visible |
| `plotWidth` / `plotHeight` | the target pane's size | plot size in slide pixels |

During `slidev export` the runner short-circuits to a placeholder line rather
than booting R, so PDF builds stay fast.

### Layouts

| layout | left | right |
| --- | --- | --- |
| `one-col-r` | runner fills the slide, console pinned at 120px | — |
| `two-cols-r` | heading + runner, console under it | figure, full-bleed |
| `right-col-r` | bullet text | runner (no figure handling) |

`two-cols-r` is the only one that routes figures to a separate column; it
provides the `.r-figure-pane` the runner measures and draws into. The other two
keep plots inline in the runner's own output pane.

`setup/transformers.ts` gives each layout default `{monaco-run}` props
(`autorun`, `height`, `outputHeight`) so fences stay short. Anything written on
the fence wins.

## What it changes

- `fonts.mono` is `Fira Code` rather than seriph's `PT Mono`, so code blocks and
  Monaco editors share one family across every deck.
- `setup/monaco.ts` turns on `fontLigatures`, which Monaco disables by default.
  Without it Fira Code renders in Monaco but `<-`, `!=`, `>=` stay as separate
  glyphs, so editors would not match the static code blocks beside them.

Google Fonts is asked for italics of every family slidev manages (seriph sets
`italic: true`) and Fira Code ships none. That is fine — Google returns 200 and
simply serves the upright faces.

A deck can still override any of this in its own headmatter or `setup/` files,
which are applied after the theme's.
