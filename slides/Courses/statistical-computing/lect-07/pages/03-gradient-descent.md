---
level: 1
layout: section
---

# Algorithm: Gradient Descent

---
level: 3
layout: image
image: /quadratic-01.png
---


---
level: 3
---

# Gradient Descent

- Big idea: To find the minimum value of a function, we move downhill until we get to the bottom
- Algorithm: To find the argmin of a function $f$ given parameter values $\theta_n$ at iteration $n$, and step size $\lambda$:
  1. Compute the gradient of $f$ with respect to $\theta_n$
  2. Find the next parameter values, $\theta_{n+1}$, according to the update rule:
    - $\theta_{n+1} \leftarrow \theta_n - \lambda \nabla f$
  3. Repeat 1&2 until convergence
- What actually happens: Starting at some guess, use the gradient to repeatedly take steps “downhill” until you hit the bottom


---
level: 3
layout: image
image: /quadratic-01.png
---

<arrow v-click x1="106" y1="32" x2="190" y2="194" width="2" color="#56B4E9"/>
<arrow v-click x1="190" y1="194" x2="270" y2="315" width="2" color="#56B4E9"/>
<arrow v-click x1="270" y1="315" x2="340" y2="393" width="2" color="#56B4E9"/>
<arrow v-click x1="340" y1="393" x2="400" y2="440" width="2" color="#56B4E9"/>
<arrow v-click x1="400" y1="440" x2="450" y2="464" width="2" color="#56B4E9"/>
<arrow v-click x1="450" y1="464" x2="490" y2="474" width="2" color="#56B4E9"/>
<arrow v-click x1="490" y1="474" x2="505" y2="475" width="2" color="#56B4E9"/>
<arrow v-click x1="505" y1="475" x2="518" y2="476" width="2" color="#56B4E9"/>



---
level: 3
---

# The OLS Loss Function

- So how do we write a loss function?
- Frame your solution as a minimization problem
  - Note that if you want to maximize something, it's the same as minimizing the negative of that thing
- Recall that OLS attempts to minimize the sum of squared residuals
  - For OLS with a single covariate $x$, outcome $y$, and coefficients, $\beta_0,\beta_1$, write down the sum of squared residuals
  - Then how do we express that we want to minimize? What do we minimize with respect to?
  - What does this give us?
 


---
level: 3
---

# The OLS Loss Function

Set up the problem:

$$ \underbrace{\sum_{x_i, y_i \in \mathbf{X}} \big(y_i - (\beta_0 + \beta_1 x_i) \big)^2 }_{\text{The sum of squared residuals}}$$

---
level: 3
---

# The OLS Loss Function

Set up the problem:

$$ \underbrace{\operatorname*{argmin}_{\beta}}_{\text{Find }\beta\text{ that minimizes}} \underbrace{\sum_{x_i, y_i \in \mathbf{X}} \big(y_i - (\beta_0 + \beta_1 x_i) \big)^2 }_{\text{The sum of squared residuals}}$$

---
level: 3
---

# The OLS Loss Function

Set up the problem:

$$ \underbrace{\hat{\beta}}_{\text{Estimated coefficients}} =  \underbrace{\operatorname*{argmin}_{\beta}}_{\text{Find }\beta\text{ that minimizes}} \underbrace{\sum_{x_i, y_i \in \mathbf{X}} \big(y_i - (\beta_0 + \beta_1 x_i) \big)^2 }_{\text{The sum of squared residuals}}$$
 

---
level: 3
---

# Gradient Descent with OLS

- We start with our loss function:

$$ \ell(\mathbf{X}, \beta) = \sum_{x_i, y_i \in \mathbf{X}} \big(y_i - (\beta_0 + \beta_1 x_i) \big)^2$$

<div v-click>

- Now we need to take the gradient wrt the parameters we optimize over:

$$ \nabla \ell(\mathbf{X}, \beta) = \begin{bmatrix} \frac{\partial \ell}{\partial \beta_0} \\ \frac{\partial \ell}{\partial \beta_1} \end{bmatrix}$$

