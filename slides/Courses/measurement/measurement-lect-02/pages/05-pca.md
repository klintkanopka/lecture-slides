---
level: 1
layout: section
---

# Principal Components Analysis (PCA)

---
level: 2
hideInToc: true
---

# PCA Overview

- Goal: Summarize your data with fewer variables than you have
- Process: Construct a _principal component_ (kind of a new variable) as a linear combination of the variables you have that minimizes the _reconstruction error_. Then repeat
  - Reconstruction error is the _orthogonal_ distance from each point to the line
- This is usually done with the Singular Value Decomposition
- Note that the task is similar to regression, but you minimize the orthogonal distance from each observation to the line, not the distance from your outcome $y$ to the line!

---
level: 3
layout: image-right
image: /pca-var-1.png
---

# PCA

- The _reconstruction error_ is the sum of the squared orthogonal distances from each point to the pink line
- Represented by the dashed lines


---
level: 3
layout: image-right
image: /pca-var-2.png
---

# PCA

- The _reconstruction error_ is the sum of the squared orthogonal distances from each point to the pink line
- Represented by the dashed lines
- As the line rotates to align with the points, the distances shrink and the projections of each point onto the line spread out

---
level: 3
layout: image-right
image: /pca-var-3.png
---

# PCA

- The _reconstruction error_ is the sum of the squared orthogonal distances from each point to the pink line
- Represented by the dashed lines
- As the line rotates to align with the points, the distances shrink and the projections of each point onto the line spread out
- The first PC does two things:
  1. **Minimizes** the reconstruction error
  2. **Maximizes** the explained variance
- Projections onto the first PC are a single number that retains the most information about the original data



---
level: 3
---

# Estimating Principal Components

```r
library(FactoMineR)
library(factoextra)

# isolate item responses and estimate pca
resp <- select(d, starts_with('d_'))
pca <- PCA(resp, ncp=10, graph=FALSE)

# extract eigenvalue information
pca_eig <- data.frame(pca$eig) |> 
  rownames_to_column(var='dimension')

# extract dimensions/loadings
pca_dim <- data.frame(pca$var$coord) |> 
  rownames_to_column(var='item')

# extract individual scores/projections
pca_resp <- data.frame(pca$ind$coord) |> 
  rownames_to_column(var='person')
```

---
level: 3
---

# Eigenvalues: How many PCs are useful?

|dimension | eigenvalue| percentage.of.variance| cumulative.percentage.of.variance|
|:---------|----------:|----------------------:|---------------------------------:|
|comp 1    |  4.2525175|              28.350117|                          28.35012|
|comp 2    |  2.7113610|              18.075740|                          46.42586|
|comp 3    |  0.9289215|               6.192810|                          52.61867|
|comp 4    |  0.8510230|               5.673486|                          58.29215|
|comp 5    |  0.7637384|               5.091589|                          63.38374|
|comp 6    |  0.7161497|               4.774331|                          68.15807|
|comp 7    |  0.6734326|               4.489551|                          72.64762|



---
level: 3
---

# Option 1: The Kaiser Criterion

- Select all dimensions with an eigenvalue $\geq 1$

|dimension | eigenvalue| percentage.of.variance| cumulative.percentage.of.variance|
|:---------|----------:|----------------------:|---------------------------------:|
|comp 1    |  4.2525175|              28.350117|                          28.35012|
|comp 2    |  2.7113610|              18.075740|                          46.42586|
|comp 3    |  0.9289215|               6.192810|                          52.61867|
|comp 4    |  0.8510230|               5.673486|                          58.29215|

---
level: 3
---

# Option 2: Cumulative Variance

- Pick some cumulative variance that you want (often $50\%$ or $75\%$)
- Retain dimensions until you exceed that threshold

|dimension | eigenvalue| percentage.of.variance| cumulative.percentage.of.variance|
|:---------|----------:|----------------------:|---------------------------------:|
|comp 1    |  4.2525175|              28.350117|                          28.35012|
|comp 2    |  2.7113610|              18.075740|                          46.42586|
|comp 3    |  0.9289215|               6.192810|                          52.61867|
|comp 4    |  0.8510230|               5.673486|                          58.29215|

