---
level: 1
layout: section
transition: fade
---

# Mixed Subjects with Latent Variable Models

---
level: 2
---

# Mixed Subjects in Item Response Theory

<v-clicks depth="2">

- The most obvious application is for item calibration
  - Large pools of items require large pools of respondents
  - Good pilots can be expensive to run
  - LLMs are cheap
- Here’s the strategy:
  - Develop items
  - Pilot them with $n$ human respondents
  - Use an LLM to generate $N \gg n$ sets of new responses
  - Estimate item parameters in each sample with standard IRT software
  - Use PPI++ to combine the two data sources and construct adjusted item parameter estimates
  - More precisely estimated item parameters mean less measurement error in the operational form

</v-clicks>


---
level: 2
---

# Latent Variables Complicate the Setup

<v-clicks depth="2">

- Responses need to be sampled from the same ability distribution as human responses
  - This is potentially _very_ tricky!
  - Requires potentially nuanced and complex prompting strategies
- Everything so far has been framed in terms of independent variables and dependent variables
  - In IRT applications, our independent variables are latent
  - Even when we have estimates of them, they’re still derived from the model we’re trying to estimate parameters for, so they’re not actually independent
- Power tuning is going to be a mess
  - Standard errors of item parameters are tricky
  - Minimizing standard errors of item parameters also might not make sense
- Let's tackle them in order!

</v-clicks>

---
level: 3
---

# Potential Prompting Strategies

<v-clicks depth="2">

- Sample using the demographic distribution
  - Usable when you have potentially informative demographic information about respondents and contexts
  - Prompt the model with context, “You are an 8th grade student at a high-performing magnet high school in New York City. You are sitting down to take a math test…”
  - Provide the full text of the items to be responded to
  - Items can be provided all at once or sequentially
- Sample from the conditional response distribution
  - Usable with no demographic information
  - Prompt the model with context as before
  - Provide model with text of all but one item and whether or not a respondent answered them correctly
  - Ask the model to predict the held-out response from this information and the item text
  - Repeat for each item
  - Combine LLM-generated responses into a fully synthetic response string

</v-clicks>

---
level: 2
---

# Combining Human and LLM Responses

<v-clicks depth="2">

- PPI++ wants an independent variable and an outcome, but we don’t really have this setup
  - ...or do we?
- Recall that IRT models are typically estimated using an Expectation-Maximization (EM) procedure
  - See: Bock, R. D., & Aitkin, M. (1981). [Marginal maximum likelihood estimation of item parameters: Application of an EM algorithm](https://www.cambridge.org/core/journals/psychometrika/article/abs/marginal-maximum-likelihood-estimation-of-item-parameters-application-of-an-em-algorithm/ABCDBCF23ECBBC837C2F3F38A11ACC7B). _Psychometrika_, 46 (4), 443–459
- Instead of computing an integral over the ability distribution, we approximate this numerically using quadrature
  - Often Gauss-Hermite quadrature

</v-clicks>

---
level: 3
---

# The E-Step

<v-clicks depth="2">

- At each ability quadrature point, $X_k$, we estimate two quantities from our observed data
  - The expected number of respondents at that ability level:
    $$ \bar{N}_k = \sum_{l=1}^s \frac{r_l L_l(X_k)A(X_k)}{\sum_{k=1}^K L_l(X_k)A(X_k)} $$
  - The expected number of observed correct responses at that ability level:
    $$ \bar{r}_{jk} = \sum_{l=1}^s \frac{r_l x_{lj} L_l(X_k)A(X_k)}{\sum_{k=1}^K L_l(X_k)A(X_k)} $$
- Where
  - $L_l(X_k) = P(x_{ij} = x_{lj}\mid \theta_i = X_k)$
  - $A(X_k)$ is a quadrature weight
  - $r_l$ is the count of observed responses at level $l$
</v-clicks>

---
level: 3
---

# The M-Step

<v-clicks depth="2">

- We carry out the E-step using parameters determined from a standard 2PL IRT model
  - We essentially do an extra E-step after convergence, so item parameters should not change much
- Bock and Aitkin (1981) show that the M-step is identical to a weighted probit (or logistic) regression of the proportion of correct responses at ability quadrature point $X_k$ on $X_k$
- That is to say, we structure the model as:
  $$ \frac{\bar{r}_{jk}}{\bar{N}_k} = \frac{1}{1 + \text{exp}\big[\alpha_j + \beta_j X_k\big ]} $$
  - Here the $\alpha_j$ and $\beta_j$ are the regression parameters that can be translated to item parameters
- We use the logistic likelihood weighted by $\bar{N}_k$ to estimate model parameters from the PPI++ loss:
  $$L^{PPI}(\alpha, \beta) = \frac{1}{n}\sum_i^n \ell_{\alpha,\beta} (X_i, Y_i) + \lambda\bigg[\frac{1}{N}\sum_i^N \ell_{\alpha,\beta} (\widetilde{X}_i, f(\widetilde{X}_i)) - \frac{1}{n}\sum_i^n \ell_{\alpha,\beta} (X_i, f(X_i))\bigg]$$
- Here $X$'s are quadrature points and $Y$, $f(X)$ are the ratio $\frac{\bar{r}_{jk}}{\bar{N}_k}$ determined from human or LLM responses

</v-clicks>

---
level: 3
---

# Power Tuning

<v-clicks depth="2">

- We have successfully translated our unsupervised latent variable problem into a supervised problem
  - The independent variable is the selected quadrature points
  - The dependent variable is the expected proportion of correct responses
- All we need to do is estimate $\lambda$
- Before we selected $\lambda$ to minimize the standard errors of the estimated parameters:
  $$ \hat{\lambda} = \underset{\lambda}{\mathrm{argmin}} \ \text{Tr}\big(\hat{\Sigma}\big) $$
  - This isn't actually what we want to minimize...
- What we _actually_ care about is minimizing downstream error in estimates of individual abilities:
    $$\hat{\lambda} = \underset{\lambda}{\mathrm{argmin}} \ \mathbb{E}\big[(\hat{\theta} - \theta )^2\big]$$
  - This is trickier, and it requires the off-diagonal elements of the item parameter covariance matrix to propagate error in parameter estimates into the error in expected ability estimates

</v-clicks>

---
level: 2
---

# The Mixed Subjects IRT Protocol

<v-clicks depth="2">

- Collect data:
  - Collect item responses in your pilot sample
  - Use an LLM to simulate responses for your pilot sample
  - Collect a large number of additional LLM responses
- Fit a 2PL to each dataset
- Construct your E-step expected sample sizes and correct responses
- Estimate $\hat{\lambda}$
- Estimate item parameters using the PPI++ loss

</v-clicks>
