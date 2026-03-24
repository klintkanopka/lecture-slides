---
level: 2
layout: section
---

# Hierarchical Clustering

---
level: 3
---
  
# Hierarchical Clustering

- In $k$-Means, cluster assignment occurs simultaneously and each observation is assigned to exactly one cluster
- Hierarchical clustering allows for smaller clusters to be nested within larger clusters
- Generally, there are two ways hierarchical clustering is done:
  - **Agglomerative clustering** starts with each observation in its own cluster. At each step, the two closest clusters are joined together and a new center is computed
    - This is done using `hclust()`, which is loaded by default with the `stats` library
  - **Divisive clustering** starts with all observations in one giant cluster. At each iteration, one cluster is allowed to split into two
    - This is done using `diana()`, which is loaded in the `cluster` library
- You'll dig into hierarchical clustering in PS4

---
level: 3
---
  
# Linkages

- During each step of agglomerative clustering, the two most similar clusters are joined
- When deciding which two are joined, there are a variety of agglomeration methods you can use, called _linkages_
- At one end of the scale, _single linkage_ selects the next two clusters to join by considering the minimum distance between points across clusters
  - The two clusters with members that are the closest together are joined
  - Tends to create clusters that look like long chains 
- At the other end, _complete linkage_ selects the next two clusters to join by considering the maximum distance between points across clusters
  - The two clusters with the smallest maximum distance are joined
  - This is very sensitive to outliers and tends to create compact and spherical clusters

---
level: 3
---

# Other Linkages

- In between is _average linkage_, which considers the average distances between all pairs of points across clusters
  - Generally produces clusters that are between single and complete linkage in compactness
- _Ward's linkage_ combines the two clusters that result in the smallest increase in within cluster variance
  - Makes very compact, very separate clusters
- _Centroid linkage_ merges the two clusters with the closest center points
  - Works well when clusters are very spherical and evenly shaped
- In general, you want to try to pick a linkage that aligns with what you think the shape of the clusters or the underlying process that groups members ought to be

---
level: 3
---

# The Dendrogram

- The dendrogram fills the role of the elbow plots or gap/silhouette plots in deciding on the number of clusters
- Displays changes in cluster statistics as clusters are merged/divided
- In general, you want to look for a large vertical gap and "cut" the dendrogram to determine the number of clusters
- We'll look at some actual dendrograms and this will make more sense in a little bit!
