---
level: 2
layout: section
---

# The Bootstrap

---
level: 3
---

# The Bootstrap

<v-clicks>

- **Resampling’s Core Idea:** The distribution of the data you have is your best guess at the distribution of the population 
- **Jackknife’s Core Idea:** We take our data, make new datasets by dropping single observations, compute our statistic of interest, and then look at the distribution
- **Bootstrap’s Core Idea:** We take our data and make new datasets by resampling _with replacement_ from our original dataset to approximate the population. Then we compute our statistic of interest on each resampled dataset and look at the distribution

</v-clicks>

---
level: 3
layout: image-right
image: /efron.jpg
---

# Bradley Efron (born 1938)

<ul>
<li v-click="1">Invented the bootstrap in 1979</li>
<li v-click="2">One of the first computationally intensive statistical techniques</li>
<li v-click="3">His list of awards is insane: <span v-click="4">MacArthur Fellowship;</span> <span v-click="5">National Academy of Sciences;</span> <span v-click="6">IMS and ASA Fellow;</span> <span v-click="7">Wilks Medal;</span> <span v-click="8">Guy Medal in Gold;</span> <span v-click="9">National Medal of Science;</span> <span v-click="10">International Prize in Statistics</span></li>
<li v-click="11">Certified badass</li>
<li v-click="12">Advised Rob Tibshirani, and still at Stanford!</li>
<li v-click="13">I don't think he played pickup basketball at the gym</li>
</ul>

---
level: 3
---

# The Bootstrap

- It works for almost anything!
- Your data describes an _empirical distribution function_ - this is an approximation of the cumulative distribution function (CDF)
- The empirical distribution function (eCDF) converges to the CDF
- The bootstrap uses resampling with replacement to build new eCDFs
- The jackknife gives exactly $n$ datasets of size $n-1$, while the bootstrap can give up to $\binom{2n-1}{n}$ distinct datasets of size $n$
- Every resampled point is a real observation, so no distributional assumptions are needed, but the bootstrap is only as good as your sample!
- Often used for bias, variance, and constructing confidence intervals
- Does not require the CLT to apply to your estimator!
- Caveat: it struggles with extremes (like the max or min), very small samples, and dependent data (like time series)

---
level: 3
---

# How to Bootstrap

