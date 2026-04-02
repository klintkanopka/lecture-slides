---
level: 1
layout: section
---

# Latent Class Analysis

---
level: 2
---

# Latent Class Analysis

<v-clicks depth="2">

- People always ask if we can cluster directly on item responses
  - Why might this be a bad idea?
  - Distance-based clustering generally does a bad job with categorical data
- Latent class analysis (LCA) is soft clustering for categorical variables
  - LCA is another mixture model (like GMM)
  - Latent class assignments, $\theta_i$, are used to explain item response patterns
  - This ends up being especially useful with survey data and unordered categorical responses!
  - `poLCA` is a common package, but we will use [`glca`](https://cran.r-project.org/package=glca)

</v-clicks>

---
level: 3
---

# Model Structure

<v-clicks depth="2">

- LCA assumes local independence
  - Item responses are independent conditional on class membership
  - This is the same as IRT treating items as independent after conditioning on the latent ability, $\theta_i$

- With two classes ($t_1, t_2$) and two items ($i, j$):

</v-clicks>
<v-click>

$$p_{ij} = \pi_{t_1}p_{i,t_1}p_{j,t_1} + \pi_{t_2}p_{i,t_2}p_{j,t_2}$$

</v-click>
<v-clicks depth="2">

- Here:
  - $p_{ij}$ is the probability of observing a _specific_ pair of responses to items $i$ and $j$
  - $\pi_t$ is the probability of belonging to class $t$
  - $p_{i,t}$ is the probability of the observed response to item $i$, conditional on the respondent being in class $t$

</v-clicks>

---
level: 3
---

# More General Form

- For $T$ classes and $K$ items, the probability of an observed response pattern is:

$$p_i = \sum_{t=1}^T \pi_{it} \prod_{k=1}^K p_{ki,t}$$

<v-clicks depth="2">

- $p_i$ is the probability of observing person $i$'s exact string of responses to all $K$ items
- $\pi_{it}$ is the probability person $i$ belongs to class $t$
- $p_{ki,t}$ is the probability of observing person $i$'s exact response to item $k$ conditional on being in class $t$
- Estimation is usually done with the EM algorithm
- If you're familiar with Naive Bayes classification, this is the same setup and structural assumptions
  - The difference is that class membership is _latent_ rather than observed
  - The local independence assumption is the Naive Bayes assumption

</v-clicks>

---
level: 2
---

# The `glca` Package

- `glca()` fits a latent class model
  - `formula =` specifies items and any covariates
  - `data =` provides the dataset
  - `nclass =` sets the number of latent classes
- The left side of the formula contains manifest (or _observed_) items, usually wrapped in `item()`
- The right side can include covariates that may be related to class membership
- `gofglca()` compares model fit across candidate solutions
- `plot()` methods exist for `glca` objects
  - They are useful even if they are not beautiful
