---
level: 1
layout: section
---

# Latent Variable Models for Recommendation

---
level: 2
---

# Latent Variable Models for Recommendation

<v-clicks depth="2">

- What tools do we have that might be helpful here?
- Something like PCA or Factor Analysis is great for finding latent dimensions of preference
  - You have to be careful about missing data
  - Remember that factor analysis can be run on a _pairwise complete_ correlation matrix!
- Clustering can provide us with groups of users or items with similar profiles
- Multidimensional IRT is actually a _great_ tool for this job!
  - Using a polytomous model, you can get predicted probabilities of ratings that aren't just dichotomous choices
- Try applying a latent variable approach to the MovieLens data, what do you learn?
  - Do this now!

</v-clicks>