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
- **The trade:** accept a little bias in exchange for a lot less variance
  - OLS is unbiased, but its estimates can swing wildly depending on the particular sample you got (remember the unusual points and the degree-9 polynomial?)
  - The penalty pulls estimates toward zero, which induces bias: you technically get "the wrong answer" when you go to interpret coefficients
  - You control how much bias you introduce through the strength of the penalty
- Upsides: Lots!
  - Helps models generalize to OOS data
  - Useful when you have multicollinearity
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
  - With a regularization penalty, switching between them just rescales $\lambda$ by $n$

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

<div v-click>

- So who wins?
  - It depends on $\lambda$, often called the _regularization parameter_
  - If $\lambda = 0$, there is no regularization, and we recover OLS exactly
  - For $\lambda > 0$, the optimization problem has to consider the size of $\beta$
  - As $\lambda \rightarrow \infty$, the only thing that matters is reducing the size of $\beta$ until $||\beta||_2 = 0$ 
  - The larger $\lambda$ is, the more $\beta$ is shrunk toward zero
  - This is how you control how much regularization (and how much bias) you induce

</div>

---
level: 3
layout: image-right
image: /normal.png
---


# The Ridge Penalty Puts a Normal Prior on $\beta$

- We think that the elements of $\beta$ should be normally distributed: $\beta_j \sim \mathcal{N}(0, \tau^2)$
- They are _most likely_ to be _nearly_ zero
- The Ridge estimate is the _posterior mode_ (MAP)
- $\lambda$ controls the _variance_ of the prior, $\lambda = \sigma^2/\tau^2$, so larger $\lambda$ means a smaller prior variance and more shrinkage toward zero
- When you get to multilevel models, think of random effects as similar to regularization!
- Typically, we pick $\lambda$ to maximize OOS performance (test set or cross-validation)

---
level: 3
---

# One Quick Note on Maximizing a Penalized Likelihood

- This is how we minimize squared error:

$$ \hat{\beta} =  \operatorname*{argmin}_{\beta} \sum_{i} \big(y_i - \mathbf{x}_i\beta \big)^2 + \lambda||\beta||^2_2 $$

- With normal errors, the log likelihood is $-\frac{1}{2\sigma^2}\sum_i \big(y_i - \mathbf{x}_i\beta\big)^2$ plus a constant, so (after rescaling $\lambda$) this is the same as maximizing:

$$ \hat{\beta} =  \operatorname*{argmax}_{\beta}\ -\sum_{i} \big(y_i - \mathbf{x}_i\beta \big)^2- \lambda||\beta||^2_2$$

- More generally, for _any_ model with log likelihood $\ell(\beta)$ (e.g., logistic regression, Poisson regression):

$$ \hat{\beta} =  \operatorname*{argmax}_{\beta}\ \ell(\beta) - \lambda \cdot \text{penalty}(\beta)$$

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

<v-clicks>

- Professor of Statistics and Biomedical Data Science at Stanford University
- Student of Bradley Efron
- Introduced the LASSO (1996)
- Co-developed Generalized Additive Models (GAMs) with Trevor Hastie
- Co-wrote _The Elements of Statistical Learning_ 
- Co-wrote _An Introduction to Statistical Learning_
- Used to play pickup basketball at the Stanford gym

</v-clicks>

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

<div v-click>

- So what changes?
  - Compare how hard each penalty pushes toward zero (its derivative):
    Ridge: $\frac{d}{d\beta}\beta^2 = 2\beta$ fades away as $\beta \rightarrow 0$, but LASSO: $\frac{d}{d\beta}|\beta| = \pm 1$ no matter how small $\beta$ gets
  - Ridge shrinks coefficients toward zero but (almost) never _exactly_ to zero, while LASSO forces some to be _precisely_ zero
  - This effectively drops variables with less predictive value from your model (which is the "selection" part of LASSO)
  - Higher values of $\lambda$ will tend to drop more variables

</div>

---
level: 3
layout: image-right
image: /laplace.png
---

# LASSO Penalty Puts a Laplace Prior on $\beta$

- We think that the elements of $\beta$ should be Laplace distributed
- The density is sharply peaked at zero, so the _posterior mode_ (the LASSO estimate) is often _exactly_ zero
- With enough evidence, coefficients can still take on any value
- $\lambda$ controls how aggressively coefficients are forced to be zero
- Again, pick $\lambda$ to maximize OOS performance (test set or cross-validation)

---
level: 3
---

# Penalized Regression in Practice

- **Standardize your predictors first!**
  - The penalty treats every coefficient the same, but a coefficient's size depends on the units of its predictor
  - Income in dollars vs. thousands of dollars would get penalized very differently
- **Don't penalize the intercept**
  - Shrinking the intercept toward zero just biases all of your predictions toward zero
- In R, `glmnet` does both of these by default (`standardize = TRUE`, unpenalized intercept)
  - `glmnet(X, y, alpha = 0)` is Ridge, `glmnet(X, y, alpha = 1)` is LASSO
  - `cv.glmnet()` picks $\lambda$ by cross-validation

---
level: 3
layout: image-right
image: /ridge-01.png
---

# Ridge Tames the Degree-9 Polynomial

```r
library(glmnet)

X <- poly(d$x, 9, raw = TRUE)
ridge <- glmnet(X, d$y, alpha = 0,
                lambda = 0.01)
```

- Same 10 points, same 9 polynomial terms
- $\lVert\beta\rVert_2$: 991 for OLS vs. 2.9 for Ridge
- Test MSE: 28.3 for OLS vs. 1.33 for Ridge
- Ridge doesn't hit every point (that's the bias), but it's much closer to the truth (the dashed line)
- With only 10 points, `cv.glmnet()` is too noisy to trust, so we picked $\lambda$ with a separate validation set
