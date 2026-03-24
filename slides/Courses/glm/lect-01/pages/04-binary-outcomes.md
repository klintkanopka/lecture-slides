---
level: 1
layout: section
---

# Binary Outcomes

---
level: 2
---

# Considerations

<v-clicks depth=2>

- _Binary outcomes_ occur when $Y_i \in \{0, 1\}$
- Why can't we just use linear regression?
  - There's no way to restrict $\hat{Y}_i$ to the interval $[0, 1]$
- What distribution describes outcomes where $Y_i \in \{0, 1\}$?
  - Bernoulli distributions
  - Bernoulli distributions are defined by a single parameter, $p$, that gives the probability that $Y_i = 1$
  - If $Y_i \sim \text{Bernoulli}(p_i)$, then $\mathbb{E}[Y_i] = p_i = \mu_i$

</v-clicks>

---
level: 2
---

# Building a Binary GLM

<v-clicks depth=2>

- Recall the three parts of a GLM:
  - We model the outcome as $Y_i \sim \text{Bernoulli}(\mu_i)$
  - We have a linear predictor, $\eta$, that is a linear combination of observed data, weighted by coefficients
  - We need a _link function_; here we use the _logit_

</v-clicks>
<v-click>

$$ \eta_i = g\big(\mathbb{E}(Y_i \mid X_i)\big) = g(\mu_i) = \ln \bigg( \frac{\mu_i}{1 - \mu_i} \bigg) $$

</v-click>

---
level: 3
layout: image-right
image: /logit.svg
---

# The logit function

$$ \eta_i = \ln \bigg( \frac{\mu_i}{1 - \mu_i} \bigg) $$

```r
d_logit <-
  data.frame(mu = seq(0, 1, by = 1e-3))
d_logit$eta <-
  log(d_logit$mu / (1 - d_logit$mu))

ggplot(d_logit, aes(x = mu, y = eta)) +
  geom_line(color = okabeito_colors(3),
            linewidth = 1) +
  theme_bw()

```

- You can apply the logit in `R` using the `qlogis()` function
- What does the inverse, $\mu_i = g^{-1}(\eta_i)$ look like?


---
level: 3
layout: image-right
image: /logistic.svg
---

# The inverse logit function

$$ \mu_i = g^{-1}(\eta_i) $$

```r
d_logit <-
  data.frame(mu = seq(0, 1, by = 1e-3))
d_logit$eta <-
  log(d_logit$mu / (1 - d_logit$mu))

ggplot(d_logit, aes(x = eta, y = mu)) +
  geom_line(color = okabeito_colors(3),
            linewidth = 1) +
  theme_bw()

```

- What is the functional form of the inverse logit?

---
level: 3
---

# The inverse logit function

- We can start from the logit and solve for $\mu_i$:

$$ \eta_i = \ln \bigg( \frac{\mu_i}{1 - \mu_i} \bigg) $$

<v-clicks>

$$e^{\eta_i} = \frac{\mu_i}{1-\mu_i}$$
$$e^{\eta_i}(1-\mu_i) = \mu_i$$
$$e^{\eta_i}-\mu_i e^{\eta_i} = \mu_i$$
$$e^{\eta_i} = \mu_i+\mu_i e^{\eta_i}$$
$$e^{\eta_i} = \mu_i(1+e^{\eta_i})$$
$$\frac{e^{\eta_i}}{1+e^{\eta_i}} = \mu_i$$

</v-clicks>

---
level: 3
layout: image-right
image: /logistic.svg
---

# The Logistic Function

- The inverse logit is also called the _logistic_ function
- Two common ways to write it:

$$ \mu_i = \frac{e^{\eta_i}}{1+e^{\eta_i}} = \frac{1}{1+e^{-\eta_i}} $$

- Also called the _sigmoid_ function:

$$ \sigma(x) =  \frac{1}{1+e^{-x}} $$

- Squashes its input to be on the interval $(0,1)$, making it great for converting unbounded inputs into probabilities
- Applied in `R` using the `plogis()` function


---
level: 3
---

# Logistic Regression

- Putting it all together, this is logistic regression:

<v-clicks>

$$Y_i \sim \text{Bernoulli}(\mu_i)$$
$$ \mathbb{E}\big[Y_i | X_i\big] = \mu_i $$
$$ \eta_i = \beta_0 + \beta_1 X_{1i} + \cdots + \beta_K X_{Ki}$$
$$  \eta_i = \frac{\mu_i}{1-\mu_i} $$
$$ \mu_i = \frac{1}{1+e^{-\eta_i}}  $$
$$  \mathbb{E}\big[Y_i | X_i\big] = \frac{1}{1+e^{-\big(\beta_0 + \beta_1 X_{1i} + \cdots + \beta_K X_{Ki}\big)}}  $$

</v-clicks>

<v-click>

- Finally you use numerical optimization to estimate the $\beta$ values that make the data you observed most likely under the distributional assumption in the first step!

</v-click>

---
level: 2
---

# Why Logistic?

<v-clicks depth=2>

- There are a few common ways to model binary outcomes, but logistic regression is the most widely used
- The reason is the units of $\eta_i$
- The logit function is also known as the _log odds_
- A one-unit increase in a covariate $X_{ki}$ increases the log odds that $Y_i = 1$ by $\beta_k$
- But what are odds?
  - If the probability something happens is $p$, the _odds_ it happens are $\frac{p}{1 - p}$
  - Odds are a ratio of the probability of success to the probability of failure
  - If I give you $2:1$ odds on an event, we can solve for the probability that it takes place:

