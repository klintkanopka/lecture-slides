---
level: 1
layout: section
---

# Back to Clustering

---
level: 2
layout: section
---

# The $k$-Means Algorithm

---
level: 3
---

# Iterative Clustering using $k$-Means

- We specify some number of clusters, $k$
- Clusters are described by _centroids_, or the center point
- We want to find locations of $k$ centroids that, when we assign our observed points to them, minimize the _within-cluster sum of squares_ (or variance)
- We call it $k$-Means because the location of each centroid is the mean of the coordinates of the points assigned to it!

---
level: 3
---

# Iterative Clustering using $k$-Means

- We follow a two step process:
  1. Assign each point to a cluster by finding the nearest centroid
  2. Move each centroid to the middle of the points assigned to it
- Do this over and over until _convergence_
  - An algorithm _converges_ when additional iterations fail to improve the solution
  - For $k$-Means, convergence is when the centroids stop moving
  - What tool that we have used is a good fit for this task?
  - `while()` loops!

---
level: 3
---

# The $k$-Means Algorithm

1. Select a number of clusters, $k$, and initialize the center of each cluster to a different point in space
2. Assign each observation from the dataset its nearest centroid using the Euclidean distance
3. Move the center of each cluster to the mean value of the coordinates of the points assigned to it
4. Repeat steps 2&3 until the centers stop moving

---
level: 3
---

# Generating Clustered Data

```r
set.seed(8675309)
d <- data.frame(x = c(rnorm(250, 0, 0.25), 
                      rnorm(100, 1, 0.25)),
                y = c(rnorm(250, 1, 0.25), 
                      rnorm(100, 0, 0.25)),
                cluster = c(rep('A', 250), 
                            rep('B', 100)))
```

---
level: 3
layout: image-right
image: /k-means-true-labels.png
---

# Visualizing Clustered Data

```r
ggplot(d, aes(x=x, y=y, color=cluster)) +
  geom_point() +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /k-means-no-labels.png
---

# Visualizing Clustered Data

```r
ggplot(d, aes(x=x, y=y)) +
  geom_point() +
  theme_bw() 
```


---
level: 3
layout: image-right
image: /k-means-centroid-init.png
---

# Generate and Plot Starting Centroids

```r
centroids <- data.frame(x = c(0,1),
                        y = c(0,1))


ggplot(d, aes(x=x, y=y)) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  theme_bw()
```


---
level: 3
---

# Compute Distances from Each Point to a Centroid

````md magic-move
```r
GetDistances <- function(data, centroid){
  # TODO: Compute distance from each point in data 
  #  to a single centroid

  return(distances)
}
```
```r
GetDistances <- function(data, centroid){
  # TODO: Compute distance from each point in data 
  #  to a single centroid

  distances <- sqrt((data[['x']] - centroid[['x']])^2 + 
                      (data[['y']] - centroid[['y']])^2)

  return(distances)
}
```

```r
GetDistances <- function(data, centroid){
  # TODO: Compute distance from each point in data 
  #  to a single centroid

  distances <- sqrt((data[['x']] - centroid[['x']])^2 + 
                      (data[['y']] - centroid[['y']])^2)

  return(distances)
}

GetDistances(d, centroids[2,])[1:5]
```

```r
GetDistances <- function(data, centroid){
  # TODO: Compute distance from each point in data 
  #  to a single centroid

  distances <- sqrt((data[['x']] - centroid[['x']])^2 + 
                      (data[['y']] - centroid[['y']])^2)

  return(distances)
}

GetDistances(d, centroids[2,])[1:5]

