---
level: 1
layout: section
---

# What are Generalized Linear Models?

---
level: 2
---

# Limitations of Linear Models

- An ordinary least squares (OLS) regression models:

$$ Y_i = \beta_0 + \beta_1 X_{1i} + \cdots + \beta_k X_{ki} + \varepsilon_i $$

$$ \varepsilon_i \sim \mathcal(0, \sigma^2) $$

<v-clicks>

- $\varepsilon_i$ implies a few important things about $Y_i$
- $Y_i$ is continuous
 - $Y_i \in \mathbb{R}$
- Why might this be a problem?
- There are lots of different kinds of outcomes
- We use the _generalized linear model_ framework to expand to different types of outcome variables

</v-clicks>

---
level: 2
---

# GLM Structure

GLMs in three parts:

<v-click>

1. An outcome distribution for modeling $Y_i$ that belongs to the exponential family

</v-click>
<v-clicks>

2. A linear predictor:
  $$\eta_i = \beta_0 + \beta_1 X_{1i} + \cdots + \beta_k X_{ki}$$

3. An invertible link function, $g(\cdot)$, such that:
  $$\mathbb{E}(Y_i \mid X_i) = \mu_i = g^{-1}(\eta_i)$$

</v-clicks>

<v-clicks>

- **Core idea**: We specify the _expected value_ of the distribution used for $Y_i$ in terms of the linear predictor $\eta_i$
- Estimation detail: Most GLMs do not have closed-form solutions, so we are forced to use maximum likelihood estimation (MLE)
- More on MLE and the exponential family in the coming weeks!

</v-clicks>



---
level: 2
---

# Fitting GLMs with `glm()`

- The function we use to fit GLMs is `glm()`
  - Part of the `stats` package
  - Loaded into your `R` environment by default
- _In general_, it works like `lm()` with two important differences
  - `family =` specifies the distribution for the outcome
  - `control =` and related arguments affect the optimization routine
- Functions like `coef()`, `summary()`, and `predict()` still work largely as they do for `lm` objects
- We'll practice this shortly