---
level: 1
layout: section
---

# Non-Monotonic Item Response Functions

---
level: 2
hideInToc: true
---

# Different Shapes

- Until now, we've dealt with _monotonoic_ IRFs
  - Monotonic means probability of response is always increasing (or decreasing) with ability
  - More $\theta$ means more $P(X=1|\theta)$
- This isn't the only reasonable IRF, though!
  - What about a Goldilocks situation?
  - $P(X=1|\theta)$ is maximized when $\theta$ is "just right"
  

---
level: 3
---
 
## Buying Jeans: Too Small
[Skinny Jeans](img/skinny-jeans.jpg)

## Buying Jeans: Too Big
[JNCO Jeans](img/jnco.png)

## Buying Jeans: Just Right (for me)
[Reasonable Jeans](img/middle.jpg)

## Buying Jeans

- We all have different body types and fit preferences!
- If the cut of the jeans are skinnier or baggier than you like, you're less likely to buy them $\big(P(X=0)\big)$
- Is there something we could build an item response function out of?

---
level: 2
---

# Ideal Point Models

We start from a normal pdf:
$$ f(x) = \frac{1}{\sigma\sqrt{2\pi}} \cdot \exp \bigg[-\frac{1}{2}\bigg(\frac{x-\mu}{\sigma}\bigg)^2\bigg]$$

- Notice that the the mean of the distribution, $\mu$, is a location parameter, which acts like our difficulty, $b$
- We also see that the inverse of the standard deviation, $\frac{1}{\sigma}$, functions like our discrimination, $a$
- The stuff up front is a normalization constant to make sure the pdf integrates to 1
- Let's write an example IRF:

$$ P(X=1|\theta) = \frac{a}{\sqrt{2\pi}} \cdot \exp \bigg[-\frac{1}{2}\big(a(\theta-b)\big)^2\bigg]$$

---
level: 3
---

# Ideal Point Models

- In general, these are used for modeling preference data. 