# [1] 1.2752070 0.8253962 1.1943523 0.5114553 0.7404843
```
````

---
level: 3
layout: image-right
image: /k-means-assign-1.png
---

# Assign Each Point to the Nearest Centroid

```r
d$assignment <- 
  ifelse(GetDistances(d, centroids[1,]) <= 
          GetDistances(d, centroids[2,]), 
         1, 2)

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```


---
level: 3
layout: image-right
image: /k-means-move-1.png
---

# Move Centroids to the Mean of their Cluster

```r
centroids <- 
  data.frame(x = c(mean(d$x[d$assignment == 1]),
                   mean(d$x[d$assignment == 2])),
             y = c(mean(d$y[d$assignment == 1]),
                   mean(d$y[d$assignment == 2])))

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```


---
level: 3
layout: image-right
image: /k-means-assign-2.png
---

# Second Iteration: Assign Points

```r
d$assignment <- 
  ifelse(GetDistances(d, centroids[1,]) <= 
          GetDistances(d, centroids[2,]), 
         1, 2)

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```


---
level: 3
layout: image-right
image: /k-means-move-2.png
---

# Second Iteration: Move Centroids

```r
centroids <- 
  data.frame(x = c(mean(d$x[d$assignment == 1]),
                   mean(d$x[d$assignment == 2])),
             y = c(mean(d$y[d$assignment == 1]),
                   mean(d$y[d$assignment == 2])))

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /k-means-assign-3.png
---

# Third Iteration: Assign Points

```r
d$assignment <- 
  ifelse(GetDistances(d, centroids[1,]) <= 
          GetDistances(d, centroids[2,]), 
         1, 2)

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```


---
level: 3
layout: image-right
image: /k-means-move-3.png
---

# Third Iteration: Move Centroids

```r
centroids <- 
  data.frame(x = c(mean(d$x[d$assignment == 1]),
                   mean(d$x[d$assignment == 2])),
             y = c(mean(d$y[d$assignment == 1]),
                   mean(d$y[d$assignment == 2])))

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /k-means-assign-4.png
---

# Fourth Iteration: Assign Points

```r
d$assignment <- 
  ifelse(GetDistances(d, centroids[1,]) <= 
          GetDistances(d, centroids[2,]), 
         1, 2)

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```


---
level: 3
layout: image-right
image: /k-means-move-4.png
---

# Fourth Iteration: Move Centroids

```r
centroids <- 
  data.frame(x = c(mean(d$x[d$assignment == 1]),
                   mean(d$x[d$assignment == 2])),
             y = c(mean(d$y[d$assignment == 1]),
                   mean(d$y[d$assignment == 2])))

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /k-means-assign-5.png
---

# Fifth Iteration: Assign Points

```r
d$assignment <- 
  ifelse(GetDistances(d, centroids[1,]) <= 
          GetDistances(d, centroids[2,]), 
         1, 2)

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```


---
level: 3
layout: image-right
image: /k-means-move-5.png
---

# Fifth Iteration: Move Centroids

```r
centroids <- 
  data.frame(x = c(mean(d$x[d$assignment == 1]),
                   mean(d$x[d$assignment == 2])),
             y = c(mean(d$y[d$assignment == 1]),
                   mean(d$y[d$assignment == 2])))

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
 theme_bw()
```

---
level: 3
layout: image-right
image: /k-means-assign-6.png
---

# Sixth Iteration: Assign Points

```r
d$assignment <- 
  ifelse(GetDistances(d, centroids[1,]) <= 
          GetDistances(d, centroids[2,]), 
         1, 2)

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
 theme_bw()
```


---
level: 3
layout: image-right
image: /k-means-move-6.png
---

# Sixth Iteration: Move Centroids

```r
centroids <- 
  data.frame(x = c(mean(d$x[d$assignment == 1]),
                   mean(d$x[d$assignment == 2])),
             y = c(mean(d$y[d$assignment == 1]),
                   mean(d$y[d$assignment == 2])))

ggplot(d, 
       aes(x=x, 
           y=y, 
           color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```


---
level: 3
layout: image-right
image: /k-means-true-final.png
---

# "True" Assignments

```r
ggplot(d, aes(x=x, y=y, color=cluster)) +
  geom_point() +
  geom_point(data=centroids, 
             aes(x=x, y=y), 
             color="black", 
             size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
```