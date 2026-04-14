---
level: 1
layout: section
---

# Modeling Positive Continuous Data

---
level: 2
---

# Gamma GLMs

<v-clicks depth="2">

- If we have a positive continuous outcome $y$, we can model it as Gamma
  - $y_i \sim \text{Gamma}(\alpha, \beta)$
- Here $\mathbb{E}[y] = \mu = \alpha\beta$ and $\text{Var}[y] = \alpha\beta^2$
- We often reparameterize in terms of $\mu$ and $\phi$
  - $\alpha = \frac{1}{\phi}$
  - $\beta = \mu\phi$
- We model $\mu$ and estimate $\phi$
- Common links include `inverse`, `identity`, and `log`
  - `log` is the most common
- Fit with `glm(..., family = Gamma(link = 'log'))`

</v-clicks>

---
level: 2
---

# Inverse Gaussian GLMs

<v-clicks depth="2">

- If we have a positive continuous outcome $y$, we can model it as inverse Gaussian
  - $y_i \sim \text{InvGaussian}(\mu, \lambda)$
- Common links include `1/mu^2`, `inverse`, `identity`, and `log`
  - `log` is the most common
- Fit with `glm(..., family = inverse.gaussian(link = 'log'))`

</v-clicks>

---
level: 3
---

# Gamma Regression Wrap-Up

<v-clicks depth="2">

- Sometimes continuous variables are right-skewed and strictly positive
  - Income-like measures are a canonical example
- In these cases, Gamma and inverse Gaussian GLMs can be good choices
- In general, the inverse Gaussian is more skewed and heavier tailed
- In practice, try both and compare fit

</v-clicks>

---
level: 1
---

# Fun Activity


- Download [`lect-04-warmup-data.csv`](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/glm/lect-04/public/lect-04-warmup-data.csv)
  - Five predictor variables: $x_1, x_2, x_3, x_4, x_5$
  - Four outcome variables: $y_1, y_2, y_3, y_4$
- For each outcome:
  1. Fit a linear regression with `lm()`
  2. Fit an appropriate GLM with `glm()`
  3. Compute residuals manually as $y - \hat{y}$ using `predict(..., type = 'response')`
  4. Plot histograms of residuals from the `glm()` and `lm()` fits
- Compare the residual distributions across outcomes

