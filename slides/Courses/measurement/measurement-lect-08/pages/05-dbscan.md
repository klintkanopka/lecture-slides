---
level: 2
layout: section
---

# Density Based Clustering


---
level: 3
---

# DBSCAN

- Density-based clustering algorithms assume that clusters consist of high-density regions of data surrounded by lower-density regions
- Density near a point is measured by the number of neighbors a it has within a given distance
- Density Based Spatial Clustering with Applications of Noise (DBSCAN) classifies each observartion into one of three categories: core points, border points, and noise points
- Core points are in dense regions and have many neighbors; minimum number of neighbors and neighborhood radius are hyperparameter settings chosen by the user
- Border points do not meet the requirements for being a core point, but do have at least one neighbor that is a core point
- Noise points do not meet the requirements for being a core point, but do not have a core point neighbor
- Unlike the previous methods, DBSCAN allows for some points to not be assigned to any cluster
- In `R`, typically fit using the `dbscan()` function from the `fpc` package
