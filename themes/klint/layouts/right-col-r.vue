<!--
  Slidev's `two-cols-header` grid, sized for an R code runner in the right
  column: bullet text on the left, the runner on the right, heading spanning
  both.

  Purely a layout — it does no figure handling. A `{monaco-run}` block here
  keeps its plots inline in its own output pane, the same as on any ordinary
  slide. Use `two-cols-r` when you want the figure broken out into its own
  column.

  Usage:

  ---
  layout: right-col-r
  ---

  # Title spanning both columns

  ::left::

  - some
  - bullet points

  ::right::

  ```r {monaco-run}
  ...
  ```

  ::bottom::

  Optional full-width footer

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
  <div class="slidev-layout right-col-r w-full h-full" :class="layoutClass">
    <div class="col-header">
      <slot />
    </div>
    <div class="col-left" :class="props.class">
      <slot name="left" />
    </div>
    <div class="col-right" :class="props.class">
      <slot name="right" />
    </div>
    <div class="col-bottom" :class="props.class">
      <slot name="bottom" />
    </div>
  </div>
</template>

<style scoped>
/* Grid mirrors @slidev/client's two-cols-header layout. */
.right-col-r {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: auto 1fr auto;
}

.col-header {
  grid-area: 1 / 1 / 2 / 3;
}
.col-left {
  grid-area: 2 / 1 / 3 / 2;
}
.col-right {
  grid-area: 2 / 2 / 3 / 3;
}
.col-bottom {
  align-self: end;
  grid-area: 3 / 1 / 3 / 3;
}

/*
  The runner is a plain block element, so it fills the column on its own — but
  Monaco measures its container once at creation. min-width:0 stops a long line
  of code from widening the grid column instead of scrolling inside the editor.
*/
.col-right {
  min-width: 0;
}

/* The console pane is a fixed height; scroll output that outgrows it. */
.right-col-r :deep(.slidev-runner-output) {
  overflow-y: auto;
}
</style>
