---
level: 1
layout: section
---

# Model Evaluation

---
level: 2
showInToc: false
---

# Generating some data and fitting some models

```r
set.seed(242424)

n <- 500
d <-
  data.frame(
    x1 = rnorm(n),
    x2 = rnorm(n)
  )

d$p <- plogis(0.4 + 0.9 * d$x1 - 0.5*d$x2)
d$y <- rbinom(n, 1, p = d$p)

m1_int <- glm(y ~ 1, data = d, family = binomial(link = 'logit'))
m1_x1 <- glm(y ~ x1, data = d, family = binomial(link = "logit"))
m1 <- glm(y ~ x1 + x2, data = d, family = binomial(link = 'logit'))

m2 <- glm(y ~ x1 + x2, data = d, family = binomial(link = "probit"))
m3 <- glm(y ~ x1 + x2, data = d, family = binomial(link = "cloglog"))
```

---
level: 2
---

# Likelihood-Based Comparison

<v-clicks depth="2">

- Models with larger likelihoods fit the observed data better
- For nested models, we can compare them with a likelihood ratio test

</v-clicks>
<v-click>

$$
\lambda_{LR} = -2\left[\ell(\theta_0) - \ell(\theta_1)\right]
$$

</v-click>
<v-click>

- Asymptotically:

$$
\lambda_{LR}  \sim \chi^2
$$

</v-click>

<v-clicks depth="2">

- The degrees of freedom are the difference in the number of estimated parameters
- This comparison only works for nested models

</v-clicks>

---
level: 3
---

# GLM Summary Output

```r
summary(m1)

Call:
glm(formula = y ~ x1 + x2, family = binomial(link = "logit"),
    data = d)

Coefficients:
            Estimate Std. Error z value Pr(>|z|)
(Intercept)  0.34967    0.10000   3.497 0.000471 ***
x1           0.88827    0.11507   7.719 1.17e-14 ***
x2          -0.35817    0.09986  -3.587 0.000335 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 683.31  on 499  degrees of freedom
Residual deviance: 594.48  on 497  degrees of freedom
AIC: 600.48

Number of Fisher Scoring iterations: 3

```

---
level: 3
---

# Likelihood Ratio Testing and `anova()`

- What the heck are these deviance stats?
  - Residual deviance is $\lambda_{LR}$ between a _saturated model_ (one parameter per observation) and your model
  - Null deviance is $\lambda_{LR}$ between the saturated model and a _null model_ (only one parameter)
- The `anova()` function can be used to compare models, and by default it'll display some deviance stats
  - The deviance column is a likelihood ratio between _successive_ models
  - If the models are nested, you also get a $p$-value for a likelihood ratio test

```r
anova(m1_int, m1_x1, m1)

Analysis of Deviance Table

Model 1: y ~ 1
Model 2: y ~ x1
Model 3: y ~ x1 + x2
  Resid. Df Resid. Dev Df Deviance  Pr(>Chi)
1       499     683.31
2       498     607.93  1   75.383 < 2.2e-16 ***
3       497     594.48  1   13.451 0.0002449 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
---
level: 3
---

# Likelihood Ratio Testing and `anova()`

- If the models you're comparing _aren't_ nested, you won't get $p$-values for a likelihood ratio test!
- Small null deviance means a single parameter explains your data well
- Small residual deviance means your model explains your data well

```r
anova(m1, m2, m3)

Analysis of Deviance Table

Model 1: y ~ x1 + x2
Model 2: y ~ x1 + x2
Model 3: y ~ x1 + x2
  Resid. Df Resid. Dev Df Deviance Pr(>Chi)
1       497     594.48
2       497     595.56  0  -1.0824
3       497     600.37  0  -4.8018
```



---
level: 2
---

# AIC and BIC

<v-clicks>

- For non-nested models, common options are Akaike Information Criterion (AIC) and Bayesian Information Criterion (BIC)
- Both reward better fit through the log likelihood
- Both penalize estimating more parameters

</v-clicks>
<v-clicks>

$$
\mathrm{AIC} = 2k - 2\ell(\theta \mid X)
$$

$$
\mathrm{BIC} = k\log(n) - 2\ell(\theta \mid X)
$$

</v-clicks>
<v-clicks>

- Smaller values are better
- BIC imposes a harsher complexity penalty than AIC
- These are often called _parisomony penalties_, as they tend to favor simpler models when likelihoods are similar

</v-clicks>



---
level: 3
---

# AIC and BIC

```r
AIC(m1_int, m1_x1, m1)
       df      AIC
m1_int  1 685.3149
m1_x1   2 611.9321
m1      3 600.4813

AIC(m1, m2, m3)
   df      AIC
m1  3 600.4813
m2  3 601.5637
m3  3 606.3655

BIC(m1_int, m1_x1, m1)
       df      BIC
m1_int  1 689.5295
m1_x1   2 620.3613
m1      3 613.1251

BIC(m1, m2, m3)
   df      BIC
m1  3 613.1251
m2  3 614.2075
m3  3 619.0093

```

---
level: 2
---

# Accuracy

<v-clicks depth="2">

- Binary GLMs usually output predicted probabilities
- If we pick a threshold such as $0.5$, we can convert probabilities into predicted classes
- Accuracy is the proportion of predictions that match the observed classes
- This is useful, but it can hide important mistakes when classes are imbalanced
- Accuracy is simple to compute:

</v-clicks>

<v-click>

```r
d$p_hat_m1 <- predict(m1, type = "response")
d$y_hat_m1 <- ifelse(d$p_hat_m1 > 0.5, 1, 0)

