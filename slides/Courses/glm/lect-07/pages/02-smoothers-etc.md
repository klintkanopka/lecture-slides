---
level: 1
layout: section
---

# Multilevel Model Loose Ends

---
level: 2
---

# Model Identification

<v-clicks depth="2">

- When I originally wrote and released PS3, it had a _huge_ error in it
- What _actually_ went wrong?
  - I asked students to add a random slope on minutes of instruction by classroom
  - _Why was this actually a problem?_
  - Minutes of instruction was measured at the classroom level and had no variation within classrooms
  - What does this do?
  - Prevents the model from being _identified_
- If a model is _identified_, it means that there is a unique solution for the estimated parameters
- So what prevents a model from being identified?
  - Too many parameters and too little data!
  - Insufficient variation in the data!
  - Bad parameterizations

</v-clicks>

---
level: 3
---

# Model Identification


<v-clicks depth="2">

- So why was the random slopes model in PS3 not identified?
- Let's start with a simplified equation:
- $Y_{ij} = \beta_0 + \beta_{0j} + \beta_1 X_j + \varepsilon_{ij}$
  - This works fine---we get an overall intercept, an overall slope, and one intercept per group
- $Y_{ij} = \beta_0 + \beta_{0j} + \beta_1 X_j + \beta_{1j} X_j +\varepsilon_{ij}$
  - Now why does this break if we add a slope for each group?
  - $X_j$ doesn't vary within groups, so the product $\beta_{1j}X_j$ also doesn't vary within groups
  - This makes it act just like an intercept, so it's competing with $\beta_{0j}$ for information
  - $Y^\star_j = \beta_{0j} + \beta_{1j}X_j$
  - For a given total, $Y^\star_j$, there an infinite number of choices for $\beta_{0j}, \beta_{1j}$, so the model doesn't have a unique solution

</v-clicks>

---
level: 2
---

# Model Convergence

<v-clicks depth="2">

- When a model _converges_, it means that the software has settled on estimates for all of the parameters
- What causes a model to fail to converge?
  - The model isn't identified
    - This means there isn't a solution
  - There's a problem with the data that prevents it from having a solution
  - The software doesn't find a solution fast enough
- What can you do about it?
  - Let `lmer()` use the log-likelihood criterion for optimization by passing `REML=FALSE`
  - Fit a simpler model
  - Fiddle with estimation controls by passing arguments to `control=lmerControl()`

</v-clicks>

---
level: 3
---

# Final MLM Thoughts

<v-clicks depth="2">

- Multilevel models are really complex
  - A full semester isn't even enough to _really_ understand them!
  - But hopefully you have a sense of when they may be useful in your own work and now know what questions to ask
- Keep multilevel models in mind for nested data and longitudinal data
- If you'd like to learn more, check out **APSTA-GE 2356: Practicum in Applied Statistics: Multi-Level Models**

</v-clicks>