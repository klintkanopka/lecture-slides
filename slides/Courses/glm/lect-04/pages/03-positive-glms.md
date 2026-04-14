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
  - Two predictor variables: $x, z$
  - Four outcome variables: $y_1, y_2, y_3, y_4$
- For each outcome:
  1. Fit a linear regression with `lm()`
  2. Fit an appropriate GLM with `glm()`
  3. Compute residuals manually as $y - \hat{y}$ using `predict(..., type = 'response')`
  4. Plot histograms of residuals from the `glm()` and `lm()` fits
- Compare the residual distributions across outcomes

---
level: 3
layout: image-right
image: /resid-r1.svg
---

 # $y_1 \sim x + z$

```r
lm1 <- lm(y1 ~ x + z, data = d)
glm1 <- glm(
  y1 ~ x + z,
  family = binomial(link = 'logit'),
  data = d)

d_resid <- data.frame(
  r1_lm = d$y1 - predict(lm1),
  r1_glm = d$y1 - predict(glm1,
                          type = 'response')
)

d_resid |>
  select(starts_with('r1')) |>
  pivot_longer(everything(),
               names_to = 'model',
               values_to = 'residual') |>
  ggplot(aes(x = residual, fill = model)) +
  geom_histogram() +
  scale_fill_okabeito() +
  facet_grid(model ~ .) +
  theme_bw() +
  theme(legend.position = 'bottom')
```


---
level: 3
layout: image-right
image: /resid-r2.svg
---

 # $y_2 \sim x + z$

```r
lm2 <- lm(y2 ~ x + z, data = d)
glm2 <- glm(
  y2 ~ x + z,
  family = Gamma(link = 'log'),
  data = d)


d_resid$r2_lm <- d$y2 - predict(lm2)
d_resid$r2_glm = d$y2 - predict(glm2,
                          type = 'response')

d_resid |>
  select(starts_with('r2')) |>
  pivot_longer(everything(),
               names_to = 'model',
               values_to = 'residual') |>
  ggplot(aes(x = residual, fill = model)) +
  geom_histogram() +
  scale_fill_okabeito() +
  facet_grid(model ~ .) +
  theme_bw() +
  theme(legend.position = 'bottom')
```


---
level: 3
layout: image-right
image: /resid-r3.svg
---

 # $y_3 \sim x + z$

```r
lm3 <- lm(y3 ~ x + z, data = d)
glm3 <- glm(
  y3 ~ x + z,
  family = gaussian(),
  data = d)

d_resid$r3_lm <- d$y4 - predict(lm3),
d_resid$r3_glm = d$y4 - predict(glm3,
                          type = 'response')

d_resid |>
  select(starts_with('r3')) |>
  pivot_longer(everything(),
               names_to = 'model',
               values_to = 'residual') |>
  ggplot(aes(x = residual, fill = model)) +
  geom_histogram() +
  scale_fill_okabeito() +
  facet_grid(model ~ .) +
  theme_bw() +
  theme(legend.position = 'bottom')
```


---
level: 3
layout: image-right
image: /resid-r4.svg
---

 # $y_4 \sim x + z$

```r
lm4 <- lm(y4 ~ x + z, data = d)
glm4 <- glm(
  y4 ~ x + z,
  family = poisson(),
  data = d)

d_residuals$r4_lm <- d$y4 - predict(lm4),
d_residuals$r4_glm = d$y4 - predict(glm4,
                          type = 'response')

d_residuals |>
  select(starts_with('r4')) |>
  pivot_longer(everything(),
               names_to = 'model',
               values_to = 'residual') |>
  ggplot(aes(x = residual, fill = model)) +
  geom_histogram() +
  scale_fill_okabeito() +
  facet_grid(model ~ .) +
  theme_bw() +
  theme(legend.position = 'bottom')
```
