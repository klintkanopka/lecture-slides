---
level: 1
layout: section
---

# Introduction to Multilevel Models

---
level: 2
hideInToc: true
---

# Terminology

<v-clicks>

- Multilevel models
- Hierarchical linear models
- Mixed-effect models
- Mixed models
- Random effects models
- These all refer to the same thing

</v-clicks>

---
level: 2
---

# Why Multilevel Models?

<v-clicks depth="2">

- OLS regression assumes uncorrelated residuals
  - iid: independent and identically distributed
- Hierarchical or nested data structures violate this assumption
- Groups experience things together and therefore share variance
- That shared variance creates correlated residuals
- Common examples:
  - Clustered data
  - Longitudinal data

</v-clicks>

---
level: 3
---

# Clustered Data

- We have student-level data from multiple classrooms on:
  - Time spent on a geometry lesson
  - Scores on a geometry test

With your neighbors:

1. Write a linear regression of score on lesson time
2. Interpret what $\beta_0$ and $\beta_1$ capture
3. Identify problems created by students being in different classrooms
4. Decide which coefficient estimates those problems affect


---
level: 3
---

# Longitudinal Data

- We have weekly measurements for individuals over a year on:
  - Weekly exercise time
  - Body weight

With your neighbors:

1. Write a linear regression of body weight on exercise time
2. Interpret what $\beta_0$ and $\beta_1$ capture
3. Identify problems created by repeated measurement
4. Decide which coefficient estimates those problems affect



---
level: 2
---

# Fixed Effects vs. Random Effects

<v-clicks depth="2">

- In a fixed-effects view, each effect has one true value that we estimate
- In a random-effects view, the estimand is itself treated as random
- We care about the distribution of effects, not only each individual one
- We often assume those group-level effects are normally distributed
- This is how we model random intercepts and random slopes
- The basic idea is that clusters, not just individuals, are sampled

</v-clicks>

---
level: 3
---

# Clustered Data, Revisited

<v-clicks depth="2">

- Classrooms may start at different average levels of geometry performance
  - Model this with a random intercept by classroom
- Teachers may differ in how effective instruction time is
  - Model this with a random slope on lesson time by classroom
- Instead of estimating every classroom intercept and slope directly, we estimate the mean and variance of their distributions
- Fixed effects estimate many more parameters, chewing up degrees of freedom
- Random effects share information across groups, but require stronger assumptions

</v-clicks>

---
level: 3
---

# Longitudinal Data, Revisited

<v-clicks depth="2">

- Individuals start at different baseline weights
  - Model this with a random intercept by person
- The relationship between exercise and weight may differ across people
  - Model this with a random slope by person
- Again, we estimate distributions of effects rather than separate coefficients for everyone

</v-clicks>

---
level: 3
---

# Fixed vs. Random Effects, Revisited

<v-clicks depth="2">

- In our examples, random effects let us estimate a mean and variance for the intercepts and slopes
  - Four total parameters
- A fixed-effects approach would estimate two parameters _per group_
- This matters especially when we have many groups but few observations per group
- Random effects partially pool information across groups
- That shrinks noisy group estimates toward the overall mean
- This should sound a lot like regularization

</v-clicks>

---
level: 2
---

# The Intraclass Correlation (ICC)

<v-clicks depth="2">

- The ICC asks: how similar are observations within the same group?
- Consider:
  - $Y_{ij} = \mu + \alpha_j + \varepsilon_{ij}$
  - $\alpha_j \sim \mathcal{N}(0, \sigma_\alpha^2)$
  - $\varepsilon_{ij} \sim \mathcal{N}(0, \sigma_\varepsilon^2)$
- Then:

</v-clicks>

<v-click>

$$
ICC = \frac{\sigma_\alpha^2}{\sigma_\alpha^2 + \sigma_\varepsilon^2}
$$

</v-click>

<v-clicks depth="2">

- If most of the variation is _within_ groups, $\sigma^2_\alpha \gg \sigma^2_\varepsilon$:
  - $ICC \rightarrow 0$
- If most of the variation is _between_ groups, $\sigma^2_\varepsilon \gg \sigma^2_\alpha$:
  - $ICC \rightarrow 1$

</v-clicks>

---
level: 2
---

# Specifying a Multilevel Model

<v-clicks depth="2">

- Start with a level-one model:

</v-clicks>

<v-click>

$$
Y_{ij} = \beta_0 + \beta_1 X_{ij} + e_{ij}
$$

</v-click>

<v-clicks depth="3">

- Now we write second level equations:
  - For a random intercept:
    - $\beta_{0j} = \gamma_{00} + u_{0j}$
    - $u_{0j} \sim \mathcal{N}(0, \tau_{00})$
  - For a random slope:
    - $\beta_{1j} = \gamma_{10} + u_{1j}$
    - $u_{1j} \sim \mathcal{N}(0, \tau_{11})$

</v-clicks>

---
level: 2
---

# Random Intercepts and Slopes Together

<v-clicks depth="2">

- If we want both, we keep the same level-one equation
- Then we model both group-specific coefficients jointly
- We also estimate the covariance between them

</v-clicks>

<v-click>

$$
\begin{bmatrix} \beta_{0j} \\ \beta_{1j} \end{bmatrix}
\sim
\text{MVN}\left(
\begin{bmatrix} \gamma_{00} \\ \gamma_{10} \end{bmatrix},
\begin{bmatrix} \tau_{00} & \tau_{01} \\ \tau_{10} & \tau_{11} \end{bmatrix}
\right)
$$

</v-click>

<v-clicks depth="2">

- We can also add level-two predictors such as years of teaching experience
- Those predictors enter the second-level equations where they make theoretical sense

</v-clicks>
