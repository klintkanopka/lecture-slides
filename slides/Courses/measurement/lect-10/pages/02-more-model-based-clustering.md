---
level: 1
layout: section
---

# More Model-Based Clustering


---
level: 2
---

# Mixture Distributions

<v-click>

- Recall last week’s mixture distribution:

$$p(x_i) = \sum_{k=1}^K \pi_{ki}\mathcal{N}(x_i;\mu_k, \sigma_k^2)$$

$$\sum_{k=1}^K \pi_{ki} = 1$$

</v-click>
<v-click>

- These $\pi_{ki}$ are _mixture weights_, **not** hard cluster assignments

</v-click>
<v-click>

- We interpret $\pi_{ki}$ as the probability observation $i$ came from component $k$

$$\pi_{ki} = P(\theta_i = k)$$

</v-click>


---
level: 2
---

# Soft Clustering

<v-clicks depth="2">

- Think of $\vec{\pi}_i$ as a vector of probabilities over classes
- If we fit a model with `Mclust()`, then:
  - `gmm$z` gives the _full_ $N \times K$ matrix of mixture weights (probabilities of belonging to each class)
  - `gmm$classification` gives the _most likely_ class for each observation
- The mixture weights tell us how certain (or uncertain) the model is of each possible assignment
- That is why model-based clustering is called "soft" clustering
  - Each $\pi_{ki} \in (0,1)$; none of the assignments are certain!
  - $k$-means, hierarchical clustering, and DBscan are "hard" clustering methods

</v-clicks>

---
level: 3
---

# Checking Uncertainty in `mclust`

```r
library(mclust)
library(readr)

d <- read_csv('country-data.csv')
d_quant <- d[, 2:10]

gmm <- Mclust(d_quant)

gmm$classification
head(gmm$z)
```

- `gmm$classification` returns the maximum-probability class
- `gmm$z` returns an $N\times K$ matrix of estimated class probabilities for each observation and class

---
level: 3
---

# Why This Matters

<v-clicks>

- Soft assignments give a built-in notion of uncertainty
- Mixture models are not limited to Gaussians!
- Today we we will switch from trying to cluster on continuous data to clustering on categorical data
- We'll use another mixture model, and can use the same general logic to understand model parameters

</v-clicks>