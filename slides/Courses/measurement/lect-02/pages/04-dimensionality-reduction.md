---
level: 1
layout: section
---

# Multidimensionality

---
level: 2
hideInToc: true
---

# Multidimensionality 

- Sometimes when you build a full survey or test with the aim of measuring one thing, you end up measuring multiple things
  - We call this "multidimensionality" in general; it can be planned and a good thing!
  - It can also be a source of construct irrelevant variance
  - Distinguishing between the two is important!
  - When might this occur?
- We want statistical tools to try to identify and classify multidimensionality
  - Broadly, we'll lean on techniques of _dimensionality reduction_
  - The two we'll focus on here are PCA and Factor Analysis

---
level: 2
---

# Dimensionality Reduction (Conceptually)

- We have data with a bunch of variables (columns)
- We want to approximate the data with fewer variables (columns)
- This is called constructing a _low rank approximation_
  - The _rank_ of a matrix is the number of linearly independent columns
  - Cognitively, it's easier to think about and interpret a smaller number of variables
- **Why is this a good idea?**
  - You might have measured a bunch of stuff in order to take a guess at a thing you couldn't really measure, but you don't know how to weight the variables you did measure!
  - Your variables may be redundant measures of some latent construct
  - Maybe you want to look for groups of variables or people

---
level: 3
layout: image
image: /hotdog.jpg
---
