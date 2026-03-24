---
level: 2
layout: section
---

# Adjacent Category Models


---
level: 3
---

# Adjacent Category Models

<v-clicks>

- Consider an item with four response categories, $X_i \in \{0,1,2,3\}$
- Model the probability that a response is in one category versus an adjacent category

</v-clicks>
<v-clicks>

$$P(X_i = 1 | X_i \in \{0,1\})$$
$$P(X_i = 2 | X_i \in \{1,2\})$$
$$P(X_i = 3 | X_i \in \{2,3\})$$

</v-clicks>
<v-clicks>

- In general for $K$ categories, model $P(X_i = k | X_i \in \{k-1,k\})$ for $k \in \{1,\ldots,K-1\}$

- Most common version: Partial Credit Model (PCM; Masters, 1982)

</v-clicks>

---
level: 3
---

# Partial Credit Model

- Now we have to smash these together!

<v-click>

$$P(X_i = j|\theta) = \frac{\exp\left[ \sum_{k=1}^j (\theta - b_{ik})\right]}{1 + \sum_{r=1}^{K-1}\left[\exp\left[ \sum_{k=1}^r (\theta - b_{ik})\right]\right]}$$

</v-click>
<v-click>

- With the caveat for $j=0$:

$$P(X_i = 0|\theta) = \frac{1}{1 + \sum_{r=1}^{K-1}\left[\exp\left[ \sum_{k=1}^r (\theta - b_{ik})\right]\right]}$$

</v-click>
<v-click>

- This is a _divide-by-total formulation_ with $K-1$ item parameters

</v-click>

---
level: 3
---

# Partial Credit Model

- Let's write this out explicitly for $j \in \{ 1, 2, 3\}$:

<v-clicks>

$$P(X_i = 1|\theta) = \frac{\exp\left[\theta - b_{i1}\right]}{1 + \sum_{r=1}^{K-1}\left[\exp\left[ \sum_{k=1}^r (\theta - b_{ik})\right]\right]}$$
$$P(X_i = 2|\theta) = \frac{\exp\left[\theta - b_{i1} + \theta - b_{i2}\right]}{1 + \sum_{r=1}^{K-1}\left[\exp\left[ \sum_{k=1}^r (\theta - b_{ik})\right]\right]} = \frac{\exp\left[2\theta - b_{i1} - b_{i2}\right]}{1 + \sum_{r=1}^{K-1}\left[\exp\left[ \sum_{k=1}^r (\theta - b_{ik})\right]\right]}$$
$$P(X_i = 3|\theta) = \frac{\exp\left[\theta - b_{i1} + \theta - b_{i2} + \theta - b_{i3}\right]}{1 + \sum_{r=1}^{K-1}\left[\exp\left[ \sum_{k=1}^r (\theta - b_{ik})\right]\right]}= \frac{\exp\left[3\theta - b_{i1} - b_{i2} -b_{i3}\right]}{1 + \sum_{r=1}^{K-1}\left[\exp\left[ \sum_{k=1}^r (\theta - b_{ik})\right]\right]}$$

</v-clicks>


---
level: 3
---

# Generalized Partial Credit Model

<v-click>

- Add item discrimination, one per item: $a_i$ (Muraki, 1992)

$$P(X_i = j|\theta) = \frac{\exp\left[ \sum_{k=1}^j a_i(\theta - b_{ik})\right]}{1 + \sum_{r=1}^{K-1}\left[\exp\left[ \sum_{k=1}^r a_i(\theta - b_{ik})\right]\right]}$$

</v-click>
<v-click>

- As before, for $j=0$:

$$P(X_i = 0|\theta) = \frac{1}{1 + \sum_{r=1}^{K-1}\left[\exp\left[ \sum_{k=1}^r a_i(\theta - b_{ik})\right]\right]}$$

</v-click>
<v-click>

- Let's build a GPCM IRF in [Desmos](https://www.desmos.com/calculator/n0ih6e7piw)

</v-click>