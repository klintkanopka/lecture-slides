---
level: 1
layout: section
---

# Mixture IRT Models


---
level: 2
hideInToc: true
---

# Recall: LCA Model Structure

<v-clicks depth="2">

- If there are two classes ($t_1, t_2$) and two items ($i, j$), the probability of an observed response pattern is:
  - $p_{ij} = \pi_{t_1}p_{i,t_1}p_{j,t_1} + \pi_{t_2}p_{i,t_2}p_{j,t_2}$
  - $\pi_t$ is the probability of latent class membership
  - $p_{i,t}$ is the probability of the observed response conditional on class $t$
- More generally, for $T$ classes and $K$ items:

</v-clicks>

<v-click>

$$
p_i = \sum_{t=1}^T \pi_{it} \prod_{k=1}^K p_{ki,t}
$$

</v-click>

<v-clicks depth="2">

- Here $p_{ki,t}$ is the probability of person $i$'s response to item $k$ conditional on class membership $t$
- This is still the same local-independence logic we have already been using

</v-clicks>

---
level: 2
---

# Mixture IRT Models

<v-clicks depth="2">

- If we replace $p_{ki,t}$ with an IRT response model, we get a _mixture_ item response model
- These were originally formulated and sold as combinations of IRT and LCA

</v-clicks>

<v-click>

$$
p_i = \sum_{t=1}^T \pi_{it} \prod_{k=1}^K p_{ki,t}\mid \theta_i
$$

</v-click>

<v-clicks depth="2">

- The response probability can now also depend on a continuous latent trait $\theta_i$
- Different classes can have different item parameters
- Different classes can even have different looking IRFs
- These models can be tricky to fit in practice

</v-clicks>


---
level: 2
---

# Building a Mixture IRT Model

- Let's say we have a math test, and we model the probability of correct responses using a 1PL IRT model:

$$ P(X_{ij}=1 \mid \theta_i) = \frac{1}{1+e^{-(\theta_i - b_j)}}$$


<v-clicks depth="2">

- This is the behavior we want to see for good individual-level measurement, but what if we worry some subset of students aren't taking our math test seriously?
- How do we try to tell the difference between _low ability_ students and _low effort_ students?
  - What might an item response model _that doesn't depend on_ $\theta_i$ look like for this low effort group?
  - Let's assume they exhibit true random guessing, and there are four response options:

</v-clicks>

<v-click>

$$ P(X_{ij}=1) = \frac{1}{4}$$

</v-click>

<v-click>

- How can we stick these two together?

</v-click>


---
level: 3
---

# Building a Mixture IRT Model

- Think back to how LCA works!
  - Let's say there are $K=2$ latent classes: (1) effortful responding  and (2) low-effort responding
  - We can model the probability we think an individual is responding with effort:

$$ P(K_i=1) = \pi_{i1} $$
$$ P(K_i=2) = \pi_{i2} = 1-\pi_{i1} $$

- Go back now to an LCA structure for an individual item:

$$ P(X_{ij} = 1) = \sum_{k=1}^2 \pi_{ik} P(X_ij=1 \mid \theta_i, K_i)
$$


- Take a moment and try to write out the full item response function using the pieces we have!


---
level: 3
---

# Building a Mixture IRT Model

<v-click>

- Expand:

</v-click>
<v-click>

$$ P(X_{ij} = 1) = \pi_{i1} P(X_ij=1 \mid \theta_i, K_i=1) + \pi_{i2} P(X_ij=1 \mid \theta_i, K_i=2)
$$


</v-click>
<v-click>

- Recall:


</v-click>
<v-click>

$$ P(X_ij=1 \mid \theta_i, K_i=1) = \frac{1}{1 + e^{-(\theta_i - b_j)}} $$


</v-click>
<v-click>

$$ P(X_ij=1 \mid \theta_i, K_i=2) = \frac{1}{4} $$


</v-click>
<v-click>

- Combining everything:


</v-click>
<v-click>

$$ P(X_{ij} = 1 \mid \theta_i, \pi_i) = \pi_{i} \cdot \frac{1}{1 + e^{-(\theta_i - b_j)}} + (1 - \pi_i)\cdot \frac{1}{4} $$


</v-click>
<v-click>

- What parameters are we estimating for people? For items? How do we interpret them?

</v-click>


---
level: 3
---

# Building a Mixture IRT Model

- What have we estimated?

<v-clicks depth="3">

  - Person parameters:
    - $\theta_i$: Latent ability for person $i$
    - $\pi_i$: Probability that person $i$ was engaged in effortful responding
  - Item parameters:
    - $b_j$: Difficulty of item $j$
- So what do we do with these?
  - Filter respondents with low values of $\pi_i$ into remediation or retesting
  - Use $\pi_i$ as an estimate of the confidence we have that $\theta_i$ is reflective of true ability
- Can you think of a different situation where a mixture IRT model might be useful?

</v-clicks>