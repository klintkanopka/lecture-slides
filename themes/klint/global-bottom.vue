<!--
  Slide number in the lower right corner of every slide except the cover.

  Slidev renders a theme's `global-bottom.vue` once, underneath the slide
  content, inside the scaled slide container, so the offsets below are in
  slide pixels and the number lands in the same spot at any window size.
  During `slidev export` the same component is rendered once per printed
  slide, so the PDF gets numbers too.

  Hide it on a single slide with `hideSlideNo: true` in that slide's
  frontmatter.
-->

<script setup lang="ts">
import { useSlideContext } from '@slidev/client'
import { computed } from 'vue'

// `$slidev` is the app-wide context in the browser. During export each
// printed slide provides its own fixed copy, which is what keeps the number
// correct per page. Read the page through `$slidev.nav`, not `$page`: only
// the former is overridden per printed slide.
const { $slidev } = useSlideContext()

const show = computed(() => {
  const nav = $slidev.nav
  // Only the app-wide nav carries `isPrintMode`; the fixed nav each printed
  // slide provides does not. When printing, every slide already renders its
  // own copy of this layer, so the app-wide one would be a stray duplicate
  // pinned to the bottom of the whole page rather than to any slide.
  if (nav.isPrintMode)
    return false
  if (nav.currentLayout === 'cover')
    return false
  return !nav.currentSlideRoute?.meta?.slide?.frontmatter?.hideSlideNo
})
</script>

<template>
  <div
    v-if="show"
    class="klint-slide-no absolute bottom-3 right-4 z-10 text-sm font-sans opacity-50 select-none pointer-events-none"
  >
    {{ $slidev.nav.currentPage }}
  </div>
</template>
