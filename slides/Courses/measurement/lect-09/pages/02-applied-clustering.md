---
level: 1
layout: section
---

# Applied Clustering


---
level: 2
---

# Clustering Countries

Using [`country-data.csv`](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/lect-09/public/country-data.csv) and a group of $3 \pm 1$:

1. Create a dataframe of only _standardized_ quantitative variables
2. Fit $k$-means solutions for $k \in \{1, \ldots, 10\}$
3. Determine an optimal number of clusters
4. Using the centers and the codebook in [`country-data-dictionary.csv`](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/lect-09/public/country-data-dictionary.csv), describe each cluster
5. Which countries are in each cluster? Do the cluster descriptions fit the countries?
6. Are there any adjustments you can make to improve the cluster solution?

---
level: 3
layout: image-right
image: /k-means-elbow.svg
---

# Picking Clusters

```r
d <- read_csv('country-data.csv')

d_std <- d |>
  select(-country) |>
  mutate(across(everything(), ~ scale(.x)[, 1]))

ks <- 1:10
wcss <- vector('numeric', length(ks))

for (k in ks) {
  wcss[k] <- kmeans(d_std,
                    k,
                    iter.max = 1e4,
                    nstart = 1e4)$tot.withinss
}

data.frame(k = ks, wcss = wcss) |>
  ggplot(aes(x = k, y = wcss)) +
  geom_point(color = okabeito_colors(3)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
---

# Fit and Examine a Cluster Solution

- First fit a cluster solution for $k=4$ and look at the centers to describe them

```r
clust_sol <- kmeans(d_std, 4, iter.max = 1e4, nstart = 1e4)

clust_sol$centers
```

- Next, look at which countries are in each cluster. Does it make sense?

```r

d$cluster <- clust_sol$cluster

d$country[d$cluster == 1]
d$country[d$cluster == 2]
d$country[d$cluster == 3]
d$country[d$cluster == 4]

```

---
level: 3
---

# Clustering countries with `hclust()`

Now we can repeat this with `hclust()`:

1. Create dissimilarity objects
2. Fit a hierarchical clustering solution for a few different linkages and pick one that looks "good" to you
3. Determine an optimal number of clusters
4. Describe the clusters


---
level: 3
layout: image-right
image: /single-dendro.svg
---

# Using `hclust()`

- Create a dissimilarity object and find a clustering solution with `hclust()`

```r
d_euc <- dist(d_std)

hc_single <- hclust(d_euc, method = 'single')
```

- Look at the dendrogram

```r
ggdendrogram(hc_single)
```

---
level: 3
layout: image-right
image: /single-height.svg
---

# Height Plots

- Another way to select the number of clusters for a hierarchical solution

```r
single_linkage <- data.frame(
  k = 1:length(hc_single$height),
  height = rev(hc_single$height)
)

ggplot(single_linkage,
       aes(x = k, y = height)) +
  geom_point(color = okabeito_colors(3)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()

```

---
level: 3
---

# Extract Cluster Assignments

- The `cutree()` function will produce a vector of cluster assignments
- I typically assign these to a column in the data frame for future use

```r
d$clust_single <- cutree(hc_single, k = 7)

d$country[d$clust_single == 1]
d$country[d$clust_single == 2]
d$country[d$clust_single == 3]
d$country[d$clust_single == 4]
d$country[d$clust_single == 5]
d$country[d$clust_single == 6]
d$country[d$clust_single == 7]

```


---
level: 3
---

# Clustering countries with `dbscan()`

1. Cluster your data using `dbscan()`, using `MinPts = 5` and `eps = 1`
2. Try some alternate values for `MinPts` and `eps`; what do you notice happens?
3. Describe the clusters from the original solution. Are they similar or different from what you found earlier?


---
level: 3
layout: image-right
image: /dbscan-count.svg
---

```r
clust_dbscan <- dbscan(d_std,
                       MinPts = 5,
                       eps = 1)

d$cluster_dbscan <- clust_dbscan$cluster

table(d$cluster, d$cluster_dbscan)

     0  1  2  3
  1  3  0  0  0
  2 37 50  0  0
  3 42  0  0  5
  4 12  2 16  0

 d |>
  count(cluster, cluster_dbscan) |>
  ggplot(aes(x = cluster,
             y = cluster_dbscan,
             size = n)) +
  geom_point(color=okabeito_colors(3)) +
  theme_bw()
```


---
level: 2
---

# Visualizing High-Dimensional Cluster Solutions

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



---
level: 3
layout: image-right
image: /pairs-plot.svg
---

# Pairs Plot

```r
library(GGally)

ggpairs(
  d,
  mapping = aes(
    color = as.character(cluster),
    fill = as.character(cluster),
    alpha = 0.3
  ),
  columns = 2:10
) +
  scale_color_okabeito() +
  scale_fill_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /pca-plot.svg
---

# Principal Component Projection

```r
library(GGally)

ggpairs(
  d,
  mapping = aes(
    color = as.character(cluster),
    fill = as.character(cluster),
    alpha = 0.3
  ),
  columns = 2:10
) +
  scale_color_okabeito() +
  scale_fill_okabeito() +
  theme_bw()
```