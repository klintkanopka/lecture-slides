---
level: 1
layout: section
---

# More Item Response Theory


---
level: 2
hideInToc: true
---

# Looking at IRFs

- These plots are also called Item Characteristic Curves (ICCs)
- Go to: [https://www.desmos.com/calculator/5rcatk0pak](https://www.desmos.com/calculator/5rcatk0pak)
- With $3 \pm 1$ people, answer the following questions:
  1. What happens to each of the plots as you modify $b_1$, $a$, and $b_2$?
  2. Can you notice any weird behaviors? 
  3. What value of $a$ makes the two IRFs the same shape?
  4. Do the $b$ parameters do the same thing in each model? Does the behavior of $b$ change as $a$ changes?


---
level: 3
---

# Rasch Measurement

With $3 \pm 1$ people, answer the following questions:

1. What is _specific objectivity_?
2. Why was Rasch obsessed with sufficient statistics?
3. What were your big thoughts about this reading?
4. Why won't a 2PL work with Rasch's methods?

---
level: 3
---

# Missing Data

- You may have heard me casually said, "missing data doesn't matter in IRT models" 
- What do I mean by this?
- Why doesn't it matter?
- What are the consequences of missing data?

---
level: 3

---

# Missing Data

- Back to the likelihood!
- Here's the probability of one response and the likelihood across all our data

$$P(X_{ij} = 1 | \theta_i, a_j, b_j) = \frac{1}{1 + e^{-a_j(\theta_i - b_j)}}$$

- The likelihood only involves responses that we directly observe


$$ \mathcal{L}(\theta_i, a_j, b_j | X) = \prod_i \prod_j \frac{1}{1 + e^{-a_j(\theta_i - b_j)}}$$

- If we don't see a response, it doesn't appear in the product!
- Missing data just reduces the _precision_ on our estimates of our parameters: $\theta_i, a_j, b_j$


---
level: 3
layout: section
---

# Break