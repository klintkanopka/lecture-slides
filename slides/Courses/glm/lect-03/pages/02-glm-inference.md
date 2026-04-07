---
level: 1
layout: section
---

# Inference with GLMs

---
level: 2
hideInToc: true
---

# Simulating some data and fitting some models


```r
N <- 200
d <- data.frame(x1=rnorm(N), x2=rnorm(N), x3=rnorm(N))
d$eta <- -0.5 + 1.2*d$x1 - 0.7*d$x2
d$y <- rbinom(N, 1, p=plogis(d$eta))

m_1 <- glm(y~1, data=d,
           family=binomial(link='logit'))
m_x1 <- glm(y~x1, data=d,
            family=binomial(link='logit'))
m_x2 <- glm(y~x2, data=d,
            family=binomial(link='logit'))
m_x3 <- glm(y~x3, data=d,
            family=binomial(link='logit'))
m_all <- glm(y~x1+x2+x3, data=d,
             family=binomial(link='logit'))
```

---
level: 2
---

# Typical Inference Tasks

<v-clicks>

- Are individual coefficient estimates significant?
- What are the confidence intervals around the coefficient estimates?
- What are the confidence intervals around predicted means?
- Does one model fit better than another?

</v-clicks>

---
level: 2
---

# Inference with Coefficients

```r
summary(m_all)$coefficients

              Estimate Std. Error    z value     Pr(>|z|)
(Intercept) -0.3895779  0.1929222 -2.0193525 4.345060e-02
x1           1.7745552  0.2862473  6.1993774 5.668696e-10
x2          -1.5820234  0.2838322 -5.5737984 2.492442e-08
x3          -0.1996343  0.2067549 -0.9655604 3.342642e-01
```

---
level: 2
layout: image-right
image: /logistic-ci.svg
---

# Constructing Confidence Intervals

```r
summary(m_all)$coefficients |>
  as.data.frame() |>
  rownames_to_column('term') |>
  select(term,
         estimate = Estimate,
         se = `Std. Error`) |>
  mutate(ci_upper = estimate + 1.96 * se,
         ci_lower = estimate - 1.96 * se) |>
  ggplot(aes(
    y = reorder(term, estimate),
    x = estimate,
    xmin = ci_lower,
    xmax = ci_upper
  )) +
  geom_vline(aes(xintercept = 0),
             lty = 2, alpha = 0.5) +
  geom_point(color = okabeito_colors(3)) +
  geom_errorbar(color = okabeito_colors(3),
                width = 0) +
  labs(y = NULL) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /logistic-ci-2.svg
---

# Constructing CIs

```r

summary(m_all)$coefficients |>
  as.data.frame() |>
  rownames_to_column('term') |>
  select(term,
         estimate = Estimate,
         se = `Std. Error`) |>
  mutate(ci_upper = estimate + 1.96 * se,
         ci_lower = estimate - 1.96 * se) |>
  ggplot(aes(
    x = reorder(term, -estimate),
    y = estimate,
    ymin = ci_lower,
    ymax = ci_upper
  )) +
  geom_hline(aes(yintercept = 0),
             lty = 2,
             alpha = 0.5) +
  geom_point(color = okabeito_colors(3)) +
  geom_errorbar(color = okabeito_colors(3),
                width = 0) +
  labs(x = NULL) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /logistic-pred-ci.svg
---

# Constructing CIs on Predictions

```r
preds <- predict(m_x1,
                 type = 'response',
                 se.fit = TRUE)

d |>
  mutate(p_hat = preds$fit,
         se = preds$se.fit) |>
  mutate(ci_upper = p_hat + 1.96 * se,
         ci_lower = p_hat - 1.96 * se) |>
  ggplot(aes(x = x1,
             y = p_hat,
             ymin = ci_lower,
             ymax = ci_upper)) +
  geom_line(color = okabeito_colors(3)) +
  geom_ribbon(fill = okabeito_colors(3),
              alpha = 0.4) +
  geom_point(aes(y = y),
             color = 'black',
             alpha = 0.5) +
  theme_bw()

```



---
level: 3
layout: image-right
image: /logistic-pred-ci-2.svg
---

# Constructing CIs on Predictions

```r
preds <- predict(m_all,
                 type = 'response',
                 se.fit = TRUE)

d |>
  mutate(p_hat = preds$fit,
         se = preds$se.fit) |>
  mutate(ci_upper = p_hat + 1.96 * se,
         ci_lower = p_hat - 1.96 * se) |>
  ggplot(aes(x = x1,
             y = p_hat,
             ymin = ci_lower,
             ymax = ci_upper)) +
  geom_point(color = okabeito_colors(3)) +
  geom_errorbar(color = okabeito_colors(3),
                width = 0,
                alpha = 0.4) +
  geom_point(aes(y = y),
             color = 'black',
             alpha = 0.5) +
  theme_bw()
```

---
level: 2
---

# Inference for Comparing Nested Models

<v-clicks depth="2">

- All of this stuff only works with nested models!
- Likelihood Ratio Test
  - We will compute $L$ using the difference in deviance from each model
  - This has the distribution $L \sim \Chi^2$ with degrees of freedom equal to the difference in degrees of freedom between the nested models
- Analysis of Deviance Tables
  - Similar to an analysis of variance (ANOVA)
  - Allows for comparing multiple (nested) models simultaneously
- These are all valid if model dispersion is known---check the text for how to modify these tests if you need to estimate model dispersion
  - Note that Binomial GLMs have dispersion $\phi = 1$
  - Poisson GLMs also have dispersion $\phi = 1$
  - Negative Binomial GLMs need to have dispersion corrections
  - The coefficient standard errors we used before already account for dispersion corrections

</v-clicks>

---
level: 3
---

# Likelihood Ratio Tests

```r

L <- (deviance(m_1) - deviance(m_x1))
pchisq(L, df.residual(m_1) - df.residual(m_x1), lower.tail=FALSE )

[1] 1.870932e-13


L <- (deviance(m_1) - deviance(m_x3))
pchisq(L, df.residual(m_1) - df.residual(m_x3), lower.tail=FALSE )

[1] 0.5150429

```

---
level: 3
---

# Analysis of Deviance Tables

```r
anova(m_1, m_x1, m_all, test='Chisq')

Analysis of Deviance Table

Model 1: y ~ 1
Model 2: y ~ x1
Model 3: y ~ x1 + x2 + x3
  Resid. Df Resid. Dev Df Deviance  Pr(>Chi)
1       199     269.20
2       198     215.07  1   54.136 1.871e-13 ***
3       196     165.91  2   49.157 2.117e-11 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

---
level: 3
---

# Analysis of Deviance Tables

```r
anova(m_1, m_x3, m_all, test='Chisq')

Analysis of Deviance Table

Model 1: y ~ 1
Model 2: y ~ x3
Model 3: y ~ x1 + x2 + x3
  Resid. Df Resid. Dev Df Deviance Pr(>Chi)
1       199     269.20
2       198     268.78  1    0.424    0.515
3       196     165.91  2  102.869   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```