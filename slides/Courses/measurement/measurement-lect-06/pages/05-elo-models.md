---
level: 2
---

# Elo Models

- Used in chess and other competitive sports
- We think the probability of winning is related to the difference in two players' abilities

$$P(A \text{ defeats }B|\theta_A,\theta_B) = \frac{1}{1+\exp\big(-k(\theta_A - \theta_B)\big)}$$

- Here, $k$ is just a scaling factor that is preselected to work with the desired $\theta$ scale
- This functional form allows for making updates to individual abilities after each competition like this:

$$ \theta_A^{i+1} = \theta_A^i + k\big(X_{AB} - P(x_{AB}=1)\big) $$

- Note adjustments to abilities are small if the win was a "sure thing" and huge if the win was an upset!

---
level: 3
---

# Elo Variants

- The actual squash rankings _technically_ aren't an Elo system, because they put a time decay on the weight each match carries