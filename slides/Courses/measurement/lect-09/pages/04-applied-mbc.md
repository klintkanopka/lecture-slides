---
level: 1
layout: section
---

# Applied Model Based Clustering

---
level: 2
---

# Working with `mclust`

- The `mclust` package contains (among other things) a function called `Mclust()`
- This function takes in raw data (not a dissimilarity matrix) and, by default, fits a variety of models
  - You can specify the number of clusters you want, `G`
  - You can also specify the structure of the models you want to consider
  - By default, it returns the best fitting model
- There are built-in `plot()` methods that are actually quite helpful (but also really ugly)
  - They're helpful enough that I tolerate it

---
level: 2
---

# Clustering countries with `Mclust()`

1. Fit a GMM to the data from [`country-data.csv`](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/lect-09/public/country-data.csv)
2. Determine an optimal number _and structure_ of clusters using a `BIC` plot
3. Using the centers and the codebook in [`country-data-dictionary.csv`](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/lect-09/public/country-data-dictionary.csv), describe each cluster
4. Look at the cluster assignments
5. Visualize
6. Compare/contrast with model-free methods


---
level: 3
layout: image-right
image: /gmm-bic.svg
---

# GMM Model Selection

```r
gmm <- Mclust(d_quant)

gmm

# Mclust' model object: (VVE,6)

d$clust_mclust <- gmm$classification

plot(gmm, what = 'BIC')
```


---
level: 3
layout: image-right
image: /gmm-class.svg
---

# GMM Classification

```r
gmm$classification

plot(gmm, what = 'classification')
```

---
level: 3
layout: image-right
image: /gmm-uncertainty.svg
---

# GMM Uncertainty

```r
plot(gmm, what = 'uncertainty')
```


---
level: 3
layout: image-right
image: /gmm-density.svg
---

# GMM Density

```r
plot(gmm, what = 'density')
```