---
level: 1
layout: section
transition: fade
---

# Wrap Up

---
level: 2
hideInToc: true
---

# Wrap Up

<v-clicks depth="2">

- You should always fit models that match the distribution of your outcome variable
- GLMs let us do that with regressions!
  - Logistic/Probit regressions are good for binary outcomes
  - Poisson, Quasipoisson, and Negative Binomial are good for count variables
  - Gamma and Inverse Gaussian are good for non-negative continuous data
- Multilevel models are good if you have nested data or longitudinal data
  - They let you vary intercepts and slopes by group membership
  - You can only make random effects for variables measured below the group you're interested in
  - GLMs work here
- Generalized Additive Models let you fit flexible functions to variables in your regressions
  - GLMs also work here

</v-clicks>
