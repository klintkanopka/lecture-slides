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

<v-clicks>

- This isn't the only reasonable IRF, though!
  - What about a Goldilocks situation?
  - $P(X=1|\theta)$ is maximized when $\theta$ is "just right"
  
</v-clicks>

---
level: 3
layout: section
---

# Let's buy jeans!

---
level: 3
layout: center
---

![Skinny Jeans](/skinny-jeans.jpg)

---
level: 3
layout: center
zoom: 0.85
---
 
![JNCO Jeans](/jnco.png)

---
level: 3
layout: center
zoom: 0.65
---

![Reasonable Jeans](/middle.jpg)

---
level: 3
---

# Buying Jeans

- We all have different body types and fit preferences!
- If the cut of the jeans are skinnier or baggier than you like, you're less likely to buy them $\big(P(X=0)\big)$

<v-click>

- Is there something we could build an item response function out of?

</v-click>

---
level: 2
---

# Ideal Point Models

- We start from a normal pdf:

$$ f(x) = \frac{1}{\sigma\sqrt{2\pi}} \cdot \exp \bigg[-\frac{1}{2}\bigg(\frac{x-\mu}{\sigma}\bigg)^2\bigg]$$

<v-clicks>

- Notice that the the mean of the distribution, $\mu$, is a location parameter, which acts like a difficulty, $b$
- We also see that the inverse of the standard deviation, $\frac{1}{\sigma}$, functions like a discrimination, $a$
- The stuff up front is a normalization constant to make sure the pdf integrates to 1
- Let's write an example IRF:

</v-clicks>

<v-click>

$$ P(X=1|\theta) = c \cdot \exp \big[-a(\theta-b)^2\big]$$

</v-click>

<v-click>

- $b$ is the location of the ideal point
- $a \in [0,\infty)$ is the discrimination 
- $c \in [0,1]$ is the upper bound on $P(X=1)$

</v-click>



---
level: 3
---

# Unfolding Models

- Check out an unfolding IRF on [Desmos](https://www.desmos.com/calculator/dq0ywlhrzz)
- In general, these are used for modeling preference data
- Often applied to Likert scale data, as well
- More generally called _unfolding models_, which is a reference to the theorized cognitive process that governs making choices
- In `mirt`, you can use `itemtype='ideal'` with dichotomous data
- `itemtype='ggum'` works with both dichotomous and polytomous data
    - `ggum` stands for "generalized graded unfolding model"