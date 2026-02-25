---
level: 1
layout: section
---

# Polytomous Item Responses

---
level: 2
---

# Polytomous Responses

<v-clicks>

- Up until now, we've mostly dealt with dichotomous responses
- Two response categories do a lot of work
- Correct/incorrect; yes/no; agree/disagree; prefer A or B; etc.
- Polytomous responses have multiple categories
- What are some cases where this might be better than dichotomous?
- Likert scales; partial credit; etc.
- Polytomous responses can be ordered or not

</v-clicks>

---
level: 3
---

# Building a Polytomous Item Response Model

As usual, with $3 \pm 1$:

1. What properties of IRT models do we want to preserve for polytomous models?
2. What complications do polytomous models provide?
3. What things won't work anymore?
4. How we could force an IRT model to work with these responses?


---
level: 3
---

# The Fundamental Idea of Dichotomization

<v-clicks>

- Different polytomous IRT models work by turning polytomous responses into dichotomous responses
- Different models imply different dichotomizations
- These dichotomizations are the "step functions" from the NCME ITEMS paper
- Before, we've modeled $P(X_{ij} = 1 | \theta_j)$
- Think of this as having a hidden condition because $X_{ij}$ can only be 0 or 1
  - $P(X_{ij} = 1 |\theta_j, X_{ij} \in \{0,1\})$
- For polytomous models, we apply a dichotomous IRT model after making these conditions explicit
- The dichotomization we pick defines the structure of the item parameters

</v-clicks>