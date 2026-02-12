---
level: 1
layout: section
---

# Extensions of IRT Models

---
level: 2
hideInToc: true
---

# Multidimensional IRT Models

- What happens when we think that our items are measuring more than one thing?
- Multiple factors in an instrument imply multidimensionality
- How might we modify an IRT model to include multidimensionality?

---
level: 3
---

# Multidimensional IRT Models

- The 2F2PL:

$$P(X_{ij} = 1) = \frac{1}{1 + e^{-(a_{1j}\theta_{1i} + a_{2j}\theta_{2i} + b_j)}}$$


  - Two factors, two _types_ of item parameters (discriminations and difficulty), logistic link function
- If we have 10 two factor items and 100 respondents, how many total parameters will we estimate?

<v-clicks>

  - 30 total item parameters
  - Actually fewer (27) because of identification assumptions
  - 200 total person parameters

</v-clicks>
  
---
level: 3
---

# Multidimensional IRT Models

- This is the general form of a multidimensional IRT model with $K$ factors  $\{\theta_1, \ldots, \theta_K\}$

$$P(X_{ij} = 1) = \frac{1}{1 + e^{-(b_j + \sum_{k=1}^K a_{kj}\theta_{ki})}}$$


- These models can be tricky to estimate and have convergence issues!
  - `mirt` will fit an exploratory IRT model if you ask it to
  - In practice, fit an exploratory factor analysis first
  - Treat the subsequent IRT model as _confirmatory_ (i.e., evaluate the fit of our model on real data)
  - Constrain some of the $a_{ki} = 0$ based on your preferred solution
  - You specify this in the `mirt.model` syntax
  - Adding priors on item parameters, increasing `NCYCLES` to allow more estimation iterations, and increasing `quadpts` to get better numerical precision can also help here

---
level: 3
---

# Compensatory and Non-Compensatory IRT Models

- This model is _compensatory_; Higher levels of one $\theta$ can compensate for lower levels of another $\theta$

$$P(X_{ij} = 1) = \frac{1}{1 + e^{-(b_j + \sum_{k=1}^K a_{kj}\theta_{ki})}}$$


<v-click>

- This is the most straightforward _non-compensatory_ model; How does it work?

$$P(X_{ij} = 1) = \prod_{k=1}^K \frac{1}{1 + e^{-a_{kj}(\theta_{ki}-b_{kj})}}$$



</v-click>
<v-click>

- The total response probability is always constrained by the weakest latent trait!

</v-click>


---
level: 3
---

# Estimation with `lme4`

- The `lme4` package can estimate Rasch-type models really easily!
  - No models with discrimination parameters, however!
- `m <- glmer(resp ~ (1|id) + item, data=d, family='binomial')`
  - Requires long form data
  - Of the type we get in the IRW!
- What do we consider to be fixed and random effects here?
  - What does having a random effect do?

---
level: 3
---

# Explanatory item response models

- Sometimes we have other features that we think matter for the item response!
  - Often these are features of the item or situation
  - These could be person-level covariates
- We think these features _explain_ something about the response process
- These models are _very_ easy to fit with `lme4`
- These models are less easy to fit using `mirt`, but it works
  - `mirt` handles this through the `covdata` and `formula` argument to relate covariates to the latent traits (latent regression; not explanatory)
  - You can also use the `item.formula` argument to decompose item difficulties as a function of covariates (explanatory model)
- Let's say we think log response time, $\log t_{ij}$ is related to the observed item response and we want to fit a 2PL, what would the $P(X_{ij} = 1|\theta_i, t_{ij})$ function look like?


---
level: 3
---

# Explanatory item response models

-  An explanatory model with response time

$$P(X_{ij} = 1|\theta_i, t_{ij}) = \frac{1}{1 + e^{-(a_{j}\theta_{i} + b_j + \beta_j\log t_{ij})}}$$

- What would it mean if $\beta_j > 0$? Or $\beta_j < 0$?
- How does this change our interpretation of $b_j$?