</v-clicks>
<v-clicks>

$$ \frac{2}{1} = \frac{p}{1 - p} $$
$$ p = \frac{2}{3} $$

</v-clicks>

---
level: 2
---

# Working with GLMs (and break time)

- We'll look at data from Manhattan restaurant inspections
  - Download the the data for class [here](https://raw.githubusercontent.com/klintkanopka/lecture-slides/refs/heads/main/slides/Courses/glm/lect-01/public/manhattan_restaurants.csv)
  - Data are sourced from [NYC OpenData](https://opendata.cityofnewyork.us/)
- Variables included should be _fairly_ obvious, except for two:
  - `score` is the score on a health inspection
  - `critical` is whether or not that restaurant had a critical violation (one likely to cause a foodborne illness)
- Figure out:
  - How many inspections, restaurants, and critical violations are in the data
  - When were these data collected?
  - What is the range of scores we observe?
  - Is the distribution of scores different between restaurants with and without critical violations?
- Feel free to take a break as you do this


---
level: 3
layout: image-right
image: /score-density.svg
---

# Data Visualization

```r
d <- read_csv('manhattan_restaurants.csv')

nrow(d)
# 94653

length(unique(d$name))
# 8211

sum(d$critical)
# 53287

range(d$inspection_date)
# "01/02/2018" "12/31/2024"

range(d$score)
# 0 168

ggplot(d, aes(x = score,
              fill = as.factor(critical))) +
    geom_density(alpha = 0.7) +
    scale_fill_okabeito() +
    labs(fill = 'critical') +
    theme_bw()

```

---
level: 3
layout: image-right
image: /score-boxplot.svg
---

# Data Visualization

```r
ggplot(d, aes(y = score,
              x = critical,
              fill = as.factor(critical))) +
    geom_boxplot(alpha = 0.7,
                 show.legend = FALSE) +
    scale_fill_okabeito() +
    theme_bw()

```

---
level: 3
---

# What's the relationship between score and having a critical violation?

- It looks like restaurants with higher scores are more likely to have critical violations
- Now fit a linear regression of `critical ~ score`
  - Interpret the coefficients
  - Plot each observation and the line of best fit

---
level: 3
layout: image-right
image: /score-regression.svg
---


# Linear Regression

```r
m_lm <- lm(critical ~ score, data = d)
summary(m_lm)
```
```
Coefficients:
             Estimate Std. Error
(Intercept) 4.744e-01  2.634e-03 ***
score       3.754e-03  8.877e-05 ***
---

```

```r
ggplot(d, aes(x = score, y = critical)) +
    geom_point(alpha = 0.3) +
    geom_abline(
        aes(intercept = coef(m_lm)[1],
            slope = coef(m_lm)[2]),
        linewidth = 1,
        lty = 2,
        color = okabeito_colors(3)
    ) +
    theme_bw()
```


---
level: 3
---


# Fitting a Logistic Regression

````md magic-move
```r
m_lm <- lm(critical ~ score, data = d)
summary(m_lm)
```

```r
m_lm <- glm(critical ~ score, data = d)
summary(m_lm)
```
```r
m_glm <- glm(critical ~ score, data = d)
summary(m_lm)
```
```r
m_glm <- glm(critical ~ score, data = d)
summary(m_glm)
```
```r
m_glm <- glm(
  critical ~ score,
  data = d
)
summary(m_glm)
```
```r
m_glm <- glm(
  critical ~ score,
  data = d,
  family =
)
summary(m_glm)
```
```r
m_glm <- glm(
  critical ~ score,
  data = d,
  family = binomial()
)
summary(m_glm)
```
```r
m_glm <- glm(
  critical ~ score,
  data = d,
  family = binomial(link = 'logit')
)
summary(m_glm)
```
````

<v-click>

```
Call:
glm(formula = critical ~ score, family = binomial(link = "logit"),
    data = d)

Coefficients:
              Estimate Std. Error z value Pr(>|z|)
(Intercept) -0.1257501  0.0111410  -11.29   <2e-16 ***
score        0.0164119  0.0003988   41.15   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 129712  on 94652  degrees of freedom
Residual deviance: 127882  on 94651  degrees of freedom
AIC: 127886
Number of Fisher Scoring iterations: 4

```

</v-click>


---
level: 3
layout: image-right
image: /score-logistic.svg
---

# What does this look like?

```r

m_glm <- glm(
  critical ~ score,
  data = d,
  family = binomial(link = 'logit')
)

d$glm_pred <- predict(m_glm,
                      type = 'response')

ggplot(d, aes(x = score, y = critical)) +
    geom_point() +
    geom_line(aes(y = glm_pred),
              color = okabeito_colors(3),
              linewidth = 1) +
    theme_bw()

```

---
level: 3
---

# What about cuisine type?

- Fit another logistic regression, but now with no intercept and control for cuisine:

```r
m_glm_2 <- glm(
    critical ~ score + cuisine + 0,
    data = d,
    family = binomial(link = 'logit')
)
```

- In a group of $3 \pm 1$, answer:
  - After controlling for cuisine, does score still predict whether or not there was a critical violation?
  - Which cuisines have significant coefficients? Of these, which are most likely to have had critical violations? Which are least likely?
  - Why are many of these coefficients negative?
  - Fit a linear regression with the same formula. How many of these coefficients are significant? Why?
- Note that all of the code from lecture is available [here](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/glm/lect-01/public/lect-01.R)