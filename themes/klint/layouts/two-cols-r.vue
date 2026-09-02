<!--
  Two columns with the right half reserved for figures from the R code runner.

  The runner's `plotTarget` defaults to `.r-figure-pane` and measures that pane
  to size the plot, so a `{monaco-run}` block on a slide using this layout needs
  no plot options at all — figures go to the right column, console output stays
  with the code on the left.

  Usage:

  ---
  layout: two-cols-r
  ---

  # Title

  ```r {monaco-run} {runnerOptions:{packages:['ggplot2']}}
  ...
  ```

  An optional `::right::` block renders inside the figure pane, behind whatever
  the runner draws there.

  `autorun` (false), `height` (300px) and `outputHeight` (120px) default from
  setup/transformers.ts; any of them can be overridden on the fence.
-->

<script setup lang="ts">
const props = defineProps({
  class: {
    type: String,
  },
  layoutClass: {
    type: String,
  },
})
</script>

<template>
  <div class="slidev-layout two-cols-r w-full h-full grid grid-cols-2" :class="props.layoutClass">
    <div class="col-left" :class="props.class">
      <slot />
      <slot name="left" />
    </div>
    <div class="col-right" :class="props.class">
      <div class="r-figure-pane">
        <slot name="right" />
      </div>
    </div>
  </div>
</template>

<style scoped>
.two-cols-r {
  position: relative;
}

/*
  The figure fills the right half of the slide, edge to edge. Absolute offsets
  resolve against the layout's padding box, so the pane ignores the theme's own
  padding, and left:50% lands exactly on the column boundary for any symmetric
  horizontal padding. The runner reads this pane's offsetWidth/offsetHeight and
  renders at that size, so changing the numbers here needs no change elsewhere.
*/
.r-figure-pane {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}

/*
  The console pane under the editor is a fixed height, so scroll output that
  outgrows it rather than letting it spill down the slide.
*/
.two-cols-r :deep(.slidev-runner-output) {
  overflow-y: auto;
}
</style>
