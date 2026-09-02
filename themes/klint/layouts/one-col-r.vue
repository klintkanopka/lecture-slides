<!--
  A single-column slide whose R code runner grows to fill whatever vertical
  space the rest of the slide leaves over.

  Without this, a `{monaco-run}` output pane is sized to its content: about 20px
  when idle, and only as tall as whatever the code last printed. Here the slide
  is a flex column, the console is pinned to 120px, and the editor absorbs the
  remaining height — so the runner is a stable, full-height box no matter how
  much or how little R prints.

  Usage:

  ---
  layout: one-col-r
  ---

  # Title

  ```r {monaco-run}
  ...
  ```

  `autorun` (false) and `outputHeight` (120px) default from setup/transformers.ts;
  either can be overridden on the fence.
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
  <div class="slidev-layout one-col-r w-full h-full" :class="[props.layoutClass, props.class]">
    <slot />
  </div>
</template>

<style scoped>
.one-col-r {
  display: flex;
  flex-direction: column;
}

/* min-height:0 lets these flex children shrink below their content height,
   which is what allows the output to scroll instead of pushing off the slide. */
.one-col-r :deep(.slidev-monaco-container) {
  display: flex;
  flex-direction: column;
  flex: 1 1 auto;
  min-height: 0;
}

/* The editor takes whatever is left; the console stays a fixed 120px (set as a
   layout default in setup/transformers.ts, so a fence can still override it). */
.one-col-r :deep(.slidev-monaco-container-inner) {
  flex: 1 1 auto;
  min-height: 0;
}

.one-col-r :deep(.slidev-monaco-container > [data-waitfor]) {
  flex: 0 0 auto;
}

.one-col-r :deep(.slidev-runner-output) {
  overflow-y: auto;
}
</style>