d$p_hat_m2 <- predict(m2, type = "response")
d$y_hat_m2 <- ifelse(d$p_hat_m2 > 0.5, 1, 0)

d$p_hat_m3 <- predict(m3, type = "response")
d$y_hat_m3 <- ifelse(d$p_hat_m3 > 0.5, 1, 0)

mean(d$y_hat_m1 == d$y)
[1] 0.728
mean(d$y_hat_m2 == d$y)
[1] 0.728
mean(d$y_hat_m3 == d$y)
[1] 0.722
```

</v-click>

---
level: 3
---


# Accuracy


```r
d$p_hat_m1_int <- predict(m1_int, type = "response")
d$y_hat_m1_int <- ifelse(d$p_hat_m1_int > 0.5, 1, 0)
mean(d$y_hat_m1_int == d$y)
[1] 0.57

d$p_hat_m1_x1 <- predict(m1_x1, type = "response")
d$y_hat_m1_x1 <- ifelse(d$p_hat_m1_x1 > 0.5, 1, 0)
mean(d$y_hat_m1_x1 == d$y)
[1] 0.674

d$p_hat_m1 <- predict(m1, type = "response")
d$y_hat_m1 <- ifelse(d$p_hat_m1 > 0.5, 1, 0)
mean(d$y_hat_m1 == d$y)
[1] 0.728
```



---
level: 2
---

# Confusion Matrix

<v-clicks depth="2">

- A confusion matrix separates predictions into:
  - True positives
  - False positives
  - True negatives
  - False negatives
- This lets us evaluate different kinds of error separately

</v-clicks>

<v-click>

|                        | Actually Positive (1) | Actually Negative (0) |
|------------------------|-----------------------|-----------------------|
| Predicted Positive (1) | True Positive (TP)    | False Positive (FP)   |
| Predicted Negative (0) | False Negative (FN)   | True Negative (TN)    |


</v-click>

---
level: 3
---

# Confusion Matrices

- Also straightforward to compile!

```r
table(d[, c("y_hat_m1", "y")])

        y
y_hat_m1   0   1
       0 137  58
       1  78 227

table(d[, c("y_hat_m2", "y")])

        y
y_hat_m2   0   1
       0 137  58
       1  78 227

table(d[, c("y_hat_m3", "y")])

        y
y_hat_m3   0   1
       0 140  64
       1  75 221

```
---
level: 3
---

# Confusion Matrices

- I'm sure there are functions for this, but why bother?

```r
table(d[, c("y_hat_m1_int", "y")])
            y
y_hat_m1_int   0   1
           1 215 285

table(d[, c("y_hat_m1_x1", "y")])
           y
y_hat_m1_x1   0   1
          0 112  60
          1 103 225

table(d[, c("y_hat_m1", "y")])
        y
y_hat_m1   0   1
       0 137  58
       1  78 227

```

---
level: 2
---

# Sensitivity and Specificity

<v-clicks depth="2">

- Sensitivity is the true positive rate
  - Of the actually positive cases, how many did we classify as positive?
- Specificity is the true negative rate
  - Of the actually negative cases, how many did we classify as negative?
- Changing the classification threshold away from 0.5 trades these off against each other
  - Increasing the threshold toward 1 increases sensitivity and decreases specificity
  - Decreasing the threshold toward 0 decreases sensitivity and increases specificity

</v-clicks>

---
level: 2
---

# ROC Curves and the AUC

<v-clicks depth="2">

- A Reciever Operating Characteristic (ROC) curve plots sensitivity against the false positive rate (1 - specificity)
- Each point corresponds to a different classification threshold
- The area under the curve (AUC) summarizes classification performance
  - $0.5$ is random guessing
  - $1.0$ is perfect classification
- The `pROC` package in `R` is really useful for this

</v-clicks>

---
level: 3
layout: image-right
image: /roc-curves.svg
---

# ROC Curves and AUC

```r
library(pROC)

roc1 <- roc(d$y, d$p_hat_m1)
roc2 <- roc(d$y, d$p_hat_m2)
roc3 <- roc(d$y, d$p_hat_m3)

auc(roc1)
Area under the curve: 0.7434
auc(roc2)
Area under the curve: 0.7435
auc(roc3)
Area under the curve: 0.7441

ggroc(list(logit = roc1,
           probit = roc2,
           cloglog = roc3)) +
  geom_abline(intercept = 1, slope = 1,
              linetype = 2, alpha = 0.5) +
  coord_equal() +
  scale_color_okabeito() +
  theme_bw() +
  labs(color = NULL) +
  theme(legend.position = "bottom")
```

---
level: 3
layout: image-right
image: /roc-curves-nested.svg
---

# ROC Curves and AUC

```r
roc1 <- roc(d$y, d$p_hat_m1_int)
roc2 <- roc(d$y, d$p_hat_m1_x1)
roc3 <- roc(d$y, d$p_hat_m1)

auc(roc1)
Area under the curve: 0.5
auc(roc2)
Area under the curve: 0.7248
auc(roc3)
Area under the curve: 0.7434


ggroc(list(intercept = roc1,
           x1 = roc2,
           full = roc3)) +
  geom_abline(intercept = 1, slope = 1,
              linetype = 2, alpha = 0.5) +
  coord_equal() +
  scale_color_okabeito() +
  theme_bw() +
  labs(color = NULL) +
  theme(legend.position = "bottom")
```
