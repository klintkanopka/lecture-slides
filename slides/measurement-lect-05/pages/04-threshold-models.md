---
level: 2
layout: section
---

# Threshold Models

---
level: 3
---

# Threshold Models

<v-clicks>

- Build a model that checks whether a response is in a category or higher
- Model $P(X_i \geq k)$ for $k \in \{1,\ldots,K-1\}$
- Most common: Graded Response Model (GRM; Samejima, 1969)

</v-clicks>

<v-clicks>

$$P(X_i \geq 0) = 1$$
$$P(X_i \geq 1) = \frac{1}{1 + \exp\big(-a_i(\theta - b_{i1})\big)}$$
$$P(X_i \geq k) = \frac{1}{1 + \exp\big(-a_i(\theta - b_{ik})\big)}$$

</v-clicks>

---
level: 3
---

# Graded Response Model

<v-clicks>

- Model threshold probabilities, then recover category probabilities

</v-clicks>

<v-clicks>

$$P(X_i = 0) = 1 - P(X_i \geq 1)$$
$$P(X_i = 1) = P(X_i \geq 1) - P(X_i \geq 2)$$
$$P(X_i = 2) = P(X_i \geq 2) - P(X_i \geq 3)$$

</v-clicks>

<v-clicks>

- For this to work, we require $b_{ik} \leq b_{i,k+1}$
- So GRM enforces category ordering more strictly than GPCM
- Let's build a GRM IRF in [Desmos](https://www.desmos.com/calculator/n0ih6e7piw)

</v-clicks>