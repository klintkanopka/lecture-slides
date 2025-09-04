---
layout: section
level: 1


---

# Course Business


---
level: 2
---

# Course Description

This course will introduce the student to statistical programming and simulation using `R`. Students will first understand variables, data structures, program flow (e.g., conditional execution, looping) and functional programming, then apply these skills to answer interesting statistical questions involving the comparison of groups. Most statistical analysis will be motivated via simulations, rather than mathematical theory. The course content (programming and data analysis) requires significant outside reading and programming.

<!--
Pulled directly from syllabus
-->

---
level: 2
---

# Some Clarification

- This course is designed to treat `R` as a programming language
- Programming skills are taught through the analysis, design, and implementation of algorithms, with special attention paid to modern statistical algorithms (e.g., gradient descent, $k$-Means clustering, Markov Chain Monte Carlo)
- Time will also be spent on optimization techniques (e.g., vectorization and parallelization) useful for statistical analysis
- Everything done in this course will be implemented in base `R`, with three exceptions:
  1. `ggplot2` for visualization
  2. The use of `tidyverse` tools for reshaping data so you can feed it into `ggplot()`
  3. Libraries like `MASS` for sampling from distributions not in base `R`
- You will implement algorithms, write unit tests, and debug from scratch using the tools available in base `R`

<!--
Absorb advanced tidyverse to clear space for intro to python in alex's course
-->

---
level: 2
---

# Even More Clarification

- This course is focused on computing
- You won’t learn too much about specifically cleaning or analyzing data here
- You won’t even learn too much about statistics here (on purpose)
- You will learn how to be a much better programmer!
- You’ll come out knowing a lot more about the tools `R` has to offer and how to solve your own problems if you need something that isn’t built in directly
  - This will, by extension, make you better at cleaning and analyzing data!
  - Better at statistics, too! You’ll be less reliant on other people’s work
- You’ll also learn about how statistical algorithms work, when they break, and how to implement and modify them
- I don’t believe in paying for books unless you like them, all readings will be distributed as free .pdf files

---
level: 2
---

# Prerequisites  

This course assumes some experience with the `R` programming language and probability. You may find prior experience with computer science fundamentals and `ggplot2` to be helpful. No previous exposure to the design and analysis of algorithms is assumed.

---
level: 2
---

# Student Learning Outcomes  

1. Students will implement literate programming to produce coherent and reproducible code.
2. Students will verify code function through the implementation of unit tests.
3. Students will write more efficient code by applying optimization techniques (e.g., vectorization, parallelization).
4. Students will solve problems by implementing and modifying algorithms.
5. Students will answer statistical questions by implementing Monte Carlo simulations.

---
level: 2
---

# Meeting Times

- Lecture: Th 4.55-6.35p
- Lab (with Ruiting): W 3.45-4.35p
- Office Hours:
  - Klint: T 2-3p
  - Ruiting: W 9-10a


---
level: 1
layout: section
---

# Course Grades

---
level: 2
---

# Category Breakdown

Category weights:

| **Category** | $p$ |
|--------------|-----|
| Problem Sets | 0.7 |
| Final Exam   | 0.3 |

- Three-credit course
- Eight equally-weighted problem sets (PS0-PS7)
- Extra credit points are added directly to the point total for problem sets
- The Brightspace "final grade" is unlikely to be correct throughout the year, please compute your own expected final grade to monitor progress

---
level: 2
---

# Grading Scale


|   | $G^-$          | $G$            | $G^+$          |
|---|----------------|----------------|----------------|
| A | $[.895, .945)$ | $[.945, 1]$    |                |
| B | $[.795, .825)$ | $[.825, .865)$ | $[.865, .895)$ |
| C | $[.695, .725)$ | $[.725, .765)$ | $[.765, .795)$ |
| D | $[.600, .640)$ | $[.640, .670)$ | $[.670, .695)$ |
| F |                | $[0, .600)$    |                |

---
level: 2
---

# Problem Sets

- Released on (or before) Thursday
- Due on Thursdays before lecture @ 4.54p
- PS0 is a one week assignment
- PS1-PS7 are two week assignments
- Submit both a .qmd **and** compiled .pdf files on Brightspace
  - Assignments are distributed as a .qmd template and a compiled .pdf, please use these
  - If your document does not compile from your .qmd, we will not grade your assignment
- Do not call `install.packages()`
- For more specifics, see syllabus
