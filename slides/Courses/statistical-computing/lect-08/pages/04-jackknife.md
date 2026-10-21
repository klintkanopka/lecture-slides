---
level: 1
layout: section
transition: fade
---

# More Resampling Methods

---
level: 2
---

# The Central Limit Theorem

- Core to statistics, because it says "normal distributions are worth understanding" even though most data is not actually normally distributed!
- $\{X_1, X_2, \ldots, X_n\}$ are i.i.d. random variables with:
  - $\text{E}[X_i] = \mu$
  - $\text{Var}[X_i] = \sigma^2$
- We define the _sample mean_: $\bar{X}_n =\frac{1}{n} \sum_{i=1}^n X_i$

---
level: 3
---

# The Central Limit Theorem

- As $n$ grows large, the _distribution of sample means_ is approximately: 

$$\bar{X}_n \;\dot{\sim}\; \mathcal{N}\bigg(\mu, \frac{\sigma^2}{n}\bigg)$$


- This holds even if $X_i$ is not normally distributed!
- This is a statement about sample means (and things that behave like them)!

---
level: 3
---

# Resampling Methods

- We want to reason about populations from samples
- The CLT helps a lot, but it doesn’t do everything!
- **Core idea:** The distribution of the data you have is your best guess at the distribution of the population 
- But what do we do with this?

---
level: 3
layout: image-right
image: /tukey.png
---

# John Tukey (1915-2000)

<v-clicks>

- His ideas about “exploratory data analysis” are the foundations of modern data science
- His book “Exploratory Data Analysis” is still one of the best sources for data visualization and exploratory analysis
- Invented the term “bit” at Bell Labs
- Invented the box plot
- Co-developed the Fast Fourier Transform (Cooley-Tukey, 1965)
- Certified badass

</v-clicks>

---
level: 3
layout: image
image: /jackknife.png
---

# What did Tukey give us today?

---
level: 2
---

# The Jackknife

- Thanks Tukey! (and Quenouille)
  - Maurice Quenouille proposed it in 1949 as a way to reduce bias
  - Tukey (1958) extended it to estimate variance and gave it its name
- "Rough and ready" tool to solve statistical problems when the exact solution might be hard or unknown
- **Core idea:** We take our data, make new datasets by dropping single observations, compute our statistic of interest, and then look at the distribution

---
level: 3
---

# The Jackknife

- We have $\{X_1, X_2, \ldots, X_n\}$, which are i.i.d. samples from some population
- We care about some parameter $\theta$ in the population, and estimate it with a statistic computed on our sample: $\hat{\theta} = f(X_1, X_2, \ldots, X_n)$
- We often hope that our estimator is unbiased: $\text{E}[\hat{\theta}] = \theta$
- But a single $\hat{\theta}$ tells us nothing about the bias or variance of that estimator!


---
level: 3
---

# The Jackknife

- From your dataset of length $n$, create $n$ new resampled datasets of length $n-1$, each missing one observation
- Compute your estimator on each resampled dataset: $\hat{\theta}_{(i)}$ is the estimate with observation $i$ left out
- Aggregate these using their mean, $\bar{\theta}_{(\cdot)} = \frac{1}{n}\sum_{i=1}^n \hat{\theta}_{(i)}$
  - Bias: $\widehat{\text{bias}} = (n-1)\big(\bar{\theta}_{(\cdot)} - \hat{\theta}\big)$
  - Variance: $\widehat{\text{Var}}(\hat{\theta}) = \frac{n-1}{n}\sum_{i=1}^n \big(\hat{\theta}_{(i)} - \bar{\theta}_{(\cdot)}\big)^2$
  - The $(n-1)$ factors matter! Leave-one-out datasets are nearly identical, so the raw spread of the $\hat{\theta}_{(i)}$ badly underestimates the uncertainty
- Does not require the CLT to apply to the estimator!
- Caveat: works poorly for non-smooth statistics, like the median