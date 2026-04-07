---
level: 1
layout: section
---


# Modeling Count Data

---
level: 2
hideInToc: true
---

# Binomial GLMs

<v-clicks depth="2">

- We mentioned this in passing last week, but the Binomial distribution is only in the exponential family if _the number of trials, $n$, is fixed_
- A logistic regression with binary outcomes is the case when $n=1$!
- If $n$ is fixed, but known, we can use the _proportion of successes_, $\frac{k}{n}$, as our outcome variable
  - Note that $k \in \{0,1,2,\ldots,n\}$
- From here, the machinery we have already learned works just fine
- We are still estimating $p$ as a function of $\eta$, we just have a better estimate of what $p$ could be, because we have multiple observations for each person

</v-clicks>

---
level: 2
hideInToc: true
---

# Poisson GLMs

<v-clicks depth="2">

- If we have an _unbounded_ count outcome, $y$, we can model it as Poisson:
  - $y_i \sim \text{Poisson}(\mu_i)$

- Since $\mu = \lambda$ and is a rate, $\mu \in (0, \infty)$
  - Because of this we often use a `log` link function, but `poisson()` will also accept `identity` and `sqrt`
  - $\log \mu = \beta_0 + \sum_k \beta_k x_k$
- To fit a Poisson regression, we pass `family=poisson(link='log')` to the `glm()` function

</v-clicks>

---
level: 2
hideInToc: true
---

# Negative Binomial GLMs

<v-clicks depth="2">

- What if we have a case where the variance is not equal to the mean, so a Poisson distribution is a poor fit for our data?
  - Typically this is called _overdispersion_, because the variance will be larger than the mean
- We can model this by getting fancy:
  - $y_i|\lambda_i \sim \text{Poisson}(\lambda_i)$
  - $\lambda_i \sim \text{Gamma}(\mu_i, \psi)$
- We will talk about Gamma distributions and GLMs in the coming weeks!
- This gives us a situation where $y_i$ is distributed as a negative binomial
- For now, the library `MASS` takes care of this structure with the `glm.nb()` function

</v-clicks>


---
level: 2
hideInToc: true
---

# Quasi-Poisson GLMs

<v-clicks depth="2">

- Another way to handle overdispersion is using a _Quasi-Poisson_ GLM
- This is the same as a Poisson GLM, but also estimates a dispersion parameter $\phi$
  - For a normal Poisson regression, $\phi=1$
  - Implemented by passing `family=quasipoisson(link='log')` to the `glm()` function
  - Allows for the same link functions as `poisson()`
- The difference between Quasi-Poisson and Negative Binomal is the mean-variance structure
  - For Quasi-Poisson, $\text{Var}[\mu] = \phi \mu$
  - For Negative Binomial, $\text{Var}[\mu] = \mu + \frac{\mu^2}{k}$
  - Which is "better" depends on your data!

</v-clicks>


---
level: 2
---

# Fitting Count GLMs

1. Download the file [`count-data.rds`]()
2. Plot a histogram of $y$
3. Plot $y$ vs $x$ with a LOESS best-fit line
4. Fit a Poisson regression of `y~x` with log link
5. Using the `predict()` function with `type='response'`, create predictions for each data point
6. Plot a line for these predictions, how well does it agree with your LOESS line?

---
level: 3
layout: image-right
image: /count-hist.svg
---

# Looking at our data

```r
d <- readRDS('count-data.rds')

ggplot(d, aes(x = y)) +
  geom_histogram(bins = 10,
                 fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: count-loess.svg
---

# Adding a LOESS line

```r
ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.4) +
  geom_smooth(
    formula = y ~ x,
    method = 'loess',
    color = okabeito_colors(3),
    se = FALSE
  ) +
  theme_bw()
```

---
level: 3
---

# Fitting some GLMs

````md magic-move
```r
m <- glm(y ~ x, data = d, family = poisson(link = 'log'))
m_quasi <- glm(y ~ x, data = d, family = quasipoisson(link = 'log'))
m_nb <- MASS::glm.nb(y ~ x, data = d)

summary(m)$coefficients
summary(m_quasi)$coefficients
summary(m_nb)$coefficients
```
```r
m <- glm(y ~ x, data = d, family = poisson(link = 'log'))
m_quasi <- glm(y ~ x, data = d, family = quasipoisson(link = 'log'))
m_nb <- MASS::glm.nb(y ~ x, data = d)

summary(m)$coefficients

             Estimate Std. Error  z value     Pr(>|z|)
(Intercept) 0.1321765 0.04840138 2.730842 6.317268e-03
x           0.3823266 0.04689753 8.152382 3.568249e-16

summary(m_quasi)$coefficients
summary(m_nb)$coefficients
```
```r
m <- glm(y ~ x, data = d, family = poisson(link = 'log'))
m_quasi <- glm(y ~ x, data = d, family = quasipoisson(link = 'log'))
m_nb <- MASS::glm.nb(y ~ x, data = d)

summary(m)$coefficients

             Estimate Std. Error  z value     Pr(>|z|)
(Intercept) 0.1321765 0.04840138 2.730842 6.317268e-03
x           0.3823266 0.04689753 8.152382 3.568249e-16

summary(m_quasi)$coefficients

             Estimate Std. Error  t value     Pr(>|t|)
(Intercept) 0.1321765 0.08408837 1.571877 1.167737e-01
x           0.3823266 0.08147571 4.692523 3.717184e-06

summary(m_nb)$coefficients
```
```r
m <- glm(y ~ x, data = d, family = poisson(link = 'log'))
m_quasi <- glm(y ~ x, data = d, family = quasipoisson(link = 'log'))
m_nb <- MASS::glm.nb(y ~ x, data = d)

summary(m)$coefficients

             Estimate Std. Error  z value     Pr(>|z|)
(Intercept) 0.1321765 0.04840138 2.730842 6.317268e-03
x           0.3823266 0.04689753 8.152382 3.568249e-16

summary(m_quasi)$coefficients

             Estimate Std. Error  t value     Pr(>|t|)
(Intercept) 0.1321765 0.08408837 1.571877 1.167737e-01
x           0.3823266 0.08147571 4.692523 3.717184e-06

summary(m_nb)$coefficients

             Estimate Std. Error  z value     Pr(>|z|)
(Intercept) 0.1308953 0.08173105 1.601537 1.092580e-01
x           0.3882497 0.08287680 4.684661 2.804234e-06
```
````

---
level: 3
layout: image-right
image: /count-loess-glm.svg
---

# Comparing GLM and LOESS predictions

```r
d$y_hat <- predict(m, type = 'response')

ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.4) +
  geom_smooth(
    formula = y ~ x,
    method = 'loess',
    color = okabeito_colors(3),
    se = FALSE
  ) +
  geom_line(aes(y = y_hat),
            color = okabeito_colors(2)) +
  theme_bw()
```