</div>

<div v-click>

- The gradient:

$$ \nabla \ell(\mathbf{X}, \beta) = \begin{bmatrix} \frac{\partial \ell}{\partial \beta_0} \\ \frac{\partial \ell}{\partial \beta_1} \end{bmatrix} = \begin{bmatrix} \sum_{x_i, y_i \in \mathbf{X}} -2\big(y_i - (\beta_0 + \beta_1 x_i)\big) \\ \sum_{x_i, y_i \in \mathbf{X}} -2x_i\big(y_i - (\beta_0 + \beta_1 x_i)\big)\end{bmatrix}$$

</div>


---
level: 3
---

# Gradient Descent with OLS

<v-clicks>

- Next we pick a step size, $\lambda$
  - Smaller values of $\lambda$ result in a more precise solution, but slower convergence time
  - Larger values of $\lambda$ are less precise but converge faster
  - If you make $\lambda$ too large, the optimization may become unstable and never converge! 
- Initialize starting values for your parameters
  - Lots of choices! Start at zero? Pick randomly? 
- Update your parameters:
  - Recall $\theta_{n+1} \leftarrow \theta_n - \lambda \nabla f$
  - $\hat{\beta}_{0, n+1} \leftarrow \hat{\beta}_{0, n} + 2\lambda \sum_{x_i, y_i \in \mathbf{X}} \big(y_i - (\hat{\beta}_{0,n} + \hat{\beta}_{1,n} x_i)\big)$
  - $\hat{\beta}_{1, n+1} \leftarrow \hat{\beta}_{1, n} + 2\lambda \sum_{x_i, y_i \in \mathbf{X}} x_i \big(y_i - (\hat{\beta}_{0,n} + \hat{\beta}_{1,n} x_i)\big)$

</v-clicks>
  
  
---
level: 3
---

# Simulating some OLS data 

````md magic-move
```r
set.seed(242424)

N <- 1e3
true_beta <- c(2.718, -2.718)

d <- data.frame(x = rnorm(N))
d$y <- true_beta[1] + true_beta[2] * d$x + rnorm(N)

ols <- lm(y ~ x, d)
ols_beta <- coef(ols)
ols_beta

```
```r
set.seed(242424)

N <- 1e3
true_beta <- c(2.718, -2.718)

d <- data.frame(x = rnorm(N))
d$y <- true_beta[1] + true_beta[2] * d$x + rnorm(N)

ols <- lm(y ~ x, d)
ols_beta <- coef(ols)
ols_beta

# (Intercept)           x 
#    2.783908   -2.686621 
```
````
  
---
level: 3
layout: image-right
image: /ols-01.png
---

# Simulating some OLS data

```r
ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.5) +
  theme_bw()
```

---
level: 3
---

# Implementing the Gradient Descent Update

````md magic-move
```r

lr <- 1e-4
beta <- c(0, 0)

```
```r

lr <- 1e-4
beta <- c(0, 0)

beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))

```
```r

lr <- 1e-4
beta <- c(0, 0)

beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

```

```r

lr <- 1e-4
beta <- c(0, 0)

beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

beta

# [1]  0.5407162 -0.5354659

```
```r

lr <- 1e-4
beta <- c(0, 0)

beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

beta

# [1]  0.5407162 -0.5354659

beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))
```
```r

lr <- 1e-4
beta <- c(0, 0)

beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

beta

# [1]  0.5407162 -0.5354659

beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

beta

# [1]  0.9764911 -0.9641414
```
````

---
level: 3
---

# How long until convergence? $\lambda = 10^{-4}$

```r
M <- 1e2
lr <- 1e-4
beta <- c(0, 0)
betas <- data.frame(i = 1:M, beta_0 = numeric(M), beta_1 = numeric(M))

for (i in 1:M) {
  beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
  beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

  betas$beta_0[i] <- beta[1]
  betas$beta_1[i] <- beta[2]
}

beta

# [1]  2.783908 -2.686621

```

---
level: 3
layout: image-right
image: /ols-02.png
---

# $\lambda = 10^{-4}$

