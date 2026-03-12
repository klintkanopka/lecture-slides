---
level: 1
layout: section
---

# Applied Clustering


---
level: 2
hideInToc: true
---

# Applied clustering (and taking a break)

- Start by downloading [this data](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/measurement-lect-08/public/drug_use_personality.csv). It has measurements of the Big 5 Personality traits (plus impulsivity and sensation seeking), drug use history, and some basic demographics
- With a group:
  1. Prepare the personality trait data for clustering
    - Isolate the personality trait data
    - Drop missing values
    - Standardize each of the personality traits to have mean zero and variance one
  2. Determine the optimal number of clusters
    - Using the `fviz_nbclust()` function from the `factoextra` library, plot the within cluster sum of squares, gap statistic, and silhouette scores for $k\in \{2, \ldots, 10\}$ clusters

---
level: 3
layout: image-right
image: /personality-dist.svg
---

# Data Preparation

```r
d <- read_csv('drug_use_personality.csv')

d_clust <- select(
  d, 
  neuroticism:sensation_seeking
  ) |>
  mutate(across(everything(), ~ scale(.x)[,1]))

d_clust |>
  pivot_longer(
    everything(), 
    names_to = 'var', 
    values_to = 'value'
    ) |>
  ggplot(aes(x = value, fill = var)) +
  geom_density(show.legend = FALSE) +
  facet_grid(var ~ .) +
  scale_fill_okabeito() +
  theme_bw()
```


---
level: 3
layout: image-right
image: /clust-wss.svg
---

# Within-Cluster Sum of Squares

- Measures how close together points in a cluster are
- A measure of within cluster variance
- Read this like an elbow plot from PCA or factor analysis

```r
fviz_nbclust(d_clust, kmeans, 'wss')
```


---
level: 3
layout: image-right
image: /clust-silhouette.svg
---

# Silhouette Scores

- Balance of two statistics:
  - **Cohesion**: How similar are points within their own cluster
  - **Separation**: How different are points across clusters
- Higher is better!

```r
fviz_nbclust(d_clust, kmeans, 'silhouette')

```

---
level: 3
layout: image-right
image: /clust-gap.svg
---

# Gap Statistics

- Compares the quality of a cluster solution in your data to the same solution applied to random data
- Higher is better!

```r
fviz_nbclust(d_clust, kmeans, 'gap')
```

---
level: 3
---

# Fitting and describing a $k$-means solution

1. Fit a cluster model for $k=3$ clusters using the `kmeans()` function
  - Set `nstart = 100` to fit multiple solutions and automatically pick the best one
2. Name each cluster based on the mean and distribution of personality traits
  - Extract the centers using `m$center`
  - Extract each point's cluster assignment using `m$cluster`
3. Determine (demographically) who comprises each cluster
4. Describe the drug use history of each cluster



---
level: 3
layout: image-right
image: /clust-centroids.svg
---

# Naming Clusters

- The process is similar to what we did with factors
- Consider both the mean value of each variable in each cluster as well as the distribution of that variable

```r
c <- kmeans(d_clust, 3, nstart = 100)
data.frame(c$centers) |>
  rownames_to_column('cluster') |>
  pivot_longer(
    -cluster, 
    names_to = 'trait', 
    values_to = 'mean') |>
  ggplot(aes(x = mean, 
             y = trait, 
             fill = cluster)) +
  geom_col(show.legend = FALSE) +
  facet_grid(cluster ~ .) +
  scale_fill_okabeito() +
  labs(y = NULL) +
  theme_bw()
```



---
level: 3
layout: image-right
image: /clust-age.svg
---

# Cluster Ages

```r
ggplot(d, 
  aes(x = age, 
      fill = as.character(cluster))) +
  geom_bar(show.legend = FALSE) +
  facet_wrap(cluster ~ ., nrow = 3) +
  scale_fill_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /clust-drugs.svg
---

# Drug Use

```r
d |>
  select(
    cluster, 
    ends_with('ever'), 
    ends_with('year'), 
    ends_with('week')
    ) |>
  group_by(cluster) |>
  summarize(across(everything(), mean)) |>
  pivot_longer(
    -cluster, 
    names_to = 'drug', 
    values_to = 'p'
    ) |>
  ggplot(aes(y = drug, 
             x = p, 
             fill = as.character(cluster))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(cluster ~ ., ncol = 1) +
  scale_fill_okabeito() +
  labs(y = NULL) +
  theme_bw()
```

---
level: 3
---

# Fitting hierarchical clustering solutions

1. Compute a dissimilarity matrix using the `dist` function with Euclidean distance
2. Fit `hclust` models with both `complete` and `single` linkages
3. Plot the dendrograms by calling `plot()` on the `hclust` object
4. Decide on how many clusters to retain


---
level: 3
layout: image-right
image: /hclust-complete.svg
---

# Complete Linkage

```r
d_dist <- dist(d_clust, 
               method = 'euclidean')

c_complete <- hclust(d_dist, 
                     method = 'complete')

plot(c_complete)

fviz_dend(c_complete)
```



---
level: 3
layout: image-right
image: /hclust-single.svg
---

# Single Linkage

```r
c_single <- hclust(d_dist, 
                   method = 'single')

plot(c_single)

fviz_dend(c_single)
```
