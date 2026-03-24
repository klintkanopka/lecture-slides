---
level: 2
layout: section
---

# Nominal Response Model

---
level: 3
---

# Nominal Response Model

<v-clicks>

- Here we do not enforce category ordering
- Model each response category relative to a baseline category $k=0$
- $P(X_i = k | X_i \in \{0,k\})$ for $k \in \{1,\ldots,K-1\}$

</v-clicks>

<v-clicks>

$$P(X_i = k |\theta, X_i \in \{0,k\}) = \frac{1}{1 + \exp(a_{ik}\theta + b_{ik})}$$
$$P(X_i = 0|\theta) = \frac{1}{1 + \sum_{k=1}^{K-1} \exp(a_{ik}\theta + b_{ik})}$$
$$P(X_i = k|\theta) = \frac{\exp(a_{ik}\theta + b_{ik})}{1 + \sum_{k=1}^{K-1} \exp(a_{ik}\theta + b_{ik})}$$

</v-clicks>

<v-clicks>

- This is _much_ more flexible than other formulations!
- We have one discrimination per comparison category and uses "slope-intercept" form
- Let's build a NRM IRF in [Desmos](https://www.desmos.com/calculator/n0ih6e7piw)

</v-clicks>