---
level: 2
layout: section
---

# Generalizing our $k$-Means Implementation

---
level: 3
---

# What Do We Need to Do?

1. **Initialize Centroids:**

<v-clicks>

  - *Output*: Dataframe of $k$ centroids
  - *Inputs*: The dataframe we are clustering and $k$

</v-clicks>

2. **Get Cluster Assignments:**

<v-clicks>

  - *Output*: Vector of cluster assignments
  - *Inputs*: Data, centroids, a distance function

</v-clicks>

3. **Recalculate Centroids:**

<v-clicks>

  - *Output*: A dataframe of new centroid locations
  - *Inputs*: Data, centroids, and cluster assignments

</v-clicks>

4. **Evaluation Function:**

<v-clicks>

  - *Output*: Within-cluster sum of squares
  - *Inputs*: Data, centroids, and cluster assignments

</v-clicks>

---
level: 3
---

# Initialize Centroids

````md magic-move
```r
InitializeCentroids <- function(data, k){
  # TODO: Return a dataframe of k starting
  #  centroids, one centroid per row

  return(centroids)
}
```
```r
InitializeCentroids <- function(data, k){
  # TODO: Return a dataframe of k starting
  #  centroids, one centroid per row
  c <- sample(1:nrow(data), k)

  return(centroids)
}
```

```r
InitializeCentroids <- function(data, k){
  # TODO: Return a dataframe of k starting
  #  centroids, one centroid per row
  c <- sample(1:nrow(data), k)
  centroids <- data[c, ]

  return(centroids)
}
```
````

---
level: 3
---

# Get Cluster Assignments

````md magic-move
```r
GetAssignments <- function(data, centroids, distfun){
  # TODO: Return a vector of numeric cluster
  #  assignments by matching each point with
  #  its nearest centroid
  
  return(assignment)
}
```
```r
GetAssignments <- function(data, centroids, distfun){
  # TODO: Return a vector of numeric cluster
  #  assignments by matching each point with
  #  its nearest centroid
  
  dist <- matrix(rep(NA, nrow(data)*nrow(centroids)), 
                 ncol=nrow(centroids))

  return(assignment)
}
```
```r
GetAssignments <- function(data, centroids, distfun){
  # TODO: Return a vector of numeric cluster
  #  assignments by matching each point with
  #  its nearest centroid
  
  dist <- matrix(rep(NA, nrow(data)*nrow(centroids)), 
                 ncol=nrow(centroids))

  for (i in 1:nrow(centroids)){

  }

  return(assignment)
}
```
```r
GetAssignments <- function(data, centroids, distfun){
  # TODO: Return a vector of numeric cluster
  #  assignments by matching each point with
  #  its nearest centroid
  
  dist <- matrix(rep(NA, nrow(data)*nrow(centroids)), 
                 ncol=nrow(centroids))
                 
  for (i in 1:nrow(centroids)){
    dist[,i] <- distfun(data, centroids[i,])
  }

  return(assignment)
}
```
```r
GetAssignments <- function(data, centroids, distfun){
  # TODO: Return a vector of numeric cluster
  #  assignments by matching each point with
  #  its nearest centroid
  
  dist <- matrix(rep(NA, nrow(data)*nrow(centroids)), 
                 ncol=nrow(centroids))

  for (i in 1:nrow(centroids)){
    dist[,i] <- distfun(data, centroids[i,])
  }
  assignment <- max.col(-dist)

  return(assignment)
}
```
````




---
level: 3
---

# Recalculate Centroids

````md magic-move
```r
RecalculateCentroids <- function(data, centroids, assignment){
  # TODO: Return a dataframe of new centroids
  #  calculated from the means of the points 
  #  in each cluster

  return(centroids)
}
```
```r
RecalculateCentroids <- function(data, centroids, assignment){
  # TODO: Return a dataframe of new centroids
  #  calculated from the means of the points 
  #  in each cluster

  for (i in 1:nrow(centroids)){

  }

  return(centroids)
}
```
```r
RecalculateCentroids <- function(data, centroids, assignment){
  # TODO: Return a dataframe of new centroids
  #  calculated from the means of the points 
  #  in each cluster

  for (i in 1:nrow(centroids)){
    centroids[i,] <- colMeans(data[assignment==i,])
  }

  return(centroids)
}
```
````