```r
ggplot(betas, aes(x = i)) +
  geom_line(aes(y = beta_0), 
            color = okabeito_colors(1)) +
  geom_line(aes(y = beta_1), 
            color = okabeito_colors(2)) +
  geom_point(aes(y = beta_0), 
             size = 0.5, 
             color = okabeito_colors(1)) +
  geom_point(aes(y = beta_1), 
             size = 0.5, 
             color = okabeito_colors(2)) +
  geom_hline(aes(yintercept = true_beta[1]),
             lty = 2, 
             alpha = 0.5) +
  geom_hline(aes(yintercept = true_beta[2]),
                 lty = 2, 
                 alpha = 0.5) +
  labs(x='Gradient Descent Iteration', 
       y = 'beta') +
  theme_bw()
```

---
level: 3
---

# What about a faster learning rate? $\lambda = 10^{-3}$

```r
M <- 1e2
lr <- 1e-3
beta <- c(0, 0)
betas <- data.frame(i = 1:M, beta_0 = numeric(M), beta_1 = numeric(M))

for (i in 1:M) {
  beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
  beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

  betas$beta_0[i] <- beta[1]
  betas$beta_1[i] <- beta[2]
}

beta

# [1] -35.335523  -8.404527

```

---
level: 3
layout: image-right
image: /ols-03.png
---

# $\lambda = 10^{-3}$

```r
ggplot(betas, aes(x = i)) +
  geom_line(aes(y = beta_0), 
            color = okabeito_colors(1)) +
  geom_line(aes(y = beta_1), 
            color = okabeito_colors(2)) +
  geom_point(aes(y = beta_0), 
             size = 0.5, 
             color = okabeito_colors(1)) +
  geom_point(aes(y = beta_1), 
             size = 0.5, 
             color = okabeito_colors(2)) +
  geom_hline(aes(yintercept = true_beta[1]),
             lty = 2, 
             alpha = 0.5) +
  geom_hline(aes(yintercept = true_beta[2]),
                 lty = 2, 
                 alpha = 0.5) +
  labs(x='Gradient Descent Iteration', 
       y = 'beta') +
  theme_bw()
```

---
level: 3
---

# What about a slower learning rate? $\lambda = 10^{-5}$

```r
M <- 1e2
lr <- 1e-5
beta <- c(0, 0)
betas <- data.frame(i = 1:M, beta_0 = numeric(M), beta_1 = numeric(M))

for (i in 1:M) {
  beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
  beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

  betas$beta_0[i] <- beta[1]
  betas$beta_1[i] <- beta[2]
}

beta

# [1]  2.392762 -2.323370

```

---
level: 3
layout: image-right
image: /ols-04.png
---

# $\lambda = 10^{-5}$

```r
ggplot(betas, aes(x = i)) +
  geom_line(aes(y = beta_0), 
            color = okabeito_colors(1)) +
  geom_line(aes(y = beta_1), 
            color = okabeito_colors(2)) +
  geom_point(aes(y = beta_0), 
             size = 0.5, 
             color = okabeito_colors(1)) +
  geom_point(aes(y = beta_1), 
             size = 0.5, 
             color = okabeito_colors(2)) +
  geom_hline(aes(yintercept = true_beta[1]),
             lty = 2, 
             alpha = 0.5) +
  geom_hline(aes(yintercept = true_beta[2]),
                 lty = 2, 
                 alpha = 0.5) +
  labs(x='Gradient Descent Iteration', 
       y = 'beta') +
  theme_bw()
```


---
level: 3
---

# When do you stop?

- The _easiest_ way to do it is just pick a number of iterations and then stop
  - You may not reach the solution
  - You may take too many iterations that you didn’t need to
- Typically we stop when the solution _converges_
  - Often this looks like picking a threshold value, $\epsilon$
  - After every iteration, check to see how much the estimate has changed by
  - Stop when the change in parameter estimates is smaller than the threshold
  - Lets you set the level of precision you want in your answer
  - If your threshold is too small relative to the step size, the optimization routine may never converge