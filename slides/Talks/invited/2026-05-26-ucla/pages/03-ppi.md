---
level: 2
layout: section
---

# Prediction Powered Inference

---
level: 3
---

# Prediction Powered Inference

<v-clicks depth="2">

- Core ideas are established in two papers:
  - Angelopoulos, A. N., Bates, S., Fannjiang, C., Jordan, M. I., & Zrnic, T. (2023). [Prediction-powered inference](https://www.science.org/doi/full/10.1126/science.adi6000). _Science_, 382 (6671), 669–674
  - Angelopoulos, A. N., Duchi, J. C., & Zrnic, T. (2023). [PPI++: Efficient prediction-powered inference](https://arxiv.org/abs/2311.01453). _arXiv preprint_.
- Allows researchers to integrate predictions from arbitrary machine learning (ML) models on unlabeled data into inferential tasks
- Generates confidence intervals (CIs) with desired coverage rates, regardless of ML model or underlying data distribution
- CIs are, at worst, as wide as the CIs on labeled data
- Produces unbiased parameter estimates
- Generally helpful as long as the sample size of the unlabeled data is large enough and the predictions are good enough

</v-clicks>

---
level: 3
---

# PPI Protocol

<v-clicks depth="2">

- Starting requirements:
  - A labeled dataset with $n$ observations of your independent and dependent variables, $(X, Y)$
  - An unlabeled dataset with $N \gg n$ observations of independent variables only, $\widetilde{X}$, drawn from the same distribution as $X$

- Use a predictive algorithm, $f(\cdot)$, to generate predicted outcomes for your labeled data, $f(X)$
- Generate predicted outcomes for your unlabeled data, $f(\widetilde{X})$
- Define the rectified loss function and construct a prediction-powered point estimate:
  $$L^{PPI}(\theta) = \frac{1}{n}\sum_i^n \ell_\theta (X_i, Y_i) + \frac{1}{N}\sum_i^N \ell_\theta (\widetilde{X}_i, f(\widetilde{X}_i)) - \frac{1}{n}\sum_i^n \ell_\theta (X_i, f(X_i))$$
- Because the expected value of the second and third sums are equal, this generates unbiased parameter estimates

</v-clicks>

---
level: 3
---

# PPI++ Modifications

<v-clicks depth="2">

- PPI++ introduces an idea called _power tuning_
  - We modify the loss function to include a tuning parameter, $\lambda$, that depends on our confidence in the quality of predictions:
    $$L^{PPI}(\theta) = \frac{1}{n}\sum_i^n \ell_\theta (X_i, Y_i) + \lambda\bigg[\frac{1}{N}\sum_i^N \ell_\theta (\widetilde{X}_i, f(\widetilde{X}_i)) - \frac{1}{n}\sum_i^n \ell_\theta (X_i, f(X_i))\bigg]$$
- If predictions are horrible, $\lambda \rightarrow 0$, and the PPI++ estimate approaches the estimate on only the labeled data
- If predictions are perfect, $\lambda \rightarrow 1$, and the PPI++ estimate approaches the estimate on the unlabeled data
- In practice, PPI++ estimates $\lambda$ from data to minimize the standard errors of the parameter estimates
- For mean estimation this looks like:
  $$ \hat{\lambda} = \frac{\widehat{\text{Cov}}_n(Y, f(X))}{\big(1 + \frac{n}{N}\big)\widehat{\text{Var}}_{N+n}\big(f(X\cup\widetilde{X})\big)}$$

</v-clicks>
