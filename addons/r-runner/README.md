# slidev-addon-r-runner

An in-browser R code runner for slidev, backed by
[webR](https://docs.r-wasm.org/webr/latest/), plus three slide layouts sized
around it. Theme-agnostic: it only touches `{monaco-run}` blocks and the
layouts it adds.

## Use it

```yaml
---
theme: klint
addons:
  - r-runner
---
```

and add the dependency to the deck:

```json
"slidev-addon-r-runner": "workspace:*"
```

## R code runner

`setup/code-runners.ts` registers an `r` runner, so any deck can write

````md
```r {monaco-run}
mean(rnorm(20))
```
````

One webR instance is shared across the deck, so variables persist between
blocks. It boots lazily on the first run (about 25MB of WASM), not on page
load. Runner options go in `{runnerOptions:{...}}` on the fence:

| option | default | meaning |
| --- | --- | --- |
| `packages` | `[]` | R packages to install before running, e.g. `['ggplot2']` |
| `plotTarget` | `.r-figure-pane` | element figures are drawn into; falls back to inline output when no such element is visible |
| `plotWidth` / `plotHeight` | the target pane's size | plot size in slide pixels |

During `slidev export` the runner short-circuits to a placeholder line rather
than booting R, so PDF builds stay fast.

## Layouts

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

## Monaco

`setup/monaco.ts` turns on `automaticLayout` so an editor sized by flexbox
(`one-col-r`) tracks its container. Slidev merges `editorOptions` from every
setup in root order (theme, addons, deck), so this composes with whatever the
theme sets and a deck can still override it.
