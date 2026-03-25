---
level: 1
layout: section
---

# Applied Clustering


---
level: 2
---

# Clustering countries with `kmeans()`

Using [`country-data.csv`]() and $3 \pm 1$ friends:

1. Create a dataframe of only _standardized_ quantitative variables
2. Fit $k$-means solutions for $k \in \{1, \ldots, 10\}$
3. Determine an optimal number of clusters
4. Using the centers and the codebook in [country-data-dictionary.csv](), describe each cluster
5. Which countries are in each cluster? Do the cluster descriptions fit the countries?
6. Are there any adjustments you can make to improve the cluster solution?

---
level: 2
---

# Clustering countries with `hclust()`

Now we can repeat this with `hclust()`:

1. Create dissimilarity objects
2. Fit a hierarchical clustering solution for a few different linkages and pick one that looks "good" to you
3. Determine an optimal number of clusters
4. Describe the clusters

---
level: 2
---

# Clustering countries with `dbscan()`

1. Cluster your data using `dbscan()`, using default values for `eps` and `MinPts` arguments
2. Describe the clusters


---
level: 2
---

# Visualizing high-dimensional cluster solutions

- Sometimes we have a lot of variables!
- One option is to look at density or box plots of variables across cluster assignments
  - Upside: Clean, easy to understand
  - Downside: Only looks at a single variable at a time
- Another option is to look at two variables at a time in a scatterplot and color points by cluster
  - Upside: Allows you to see relationships across multiple variables at a time
  - Downside: Oversimplifies the structure of the data
- Create a matrix of scatterplots using `ggpairs()` from the `GGally` library and color points by cluster
  - Upside: Shows all the pairwise relationships at once
  - Downside: Shows all the pairwise relationships at once
- Project your data onto the first two principal components, plot them, and color the points by cluster
  - Upside: Easy to read
  - Downside: If the first two PCs don't explain much variance, probably not very helpful
