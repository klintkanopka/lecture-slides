---
level: 1
layout: section
---

# Exponential Family

---
level: 2
hideInToc: true
---

# Why We Care

- GLMs are built around outcome distributions from the exponential family
- This is what lets us move beyond Gaussian outcomes
- If a distribution can be written in exponential-family form, it becomes a candidate for a GLM-based regression model


---
level: 2
---

# Exponential Family Form

For a parameter vector $\theta$, a distribution is in the exponential family if:

$$
f_X(x \mid \theta) =
h(x)\exp\left[\eta(\theta)\cdot T(x) - A(\theta)\right]
$$

<v-clicks depth='2'>

- $\eta(\theta)$ is the _natural parameter_
  - If $\eta(\theta) = \theta$, the distribution is said to be in _canonical form_
- $T(x)$ is a _sufficient statistic_
  - This is a summary of the data that contains all the information needed to estimate a parameter
- $A(\theta)$ is the _log-partition function_
  - This is the log of a normalization factor to guarantee $f_X(x\mid\theta)$ is a valid probability distribution
- $h(x)$ collects terms that depend only on the observed data

</v-clicks>

---
level: 2
---

# Bernoulli as Exponential Family

The Bernoulli PMF is:

$$
f(x) = p^x(1-p)^{1-x}
$$

<v-click>

Rewrite it as:

$$
f(x) = 1 \cdot \exp\left[x \log\left(\frac{p}{1-p}\right) + \log(1-p)\right]
$$

</v-click>

<v-clicks>

- $h(x) = 1$
- $T(x) = x$
- $\eta(p) = \log\left(\frac{p}{1-p}\right)$
- $A(p) = -\log(1-p)$

</v-clicks>

---
level: 2
---

# Common Exponential Family Distributions

<v-clicks depth="2">

- Common examples:
  - Gaussian
  - Bernoulli
  - Poisson
  - Gamma
  - Exponential
  - Categorical
- Conditional examples:
  - Binomial, if the number of trials is fixed
  - Multinomial, if the number of trials is fixed
  - Negative binomial, if one parameter is fixed
- Practical takeaway:
  - GLMs are flexible because the exponential family is huge

</v-clicks>
