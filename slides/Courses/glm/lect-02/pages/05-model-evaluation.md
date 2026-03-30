---
level: 1
layout: section
---

# Model Evaluation

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
level: 2
---

# AIC and BIC

<v-clicks>

- For non-nested models, common options are AIC and BIC
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

# Generating some data and fitting three models

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

m1 <- glm(y ~ x1 + x2, data = d, family = binomial(link = 'logit'))
m2 <- glm(y ~ x1 + x2, data = d, family = binomial(link = "probit"))
m3 <- glm(y ~ x1 + x2, data = d, family = binomial(link = "cloglog"))
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
