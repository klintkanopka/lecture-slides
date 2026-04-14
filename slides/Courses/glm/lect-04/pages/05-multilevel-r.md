---
level: 1
layout: section
---

# Multilevel Modeling in `R`

---
level: 2
hideInToc: true
---

# Multilevel Modeling in `R`

<v-clicks depth="2">

- We use the `lme4` package and the `lmer()` function
- In spirit, this works a lot like `lm()`
- Two big differences:
  - `lme4` adds syntax for random effects
  - Mixed models have more estimation controls because fitting can be finicky

</v-clicks>

---
level: 2
---

# `lme4` Model Syntax

<v-clicks depth="2">

- Suppose we have:
  - `time`: minutes of geometry instruction
  - `score`: geometry test score
  - `teacher`: teacher assignment
- In `lm()`, a regression of score on time is:
  - `score ~ time`
  - Equivalent to `score ~ 1 + time`
  - Drop the intercept with `score ~ 0 + time`
- In `lme4`, random effects use the form `(effect | group)`

</v-clicks>

---
level: 3
---

# Random Intercepts and Slopes in `lme4`

- Starting from `score ~ 1 + time`

<v-clicks depth="2">

- Random intercept by teacher:
  - `score ~ (1 | teacher) + time`
- This estimates:
  - An overall intercept
  - An overall slope on `time`
  - The variance of random intercepts across teachers
- Estimated random effects can be extracted with `ranef()`
- Random slope only:
  - `score ~ 1 + (time | teacher)` is not enough by itself
  - Use `score ~ 1 + time + (time | teacher)`
  - `score ~ time + (time | teacher)` also works

</v-clicks>

---
level: 3
---

# More Levels

<v-clicks depth="2">

- Random intercepts and slopes together:
  - `score ~ 1 + time + (1 + time | teacher)`
- If teachers are nested within schools:
  - `score ~ 1 + time + (1 + time | school/teacher)`
- Under the hood this expands to separate groupings for `school` and `school:teacher`
- That estimates variation at both levels

</v-clicks>

---
level: 3
---

# Multilevel GLMs in `R`

<v-clicks depth="2">

- The extension from linear models to GLMs mirrors what we already know
- `lm()` becomes `glm()`
  - Add `family =`
  - Choose a link function
- `lmer()` becomes `glmer()`
  - Keep the same mixed-model syntax
  - Add `family =`
  - Choose a link function
- Both `lmer()` and `glmer()` come from `lme4`

</v-clicks>