---
level: 3
layout: image-right
image: /elbow-plot.svg
---

# Option 3: The Elbow Plot

- Plot the variance explained by each dimension
- Drop dimensions that don't contribute much more over the previous dimension
- This means go up to the "elbow"

```r
pca_eig |>
  head(7) |>
  ggplot(aes(
    x = dimension,
    y = percentage.of.variance
  )) +
  geom_col(fill = okabeito_colors(3)) +
  labs(x = 'PC') +
  theme_bw()
```

---
level: 3
zoom: 0.6
---

# Dimensions and Loadings 

|item           |      Dim.1|      Dim.2|      Dim.3|
|:--------------|----------:|----------:|----------:|
|d_rat          | -0.0560027|  0.7478180|  0.3220408|
|d_house_cat    | -0.0499744|  0.7728305|  0.2701365|
|d_medium_dog   |  0.2287211|  0.6610715| -0.0932625|
|d_large_dog    |  0.5124123|  0.2998211| -0.3943514|
|d_kangaroo     |  0.5953089|  0.0527450| -0.1915674|
|d_eagle        |  0.4489964|  0.4131870| -0.3342900|
|d_grizzly_bear |  0.6740091| -0.2427908|  0.3365680|
|d_wolf         |  0.6963379| -0.0183014| -0.1684754|
|d_lion         |  0.7034073| -0.1995300|  0.2621827|
|d_gorilla      |  0.6714172| -0.1993635|  0.2929585|
|d_chimpanzee   |  0.4573127|  0.2369355| -0.0016907|
|d_king_cobra   |  0.6094191|  0.0807483| -0.2753355|
|d_elephant     |  0.6787567| -0.2097299|  0.1498088|
|d_crocodile    |  0.6667268| -0.0949069|  0.1237591|
|d_goose        |  0.0741226|  0.7745679|  0.1725713|

---
level: 3
---

# Individuals

|person |     Dim.1|      Dim.2|      Dim.3|
|:------|---------:|----------:|----------:|
|1      |  0.277625|  1.7352156| -0.7241404|
|2      | -1.362983|  0.4078412|  1.0116342|
|3      | -1.141138|  1.2108529|  0.8180881|
|4      | -1.384454| -1.5588112|  0.0452277|
|5      |  1.669899|  2.1264304| -0.3689416|

---
level: 3
layout: image-right
image: /pca-dim-1.svg
---

# Dimension 1

```r
ggplot(pca_dim, 
       aes(x = Dim.1, 
           y = reorder(item, Dim.1))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, 
             color = okabeito_colors(3)) +
  labs(x = 'Loading', y = 'Item') +
  theme_bw()
```

---
level: 3
layout: image-right
image: /pca-dim-2.svg
---

# Dimension 2

```r
ggplot(pca_dim, 
       aes(x = Dim.2, 
           y = reorder(item, Dim.2))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, 
             color = okabeito_colors(3)) +
  labs(x = 'Loading', y = 'Item') +
  theme_bw()
```

---
level: 3
layout: image-right
image: /pca-dim-3.svg
---

# Dimension 3

```r
ggplot(pca_dim, 
       aes(x = Dim.3, 
           y = reorder(item, Dim.3))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, 
             color = okabeito_colors(3)) +
  labs(x = 'Loading', y = 'Item') +
  theme_bw()
```

---
level: 3
layout: image-right
image: /pca-individuals.svg
---

# Individuals 

```r
ggplot(pca_resp, 
       aes(x = Dim.1, y = Dim.2)) +
  geom_point(alpha = 0.8, size = 1, 
             color = okabeito_colors(2)) +
  theme_bw()
```


---
level: 3
---

# PCA Summary

- Constructs successive **orthogonal** dimensions
- Each dimension maximizes the amount of explained residual variance
- Because dimensions are orthogonal, individual locations along these dimensions are uncorrelated **by construction**
- Variable loadings on dimensions can be used to interpret and describe the dimensions
- Individual projections onto these dimensions can be interpreted as scores along those dimensions