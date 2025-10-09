---
theme: seriph
# random image from a curated Unsplash collection by Anthony
# like them? see https://unsplash.com/collections/94734566/slidev
background: https://meet.nyu.edu/wp-content/uploads/2020/04/Main_Header.jpg
title: Statistical Computing - Week 2
author: Klint Kanopka
info: |
  ## APSTA-GE 2352: StatComp
  Lecture 2
  Vector and Matrix Arithmetic; Functions
date: 2025-09-11
class: text-center
routerMode: hash
lineNumbers: true
drawings:
  persist: false
transition: fade-out
mdc: true
seoMeta:
  # By default, Slidev will use ./og-image.png if it exists,
  # or generate one from the first slide if not found.
  ogImage: auto
  # ogImage: https://cover.sli.dev
---

# APSTA-GE 2352

Statistical Computing: Lecture 2

Klint Kanopka

New York University


---

# Table of Contents

<Toc text-sm minDepth="1" maxDepth="1" />

---
src: ./pages/01-intro.md
---

---
src: ./pages/02-arithmetic.md
---

---
src: ./pages/03-logicals.md
---

---
src: ./pages/04-functions.md
---

---
layout: section
level: 1
---

# Wrapping Up

---
level: 2
---

# Wrapping up

- When you're combining `R` objects arithmetically, be aware of how things are handled and what conditions do (and do not) trigger warnings and errors!
- Logical statements will help you count objects that satisfy certain conditions and control program behavior in the future
- Writing functions allow you to stop copy-pasting big chunks of code when carrying out repetitive tasks!
- S3 and S4 objects contain both sub objects and code that controls how generic functions act on them!
- Make sure to thoroughly test the different components of your code so that you can pinpoint where problems are coming from

---
level: 2
---

# Wrapping up

- [PollEv.com/klintkanopka](https://PollEv.com/klintkanopka)