---
level: 3
---

# Evaluation Function

````md magic-move
```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  # TODO: Return the total within-cluster sum of squares

  return(WCSS)
}
```
```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  # TODO: Return the total within-cluster sum of squares

  for (i in 1:nrow(centroids)){

  }

  return(WCSS)
}
```
```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  # TODO: Return the total within-cluster sum of squares

  for (i in 1:nrow(centroids)){
    GetDistances(data[assignment==i,], centroids[i,])
  }

  return(WCSS)
}
```
```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  # TODO: Return the total within-cluster sum of squares

  for (i in 1:nrow(centroids)){
    GetDistances(data[assignment==i,], centroids[i,])^2
  }

  return(WCSS)
}
```
```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  # TODO: Return the total within-cluster sum of squares

  for (i in 1:nrow(centroids)){
    sum(GetDistances(data[assignment==i,], centroids[i,])^2)
  }

  return(WCSS)
}
```
```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  # TODO: Return the total within-cluster sum of squares

  for (i in 1:nrow(centroids)){
    WCSS <- sum(GetDistances(data[assignment==i,], centroids[i,])^2)
  }

  return(WCSS)
}
```
```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  # TODO: Return the total within-cluster sum of squares

  for (i in 1:nrow(centroids)){
    WCSS <- WCSS + sum(GetDistances(data[assignment==i,], centroids[i,])^2)
  }

  return(WCSS)
}
```
```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  # TODO: Return the total within-cluster sum of squares

  WCSS <- 0
  for (i in 1:nrow(centroids)){
    WCSS <- WCSS + sum(GetDistances(data[assignment==i,], centroids[i,])^2)
  }

  return(WCSS)
}
```
````


---
level: 3
layout: image-right
image: /k-means-new-data.png
---

# Some New Data

```r
set.seed(8675309)

# New data, same solution but larger variance
d <- data.frame(x = c(rnorm(250, 0, 0.5), 
                      rnorm(100, 1, 0.5)),
                y = c(rnorm(250, 1, 0.5), 
                      rnorm(100, 0, 0.5)))

# shuffle to destroy any "known" solution
d <- d[sample(1:nrow(d)),]

# looks worse!
ggplot(d, aes(x=x, y=y)) +
  geom_point() +
  theme_bw()
```


---
level: 3
---

# Putting it All Together

````md magic-move
```r
# TODO: initialize starting values
# TODO: run until convergence
# TODO: get WCSS for cluster solution
```

```r
# TODO: initialize starting values


# TODO: run until convergence
while() {

  
}

# TODO: get WCSS for cluster solution
```

```r
# TODO: initialize starting values


# TODO: run until convergence
while() {


}

# TODO: get WCSS for cluster solution
WithinClusterSumSquares(d, centroids, assignment)
```

```r
# TODO: initialize starting values


# TODO: run until convergence
while() {

  assignment <- GetAssignments(d, centroids, GetDistances)
  centroids <- RecalculateCentroids(d, centroids, assignment)   
}

# TODO: get WCSS for cluster solution
WithinClusterSumSquares(d, centroids, assignment)
```


```r
# TODO: initialize starting values


# TODO: run until convergence
while(!identical(old_centroids, centroids)) {
  old_centroids <- centroids
  assignment <- GetAssignments(d, centroids, GetDistances)
  centroids <- RecalculateCentroids(d, centroids, assignment)   
}

# TODO: get WCSS for cluster solution
WithinClusterSumSquares(d, centroids, assignment)
```

```r
# TODO: initialize starting values
k <- 2
centroids <- InitializeCentroids(d, k)
old_centroids <- InitializeCentroids(d, k)

# TODO: run until convergence
while(!identical(old_centroids, centroids)){
  old_centroids <- centroids
  assignment <- GetAssignments(d, centroids, GetDistances)
  centroids <- RecalculateCentroids(d, centroids, assignment)
}

# TODO: get WCSS for cluster solution
WithinClusterSumSquares(d, centroids, assignment)
```
````

---
level: 3
layout: image-right
image: /k-means-new-k-2.png
---

# Visualize the Solution: $k=2$

```r
ggplot(d, aes(x=x, 
              y=y, 
              color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  theme_bw()
```