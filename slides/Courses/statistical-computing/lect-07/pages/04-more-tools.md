---
level: 1
layout: section
transition: fade
---

# More Tools

---
level: 2
layout: section
---

# Maximum Likelihood Estimation

---
level: 3
---

# Maximum Likelihood Estimation

- A linear regression assumes normally distributed error with constant error variance, or:

$$ y_i \sim \mathcal{N}\big(\beta_0 + \beta_1x_i, \sigma^2\big)$$

<div v-click>

- We can write down the _likelihood_ (think Bayes' theorem) of observing a set of parameters conditioned on our observed data by multiplying together the normal density functions for each observation:

$$ L(\beta | \mathbf{X}) = \prod_{y_i, x_i \in \mathbf{X}} \frac{1}{\sigma\sqrt{2\pi}} e^{-\frac{1}{2}\big(\frac{y_i - (\beta_0 + \beta_1x_i)}{\sigma}\big)^2}$$

</div v-click>

---
level: 3
---

# Log Transformin'


- We can make our lives way easier with a log transform! Why?

<v-clicks>

- Multiplying lots of probabilities results in numerical instability by ending up with tiny numbers!
- The log transform can turn these products into a sum!

</v-clicks>

<div v-click>

$$ \log \prod_{y_i, x_i \in \mathbf{X}} \frac{1}{\sigma\sqrt{2\pi}} e^{-\frac{1}{2}\big(\frac{y_i - (\beta_0 + \beta_1x_i)}{\sigma}\big)^2} = \sum_{y_i, x_i \in \mathbf{X}}\log\frac{1}{\sigma\sqrt{2\pi}} e^{-\frac{1}{2}\big(\frac{y_i - (\beta_0 + \beta_1x_i)}{\sigma}\big)^2}$$

</div>

<div v-click>

$$  = \sum_{y_i, x_i \in \mathbf{X}}\log\frac{1}{\sigma\sqrt{2\pi}} + \log e^{-\frac{1}{2}\big(\frac{y_i - (\beta_0 + \beta_1x_i)}{\sigma}\big)^2}$$

</div>

<div v-click>

$$  = \sum_{y_i, x_i \in \mathbf{X}}\log\frac{1}{\sigma\sqrt{2\pi}} -\frac{1}{2}\bigg(\frac{y_i - (\beta_0 + \beta_1x_i)}{\sigma}\bigg)^2$$

</div>

---
level: 3
---

# Maximum (Log) Likelihood Estimation

- Maximum Likelihood Estimation (MLE) is just finding the values of your parameters that maximize the likelihood
- Because the log transform is monotonic, we can just maximize the log likelihood instead

$$\ell(\theta | \mathbf{X}) = \log L(\theta|\mathbf{X})$$
$$\hat{\theta}  = \operatorname*{argmax}_{\theta} L(\theta | \mathbf{X}) = \operatorname*{argmax}_{\theta} \ell(\theta | \mathbf{X})$$

- We have a few options on how this works: 

<v-clicks>

  1. Take the gradient of the log likelihood and set it equal to zero to find the estimates $\hat{\theta}$ analytically
  2. Use numerical optimization
  3. Some secret third thing that we haven't really discussed yet

</v-clicks>

---
level: 3
---

# MLE for OLS

$${all|1|2|3|4|all}
\begin{aligned}
\hat{\beta}  &= \operatorname*{argmax}_{\beta} \bigg[\sum_{y_i, x_i \in \mathbf{X}}\log\frac{1}{\sigma\sqrt{2\pi}} -\frac{1}{2}\bigg(\frac{y_i - (\beta_0 + \beta_1x_i)}{\sigma}\bigg)^2\bigg] \\
\hat{\beta}  &= \operatorname*{argmax}_{\beta} \bigg[N \log\frac{1}{\sigma\sqrt{2\pi}} -\frac{1}{2\sigma^2} \sum_{y_i, x_i \in \mathbf{X}}  \big(y_i - (\beta_0 + \beta_1x_i)\big)^2 \bigg] \\
\hat{\beta}  &= \operatorname*{argmax}_{\beta}\bigg[ \underbrace{N \log\frac{1}{\sigma\sqrt{2\pi}}}_{\text{Constant}} -\underbrace{\frac{1}{2\sigma^2}}_{\text{Constant}} \sum_{y_i, x_i \in \mathbf{X}}  \big(y_i - (\beta_0 + \beta_1x_i)\big)^2 \bigg] \\
\hat{\beta}  &= \operatorname*{argmax}_{\beta} \bigg[ - \sum_{y_i, x_i \in \mathbf{X}}  \big(y_i - (\beta_0 + \beta_1x_i)\big)^2 \bigg]
\end{aligned}
$$

<v-clicks>

- Does this last line look familiar?

</v-clicks>

---
level: 3
---

# MLE for OLS

$$
\hat{\beta}  = \operatorname*{argmin}_{\beta}  \sum_{y_i, x_i \in \mathbf{X}}  \big(y_i - (\beta_0 + \beta_1x_i)\big)^2 
$$

- The MLE for OLS is identical to minimizing the sum of squared residuals
- This is not always the case for other estimators, though!
- Now we have to actually minimize it---for this, we'll use `optim()`

---
level: 2
layout: section
---

# `optim()`

---
level: 3
---

# All hail the greatest built-in function in base `R`, `optim()`

- `optim()` is a general purpose optimization function in `R`
- It has a bunch of different optimization methods and is used by just about every single modeling function under the hood
- `optim()` specifically does **argmin**
  - You write a function that takes parameters as inputs
  - You give `optim()` starting values for those parameters (as a vector) and the function to be argmin'd
  - `optim()` returns the values of the parameters that minimize the function
- **If you can write something as a maximization or minimization problem, `optim()` can solve it for you**
  - Caveats about convexity and identifiability and some other stuff

---
level: 3
---

# MLE with optim() for OLS
````md magic-move

```r

SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  return(ssr)
}

```
```r

SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  
  return(ssr)
}
```

```r

SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)

  return(ssr)
}

```

```r
SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)
  
  return(ssr)
}

SumSquaredResid(c(0,0), d)

```
```r
SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)
  
  return(ssr)
}

SumSquaredResid(c(0,0), d)

# [1] 15666.95

```
```r
SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)

  return(ssr)
}

SumSquaredResid(c(0,0), d)

# [1] 15666.95

out <- optim()

```
```r
SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)

  return(ssr)
}

SumSquaredResid(c(0,0), d)

# [1] 15666.95

out <- optim(c(0,0), SumSquaredResid, d=d)

```
```r
SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)

  return(ssr)
}

SumSquaredResid(c(0,0), d)

# [1] 15666.95

out <- optim(c(0,0),          # starting vals for parameters
             SumSquaredResid, # fn to minimize
             d=d)             # args to pass to fn

```
```r
SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)

  return(ssr)
}

SumSquaredResid(c(0,0), d)

# [1] 15666.95

out <- optim(c(0,0),          # starting vals for parameters
             SumSquaredResid, # fn to minimize
             d=d)             # args to pass to fn

# pass control=list(scale=-1) to make optim argmax
```
```r
SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)

  return(ssr)
}

SumSquaredResid(c(0,0), d)

# [1] 15666.95

out <- optim(c(0,0),          # starting vals for parameters
             SumSquaredResid, # fn to minimize
             d=d)             # args to pass to fn

# pass control=list(scale=-1) to make optim argmax

mle_beta <- out$par  

```
```r
SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)

  return(ssr)
}

SumSquaredResid(c(0,0), d)

# [1] 15666.95

out <- optim(c(0,0),          # starting vals for parameters
             SumSquaredResid, # fn to minimize
             d=d)             # args to pass to fn

# pass control=list(scale=-1) to make optim argmax

mle_beta <- out$par  

mle_beta

```
```r
SumSquaredResid <- function(beta, d){
  # TODO: Compute sum of squared residuals
  resid <- d$y - (beta[1] + beta[2]*d$x)
  ssr <- sum(resid^2)

  return(ssr)
}

SumSquaredResid(c(0,0), d)

# [1] 15666.95

out <- optim(c(0,0),          # starting vals for parameters
             SumSquaredResid, # fn to minimize
             d=d)             # args to pass to fn

# pass control=list(scale=-1) to make optim argmax

mle_beta <- out$par  

mle_beta

# [1]  2.784030 -2.686716

```
````


---
level: 3
---

# Checking results

````md magic-move
```r
true_beta
ols_beta
gd_beta
mle_beta
```
```r
true_beta

# [1]  2.718 -2.718

ols_beta
gd_beta
mle_beta
```
```r
true_beta

# [1]  2.718 -2.718

ols_beta

# (Intercept)           x 
#    2.783908   -2.686621 

gd_beta
mle_beta
```
```r
true_beta

# [1]  2.718 -2.718

ols_beta

# (Intercept)           x 
#    2.783908   -2.686621 

gd_beta

# [1]  2.783908 -2.686621

mle_beta
```
```r
true_beta

# [1]  2.718 -2.718

ols_beta

# (Intercept)           x 
#    2.783908   -2.686621 

gd_beta

# [1]  2.783908 -2.686621

mle_beta

# [1]  2.784030 -2.686716
```
````

---
level: 3
---

# Some notes on `optim()`

- The function you minimize needs to output only a single scalar value
- The first argument of the function you minimize needs to be all the parameters you want to optimize, passed as a vector
- There are a whole bunch of options you can fiddle with in order to change convergence conditions, speed, or optimization algorithm
- If you make a function that also returns the gradient, you can gain a lot of speed and precision!
- Works best with _convex_ problems
  - Otherwise you can get stuck in local minima!
  - If you can't be convex, just start from a bunch of random spots and take the best solution
  - If your problem involves finding where a function is equal to zero, squaring it and finding the minimum will do the job!