

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

<v-clicks>

- Invented the bootstrap in 1982
- One of the first major computationally intensive statistical techniques 
- His list of awards is insane
  - MacArthur Prize Fellowship
  - Membership in the National Academy of Sciences and the American Academy of Arts and Sciences
  - Fellowship in the Institute of Mathematical Statistics (IMS) and the American Statistical Association (ASA) 
  - The Lester R. Ford Award, the Wilks Medal, the Parzen Prize, and the Rao Prize
  - National Medal of Science, the highest scientific honor by the United States
  - The Guy Medal in Gold
  - The International Prize in Statistics
- Certified badass
- Advised Rob Tibshirani
- Still at Stanford! 

</v-clicks>

---
level: 3
---

# The Bootstrap

- It works for basically anything!
- Your data describes an _empirical distribution function_ - this is an approximation of the cumulative distribution function (CDF)
- The empirical distribution function (eCDF) converges to the CDF
- The bootstrap uses resampling with replacement to build new eCDFs
- Because we resample with replacement, we can have many more eCDFs _with the same sample size as the original data_ than the jackknife 
- Data are guaranteed to be drawn from the population of interest!
- Often used for bias, variance, and constructing confidence intervals
- Does not require the CLT to apply to your estimator!

---
level: 3
---

# How to Bootstrap

1. Compute your estimate in the full sample with $N$ observations
2. Draw $M$ bootstrap samples, each of length $N$, from the original dataset _with replacement_
3. Compute your estimate on each bootstrap sample
4. Use the distribution of bootstrap estimates to:
  - Check the original estimate for bias (using the mean value)
  - Find the variance of a standard error of the estimate (using the variance or sd)
  - Construct a confidence interval (by looking at the end points of the middle 95% of the distribution of bootstrap estimates)
  
  
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

N_boot <- 1e6
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

N_boot <- 1e6
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
    size = 2,
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

# Applied Boostrapping

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