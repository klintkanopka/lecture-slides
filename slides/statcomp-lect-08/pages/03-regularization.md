---
level: 1
layout: section
---

# Dealing with Overfitting

---
level: 3
---

# Regularization

<v-clicks>

- **Core Idea:** Regularization adds a penalty to your loss function (or likelihood) when you go to estimate your parameters that helps to fight against overfitting
- Downside: Induces some bias in your parameter estimates
  - This means you technically get "the wrong answer" when you go to interpret coefficients
  - You can control how much bias you introduce, however!
- Upsides: Lots!
  - Helps models generalize to OOS data
  - Useful when you have multicolinearity
  - Can allow you to estimate models that would be otherwise unidentified
  - Easy to implement
  - Works with (almost) any type of model

</v-clicks>

---
level: 3
layout: image-right
image: /tikhonov.jpg
---

# Andrey Tikhonov (1906-1993)

<v-clicks>

- Soviet mathematician
- Active in topology and mathematical physics (among other things)
- Recipient of the Lenin Prize (1966)
- Twice named Hero of Socialist Labor (1954, 1986)

</v-clicks>

---
level: 2
---


# Ridge Regression

- **Core Idea:** We will conduct a linear regression, but add a penalty proportional to the $L^2$ norm of the vector of coefficients, $\beta$
- This type of penalty is called the Ridge Penalty, Ridge Regularization, or $L^2$ Regularization
- Not just useful for linear regressions!
- Recall the OLS loss function that minimizes the squared error:

$$ \hat{\beta} =  \operatorname*{argmin}_{\beta} \sum_{\mathbf{x}_i, y_i \in \mathbf{X}} \big(y_i - \mathbf{x}_i\beta \big)^2 $$

<div v-click>

- Now we add the Ridge penalty:

$$ \hat{\beta} =  \operatorname*{argmin}_{\beta} \sum_{\mathbf{x}_i, y_i \in \mathbf{X}} \big(y_i - \mathbf{x}_i\beta \big)^2 \underbrace{+ \lambda||\beta||^2_2}_\text{Ridge Penalty} $$

- Note that minimizing the SSE is the same as minimizing the MSE!

</div>

---
level: 3
---

# Ridge Regression
 
- Recall the loss function: 

$$ \hat{\beta} =  \operatorname*{argmin}_{\beta} \sum_{\mathbf{x}_i, y_i \in \mathbf{X}} \big(y_i - \mathbf{x}_i\beta \big)^2 \underbrace{+ \lambda||\beta||^2_2}_\text{Ridge Penalty} $$

- So what happens here?
  - The left part of the argmin tries to minimize the MSE
  - The right part tries to minimize the length of the vector $\beta$
- So who wins?
  - It depends on $\lambda$, often called the _regularization parameter_
  - If $\lambda = 0$, there is no regularization, and we recover OLS exactly
  - For $\lambda > 0$, the optimization problem has to consider the size of $\beta$
  - As $\lambda \rightarrow \infty$, the only thing that matters is reducing the size of $\beta$ until $||\beta||_2 = 0$ 
  - The larger $\lambda$ is, the more $\beta$ is shrunk toward zero
  - This is how you control how much regularization (and how much bias) you induce


---
level: 3
layout: image-right
image: /normal.png
---


# The Ridge Penalty Puts a Normal Prior on $\beta$

- We think that the elements of $\beta$ should be normally distributed
- They are _most likely_ to be _nearly_ zero
- The value of $\lambda$ controls how much shrinkage toward zero is experienced
- Another way to think about $\lambda$ is that it controls the _variance_ of the normal prior
- When you get to multilevel models, think of random effects as similar to regularization!
- Typically, we pick $\lambda$ to maximize OOS predictive performance, either by holding out a _test set_ or through cross-validation

---
level: 3
---

# One Quick Note on Maximizing a Penalized Likelihood

- This is how we minimize squared error:

$$ \hat{\beta} =  \operatorname*{argmin}_{\beta} \sum_{i} \big(y_i - \mathbf{x}_i\beta \big)^2 + \lambda||\beta||^2_2 $$

- This is how we maximize the log likelihood:

$$ \hat{\beta} =  \operatorname*{argmax}_{\beta}\ -\sum_{i} \big(y_i - \mathbf{x}_i\beta \big)^2- \lambda||\beta||^2_2$$

---
level: 3
---

# What about other types of regularization?

- Remember that we said overfitting occurs if your parameters are too big or if you have too many
- Ridge only solves the first problem. What about the second?
- Turns out, we can do this using Least Absolute Shrinkage and Selection Operator (LASSO)
- This is implemented through another penalized loss function

---
level: 3
layout: image-right
image: /tibshirani.jpg
---

# Robert Tibshirani (born 1956)

- Professor of Statistics at Stanford University
- Student of Bradley Efron
- Invented Generalized Additive Models (GAMs)
- Wrote _The Elements of Statistical Learning_ 
- Wrote _An Introduction to Statistical Learning_ 

---
level: 2
---

# LASSO Regression

- **Core Idea:** We will conduct a linear regression, but add a penalty proportional to the $L^1$ norm of the vector of coefficients, $\beta$
- This type of penalty is called the LASSO Penalty, LASSO Regularization, or $L^1$ Regularization
- Still not just useful for linear regressions!
- Recall the OLS loss function that minimizes the squared error:

$$ \hat{\beta} =  \operatorname*{argmin}_{\beta} \sum_{\mathbf{x}_i, y_i \in \mathbf{X}} \big(y_i - \mathbf{x}_i\beta \big)^2 $$

- Now we add the LASSO penalty:

$$ \hat{\beta} =  \operatorname*{argmin}_{\beta} \sum_{\mathbf{x}_i, y_i \in \mathbf{X}} \big(y_i - \mathbf{x}_i\beta \big)^2 \underbrace{+\lambda||\beta||_1}_\text{LASSO Penalty} $$

---
level: 3
---

# LASSO Regression

$$ \hat{\beta} =  \operatorname*{argmin}_{\beta} \sum_{\mathbf{x}_i, y_i \in \mathbf{X}} \big(y_i - \mathbf{x}_i\beta \big)^2 \underbrace{+\lambda||\beta||_1}_\text{LASSO Penalty}  $$

- So what happens here?
  - The left part of the argmin tries to minimize the MSE
  - The right part tries to minimize the length of the vector $\beta$, but in kind of a different way from the Ridge penalty!
- So what changes?
  - Note that as $\beta,\epsilon \rightarrow 0$, $|\beta + \epsilon| - |\beta| > (\beta + \epsilon)^2 - \beta^2$
  - This gives a loss function with a LASSO penalty extra incentive to force some coefficients to be zero!
  - The Ridge penalty will uniformly shrink coefficients toward zero, while the LASSO penalty will force some number of coefficients to be _precisely_ zero
  - This effectively drops variables with less predictive value from your model (which is the "selection" part of LASSO)
  - Higher values of $\lambda$ will drop more variables


---
level: 3
layout: image-right
image: /laplace.png
---

# LASSO Penalty Puts a Laplace Prior on $\beta$

- This means we think that the elements of $\beta$ should be Laplace distributed
- This means they are _most likely_ to be _exactly_ zero, but with enough evidence they can take on any value
- The value of $\lambda$ controls how aggressively coefficients are forced to be zero
- Again, we pick the $\lambda$ value to maximize OOS predictive performance, either by holding out a _test set_ of some data or through cross-validation