1. Compute your estimate in the full sample with $N$ observations
2. Draw $M$ bootstrap samples, each of length $N$, from the original dataset _with replacement_
3. Compute your estimate on each bootstrap sample
4. Use the distribution of bootstrap estimates to:
   - Check the original estimate for bias: mean of bootstrap estimates $-$ original estimate
   - Find the variance or standard error of the estimate (using the variance or sd)
   - Construct a confidence interval (there's more than one way to do this - coming up!)
  
  
---
level: 3
---

# Applied Bootstrapping 

````md magic-move
```r
d <- data.frame(x = rnorm(1e2))
d$y <- -1.5 + 3*d$x + rnorm(1e2)

m <- lm(y~x, d)


summary(m)$coefficients
```
```r
d <- data.frame(x = rnorm(1e2))
d$y <- -1.5 + 3*d$x + rnorm(1e2)

m <- lm(y~x, d)


summary(m)$coefficients

#              Estimate Std. Error   t value     Pr(>|t|)
# (Intercept) -1.486122 0.09547956 -15.56482 3.078629e-28
# x            3.101451 0.09144205  33.91712 5.913505e-56
```
```r
d <- data.frame(x = rnorm(1e2))
d$y <- -1.5 + 3*d$x + rnorm(1e2)

m <- lm(y~x, d)


summary(m)$coefficients

#              Estimate Std. Error   t value     Pr(>|t|)
# (Intercept) -1.486122 0.09547956 -15.56482 3.078629e-28
# x            3.101451 0.09144205  33.91712 5.913505e-56

coef(m)[2]
```
```r
d <- data.frame(x = rnorm(1e2))
d$y <- -1.5 + 3*d$x + rnorm(1e2)

m <- lm(y~x, d)


summary(m)$coefficients

#              Estimate Std. Error   t value     Pr(>|t|)
# (Intercept) -1.486122 0.09547956 -15.56482 3.078629e-28
# x            3.101451 0.09144205  33.91712 5.913505e-56

coef(m)[2]

#        x 
# 3.101451 
```
````

---
level: 3
---

# Applied Bootstrapping 

1. Write a function that extracts the coefficient we care about
2. Then we add resampling
3. Run it a bunch of times

````md magic-move
```r
Beta1Boot <- function(d){

}
```
```r
Beta1Boot <- function(d){
  m <- lm(y~x, d)
}
```
```r
Beta1Boot <- function(d){
  m <- lm(y~x, d)
  beta1 <- unname(coef(m)[2])
}
```
```r
Beta1Boot <- function(d){
  m <- lm(y~x, d)
  beta1 <- unname(coef(m)[2])
  return(beta1)
}
```
```r
Beta1Boot <- function(d){
  idx <- sample(nrow(d), replace=TRUE)
  m <- lm(y~x, d)
  beta1 <- unname(coef(m)[2])
  return(beta1)
}
```
```r
Beta1Boot <- function(d){
  idx <- sample(nrow(d), replace=TRUE)
  m <- lm(y~x, d[idx,])
  beta1 <- unname(coef(m)[2])
  return(beta1)
}
```
```r
Beta1Boot <- function(d){
  idx <- sample(nrow(d), replace=TRUE)
  m <- lm(y~x, d[idx,])
  beta1 <- unname(coef(m)[2])
  return(beta1)
}

replicate(5, Beta1Boot(d))
```
```r
Beta1Boot <- function(d){
  idx <- sample(nrow(d), replace=TRUE)
  m <- lm(y~x, d[idx,])
  beta1 <- unname(coef(m)[2])
  return(beta1)
}

replicate(5, Beta1Boot(d))

# [1] 2.930935 3.264935 3.177743 3.027659 2.913476
```
```r
Beta1Boot <- function(d){
  idx <- sample(nrow(d), replace=TRUE)
  m <- lm(y~x, d[idx,])
  beta1 <- unname(coef(m)[2])
  return(beta1)
}

replicate(5, Beta1Boot(d))

# [1] 2.930935 3.264935 3.177743 3.027659 2.913476

N_boot <- 1e6 # slow! (~3 min) try 1e4 first
```
```r
Beta1Boot <- function(d){
  idx <- sample(nrow(d), replace=TRUE)
  m <- lm(y~x, d[idx,])
  beta1 <- unname(coef(m)[2])
  return(beta1)
}

replicate(5, Beta1Boot(d))

# [1] 2.930935 3.264935 3.177743 3.027659 2.913476

N_boot <- 1e6 # slow! (~3 min) try 1e4 first
boot <- data.frame(rep = 1:N_boot,
                   beta1 = replicate(N_boot, Beta1Boot(d)))
```
````


---
level: 3
layout: image-right
image: /bootstrap-01.png
---

# Applied Bootstrapping 

```r
ggplot(boot, aes(x = rep, y = beta1)) +
  geom_point(alpha = 0.3) +
  geom_hline(
    aes(
      yintercept = 
        summary(m)$coefficients[2, 1]),
      color = okabeito_colors(3)
  ) +
  geom_ribbon(
    aes(
      ymin = 
        summary(m)$coefficients[2, 1] -
        1.96*summary(m)$coefficients[2, 2],
      ymax = 
        summary(m)$coefficients[2, 1] +
        1.96*summary(m)$coefficients[2, 2]
    ),
    fill = okabeito_colors(3),
    alpha = 0.4
  ) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /bootstrap-02.png
---

# Applied Bootstrapping 

```r
ggplot(boot, aes(x = beta1)) +
  geom_histogram(
    aes(y = after_stat(density)),
    bins = 30,
    color = 'black',
    fill = okabeito_colors(1),
    alpha = 0.7
  ) +
  geom_function(
    fun = dnorm,
    linewidth = 2,
    color = okabeito_colors(2),
    args = list(
      mean = summary(m)$coefficients[2, 1],
      sd = summary(m)$coefficients[2, 2]
    )
  ) +
  theme_bw()
```

---
level: 3
---

# Applied Bootstrapping

- `lm()` estimate, SE, and 95% CI:

````md magic-move
```r
summary(m)$coefficients[2,1:2]
c(summary(m)$coefficients[2,1] - 1.96*summary(m)$coefficients[2,2],
  summary(m)$coefficients[2,1] + 1.96*summary(m)$coefficients[2,2])
```
```r
summary(m)$coefficients[2,1:2]

#   Estimate Std. Error 
# 3.10145067 0.09144205 

c(summary(m)$coefficients[2,1] - 1.96*summary(m)$coefficients[2,2],
  summary(m)$coefficients[2,1] + 1.96*summary(m)$coefficients[2,2])
```
```r
summary(m)$coefficients[2,1:2]

#   Estimate Std. Error 
# 3.10145067 0.09144205 

c(summary(m)$coefficients[2,1] - 1.96*summary(m)$coefficients[2,2],
  summary(m)$coefficients[2,1] + 1.96*summary(m)$coefficients[2,2])

# [1] 2.922224 3.280677
```
````

- Bootstrapped estimate, SE, and 95% CI:

````md magic-move
```r
c(mean(boot$beta1), sd(boot$beta1))
quantile(boot$beta1, c(0.025, 0.975))
```
```r
c(mean(boot$beta1), sd(boot$beta1))

# [1] 3.09708749 0.09906309

quantile(boot$beta1, c(0.025, 0.975))
```
```r
c(mean(boot$beta1), sd(boot$beta1))

# [1] 3.09708749 0.09906309

quantile(boot$beta1, c(0.025, 0.975))

#     2.5%    97.5% 
# 2.897704 3.286801 
```
````

---
level: 3
---

# What's Different?

- **Bias:** the bootstrap mean is 3.097 vs. the estimate of 3.101, so $\widehat{\text{bias}} \approx -0.004$ (essentially nothing)
- **SE:** the bootstrap SE (0.099) is a bit larger than the `lm()` SE (0.091)
  - You can see this in the histogram: the bootstrap distribution is a little wider than the normal curve
  - `lm()` treats $x$ as fixed, but resampling whole rows treats $x$ as random too
  - So the bootstrap also captures variability from _which_ $x$ values ended up in the sample
- **CI:** these two intervals are built in different ways, and there's more than one way to build a bootstrap CI...

---
level: 2
---

# Two Bootstrap Confidence Intervals

- Notation: $\hat{\theta}$ is the estimate in the full sample, $\hat{\theta}^*$ are the bootstrap estimates, and $q^*_p$ is the $p$-th quantile of the $\hat{\theta}^*$
- **Quantile (percentile) bootstrap:** use the quantiles of the bootstrap estimates directly. This treats the distribution of $\hat{\theta}^*$ as if it _were_ the sampling distribution of $\hat{\theta}$:

$$ \big[\, q^*_{\alpha/2},\; q^*_{1-\alpha/2} \,\big] $$

- **Empirical (basic) bootstrap:** use the bootstrap to learn about the _error_ in the estimate. This treats the distribution of the bootstrap error, $\delta^* = \hat{\theta}^* - \hat{\theta}$, as a stand-in for the real error, $\delta = \hat{\theta} - \theta$:

$$ \big[\, \hat{\theta} - \delta^*_{1-\alpha/2},\; \hat{\theta} - \delta^*_{\alpha/2} \,\big] = \big[\, 2\hat{\theta} - q^*_{1-\alpha/2},\; 2\hat{\theta} - q^*_{\alpha/2} \,\big] $$

- Note the flip! The _upper_ bootstrap quantile sets the _lower_ end of the empirical interval

---
level: 3
---

# Why the Flip?

- If we knew the distribution of the error, $\delta = \hat{\theta} - \theta$, we could say:

$$ P\big(\delta_{\alpha/2} \le \hat{\theta} - \theta \le \delta_{1-\alpha/2}\big) = 1-\alpha $$

- Solving for $\theta$ flips the inequalities:

$$ P\big(\hat{\theta} - \delta_{1-\alpha/2} \le \theta \le \hat{\theta} - \delta_{\alpha/2}\big) = 1-\alpha $$

- We don't know the distribution of $\delta$, so we approximate it with $\delta^* = \hat{\theta}^* - \hat{\theta}$ (its quantiles are just $q^*_p - \hat{\theta}$)
- **Intuition:** if the bootstrap estimates tend to land far _above_ $\hat{\theta}$, then $\hat{\theta}$ probably landed far above $\theta$, so the interval should reach further _below_ $\hat{\theta}$

---
level: 3
---

# Both Intervals for $\beta_1$

````md magic-move
```r
theta_hat <- unname(coef(m)[2])
q <- unname(quantile(boot$beta1, c(0.025, 0.975)))

round(c(q[1], q[2]), 3)                              # quantile
round(c(2*theta_hat - q[2], 2*theta_hat - q[1]), 3)  # empirical
```
```r
theta_hat <- unname(coef(m)[2])
q <- unname(quantile(boot$beta1, c(0.025, 0.975)))

round(c(q[1], q[2]), 3)                              # quantile

# [1] 2.898 3.287

round(c(2*theta_hat - q[2], 2*theta_hat - q[1]), 3)  # empirical

# [1] 2.916 3.305
```
````

---
level: 3
---

# Comparing the Intervals for $\beta_1$

| Method | 95% CI |
|---|---|
| `lm()`: estimate $\pm$ 1.96 $\times$ SE | \[2.922, 3.281\] |
| `confint(m)`: uses the $t$ quantile (1.984 for 98 df) | \[2.920, 3.283\] |
| Bootstrap SE: estimate $\pm$ 1.96 $\times$ bootstrap SE | \[2.907, 3.296\] |
| Quantile bootstrap | \[2.898, 3.287\] |
| Empirical bootstrap | \[2.916, 3.305\] |


<div v-click>

- They nearly agree, because this bootstrap distribution is nearly symmetric around $\hat{\theta}$. What if it isn't?

</div>

---
level: 3
layout: image-right
image: /bootstrap-03.png
---

# A Skewed Example

- The mean of 25 draws from right-skewed (lognormal) data, like incomes

```r
set.seed(8675309)
x <- rlnorm(25, sdlog = 1.5)
theta_hat <- mean(x)

boot_mean <- replicate(1e4,
  mean(sample(x, replace = TRUE)))
q <- unname(
  quantile(boot_mean, c(0.025, 0.975)))

round(c(q[1], q[2]), 2)

# [1] 1.62 6.43

round(c(2*theta_hat - q[2],
        2*theta_hat - q[1]), 2)

# [1] 1.09 5.89
```

---
level: 3
---

# A Skewed Example

- $\hat{\theta} = 3.76$, while the true mean is $e^{1.5^2/2} \approx 3.08$
- Quantile bootstrap: \[1.62, 6.43\]
- Empirical bootstrap: \[1.09, 5.89\]
- The bootstrap distribution has a long right tail, so the two intervals disagree
  - The quantile interval follows the skew and stretches further _right_
  - The empirical interval flips the skew and stretches further _left_
- Which one is right?

---
level: 3
---

# Which Should I Use?

- Neither wins everywhere! Simulate 1,000 datasets like this one and check how often each 95% interval contains the true mean:
  - Quantile bootstrap: 78.4%
  - Empirical bootstrap: 72.1%
  - Both fall well short of 95%, because $n = 25$ from very skewed data is hard for _any_ method
- **Empirical:** follows directly from the error argument on the last slide, but can produce impossible values (like a negative SD, or a correlation above 1)
- **Quantile:** always stays within the range of possible values, and respects transformations (the CI for $\log\theta$ is the log of the CI for $\theta$)
- When the two disagree a lot, treat it as a warning sign
  - Consider a larger sample, a transformation, or a better-corrected interval, like BCa: `boot::boot.ci(type = "bca")`

---
level: 3
---

# Bootstrapping a Whole Curve

- The bootstrap isn't just for single numbers! Resample the 10 polynomial points, refit both degree-9 models, and keep the whole fitted curve

```r
BootCurves <- function(d, x_grid, lambda) {
  b <- d[sample(nrow(d), replace = TRUE), ]
  ols <- lm(y ~ poly(x, 9, raw = TRUE), b)
  ridge <- glmnet(poly(b$x, 9, raw = TRUE), b$y, alpha = 0, lambda = lambda)
  data.frame(
    x = x_grid,
    OLS = predict(ols, data.frame(x = x_grid)),
    Ridge = as.vector(predict(ridge, poly(x_grid, 9, raw = TRUE)))
  )
}

# d_poly: the 10 points from the polynomial example
x_grid <- seq(min(d_poly$x), max(d_poly$x), length.out = 200)
curves <- map(1:200, \(i) BootCurves(d_poly, x_grid, 0.01)) |>
  list_rbind(names_to = 'rep')
```

- A bootstrap sample of 10 usually has only 6-7 unique points, so `lm()` can't estimate all 10 coefficients: it drops terms and warns about a "rank-deficient fit"

---
level: 3
layout: image-right
image: /bootstrap-04.png
---

# Bootstrapping a Whole Curve

- **OLS:** every curve chases whatever points it got. This is what _variance_ looks like!
- **Ridge:** misses some points (bias), but the curves agree far more (less variance)
  - Median SD across resamples: 5.05 (OLS) vs. 0.77 (Ridge)
- Both fall apart at the far left, where resamples that miss the leftmost points must extrapolate
- Regularization can't fix tiny data, but it makes the fit much less fragile
