---
level: 1
layout: section
transition: fade
---

# Circling Back

---
level: 2
layout: two-cols-header
---

# What Have We Learned?


:: left ::

<v-click>

### Dimensionality Reduction

</v-click>

<v-clicks depth="2">

- **Purpose:** Find groups of similar variables
- **Approach:** Create groups of _columns_ and project each observation in our data onto these new composite variables
  - Projections are _continuous_ latent variables
- **Methods:**
  - Principal component analysis (PCA)
  - Factor analysis (EFA)
  - Topic models (LDA)


</v-clicks>

:: right ::

<v-click>

### Clustering

</v-click>

<v-clicks depth="2">

- **Purpose:** Find groups of similar observations
- **Outcome:** Create groups of _rows_ and assign each observation in our data to a group
  - Assignments as _categorical_ latent variables
- **Methods:**
  - $k$-means
  - Hierarchical clustering
  - DBSCAN
  - Gaussian mixture models (GMMs)
  - Latent class analysis (LCA)

</v-clicks>


---
level: 3
---

# What Have We Learned?

<v-click>

### Item Response Theory (IRT)

</v-click>

<v-clicks depth="2">

- **Purpose:** Turn observations of categorical item responses into a continuous measurement of a latent trait
- **Outcome:** Persons and items are projected onto a common scale
  - These person locations are _continuous_ latent variables
  - Item parameters have continuous values and are treated as fixed for  scoring future responses
  - Scales are robust to missing data
  - Individuals can be compared even if they don't respond to the same items
- **Methods:**
  - Dichotomous items
  - Polytomous items
  - Multidimensionality
  - IRTrees
  - Elo models
  - Ideal point models

</v-clicks>


---
level: 2
---

# What Do We Do With This?

With a group of $3 \pm 1$:

- Use the [General Social Survey](https://gss.norc.org/) to build a research question
  - Browse the questions they've asked
  - Find something interesting you want to know about!
- Start with measurement
  - Define a construct you want to try to measure
  - Which variables capture it?
  - Which method seems appropriate for the data?
- Then connect that measurement to outcomes, predictors, or group differences
- The toolkit matters because it opens up different kinds of substantive questions!


---
level: 1
layout: section
---

# Wrap Up

---
level: 2
---

# Recap

- LCA is clustering for categorical variables
- Mixture models extend the same latent-variable logic we have used throughout the course
- Doing research is hard, but you now have a much stronger set of tools for measurement and discovery
