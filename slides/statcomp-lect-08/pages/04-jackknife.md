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

- As $n$ grows large, the _distribution of sample means_ converges to: 

$$\bar{X}_i \sim \mathcal{N}\bigg(\mu, \frac{\sigma^2}{n}\bigg)$$


- This holds even if $X_i$ is not normally distributed!
- This only applies to sample means!

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
- Invented the Fast Fourier Transform
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

- Thanks Tukey!
- "Rough and ready" tool to solve statistical problems when the exact solution might be hard or unknown
- **Core idea:** We take our data, make new datasets by dropping single observations, compute our statistic of interest, and then look at the distribution

---
level: 3
---

# The Jackknife

- We have $\{X_1, X_2, \ldots, X_n\}$, which are i.i.d. samples from some population
- We care about some estimator or statistic in the population, $f(X_i)$
We often think that: $\text{E}[f(X_i)] = f\big(\{X_1, X_2, \ldots, X_n\}\big)$
- But this tells us nothing about the bias or variance of that estimator!


---
level: 3
---

# The Jackknife

- From your dataset of length $n$, create $n$ new resampled datasets of length $n-1$, each missing one observation
- Compute your estimator or statistic on each resampled dataset
- Aggregate these statistics to get your jackknife estimate
  - The mean of the estimator in jackknife samples can be used to understand bias
  -The variance of the estimator in jackknife samples can be used to quantify uncertainty 
  - Does not require the CLT to apply to the estimator!