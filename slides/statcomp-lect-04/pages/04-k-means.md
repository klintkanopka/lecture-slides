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
---

# Visualizing Clustered Data

```r
ggplot(d, aes(x=x, y=y, color=cluster)) +
  geom_point() +
  scale_color_manual(values=c('B'='#8900e1',
                              'A'='#009b8a')) +
  theme_minimal()
```

---
level: 3
---

# Visualizing Clustered Data

```r
ggplot(d, aes(x=x, y=y)) +
  geom_point() +
  theme_minimal()
```


---
level: 3
---

# Generate and Plot Starting Centroids

```r
centroids <- data.frame(x = c(0,1),
                        y = c(0,1))


ggplot(d, aes(x=x, y=y)) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  theme_minimal()
```

---
level: 3
---

# Generate and Plot Starting Centroids

```r
centroids <- data.frame(x = c(0,1),
                        y = c(0,1))


ggplot(d, aes(x=x, y=y)) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  theme_minimal()
```

---
level: 3
---

# Compute Distances from Each Point to a Centroid

```r
GetDistances <- function(data, centroid){
  # TODO: Compute distance from each point in data 
  #  to a single centroid
  
  return(distances)
}
```


---
level: 3
---

# Compute Distances from Each Point to a Centroid

```r
GetDistances <- function(data, centroid){
  distances <- sqrt((data[['x']] - centroid[['x']])^2 + 
                      (data[['y']] - centroid[['y']])^2)
  return(distances)
}

GetDistances(d, centroids[2,])[1:5]
```

---
level: 3
---

# Assign Each Point to the Nearest Centroid

```r
d$assignment <- ifelse(GetDistances(d, centroids[1,]) <= 
                         GetDistances(d, centroids[2,]), 
                       1, 2)

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```

---
level: 3
---

# Assign Each Point to the Nearest Centroid

```r
d$assignment <- ifelse(GetDistances(d, centroids[1,]) <= 
                         GetDistances(d, centroids[2,]), 
                       1, 2)

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```

---
level: 3
---

# Move Centroids to the Mean of their Cluster

```r
centroids <- data.frame(x = c(mean(d$x[d$assignment == 1]),
                              mean(d$x[d$assignment == 2])),
                        y = c(mean(d$y[d$assignment == 1]),
                              mean(d$y[d$assignment == 2])))

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```

---
level: 3
---

# Move Centroids to the Mean of their Cluster

```r
centroids <- data.frame(x = c(mean(d$x[d$assignment == 1]),
                              mean(d$x[d$assignment == 2])),
                        y = c(mean(d$y[d$assignment == 1]),
                              mean(d$y[d$assignment == 2])))

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```

---
level: 3
---

# 2nd Iteration - Assign Points

```r
d$assignment <- ifelse(GetDistances(d, centroids[1,]) <= 
                         GetDistances(d, centroids[2,]), 
                       1, 2)

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```


---
level: 3
---

# 2nd Iteration - Move Centroids

```r
centroids <- data.frame(x = c(mean(d$x[d$assignment == 1]),
                              mean(d$x[d$assignment == 2])),
                        y = c(mean(d$y[d$assignment == 1]),
                              mean(d$y[d$assignment == 2])))

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```

---
level: 3
---

# 3rd Iteration - Assign Points

```r
d$assignment <- ifelse(GetDistances(d, centroids[1,]) <= 
                         GetDistances(d, centroids[2,]), 
                       1, 2)

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```


---
level: 3
---

# 3rd Iteration - Move Centroids

```r
centroids <- data.frame(x = c(mean(d$x[d$assignment == 1]),
                              mean(d$x[d$assignment == 2])),
                        y = c(mean(d$y[d$assignment == 1]),
                              mean(d$y[d$assignment == 2])))

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```

---
level: 3
---

# 4th Iteration - Assign Points

```r
d$assignment <- ifelse(GetDistances(d, centroids[1,]) <= 
                         GetDistances(d, centroids[2,]), 
                       1, 2)

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```


---
level: 3
---

# 4th Iteration - Move Centroids

```r
centroids <- data.frame(x = c(mean(d$x[d$assignment == 1]),
                              mean(d$x[d$assignment == 2])),
                        y = c(mean(d$y[d$assignment == 1]),
                              mean(d$y[d$assignment == 2])))

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```

---
level: 3
---

# 5th Iteration - Assign Points

```r
d$assignment <- ifelse(GetDistances(d, centroids[1,]) <= 
                         GetDistances(d, centroids[2,]), 
                       1, 2)

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```


---
level: 3
---

# 5th Iteration - Move Centroids

```r
centroids <- data.frame(x = c(mean(d$x[d$assignment == 1]),
                              mean(d$x[d$assignment == 2])),
                        y = c(mean(d$y[d$assignment == 1]),
                              mean(d$y[d$assignment == 2])))

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```

---
level: 3
---

# 6th Iteration - Assign Points

```r
d$assignment <- ifelse(GetDistances(d, centroids[1,]) <= 
                         GetDistances(d, centroids[2,]), 
                       1, 2)

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```


---
level: 3
---

# 6th Iteration - Move Centroids

```r
centroids <- data.frame(x = c(mean(d$x[d$assignment == 1]),
                              mean(d$x[d$assignment == 2])),
                        y = c(mean(d$y[d$assignment == 1]),
                              mean(d$y[d$assignment == 2])))

ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('1'='#8900e1',
                              '2'='#009b8a')) +
  theme_minimal()
```


---
level: 3
---

# "True" Assignments

```r
ggplot(d, aes(x=x, y=y, color=cluster)) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_manual(values=c('B'='#8900e1',
                              'A'='#009b8a')) +
  theme_minimal()
```


---
level: 2
layout: section
---

# Generalizing our $k$-Means Implementation

---
level: 3
---

# What Do We Need to Do?

1. Initialize Centroids:
  - *Output*: Dataframe of $k$ centroids
  - *Inputs*: The dataframe we are clustering and $k$
2. Get Cluster Assignments:
  - *Output*: Vector of cluster assignments
  - *Inputs*: Data, centroids, a distance function
3. Recalculate Centroids:
  - *Output*: A dataframe of new centroid locations
  - *Inputs*: Data, centroids, and cluster assignments
4. Evaluation Function:
  - *Output*: Within-cluster sum of squares
  - *Inputs*: Data, centroids, and cluster assignments

---
level: 3
---

# Initialize Centroids

```r
InitializeCentroids <- function(data, k){
  # TODO: Return a dataframe of k starting
  #  centroids, one centroid per row
  
  return(centroids)
}
```

---
level: 3
---

# Initialize Centroids

```r
InitializeCentroids <- function(data, k){
  c <- sample(1:nrow(data), k)
  centroids <- data[c, ]
  return(centroids)
}
```

---
level: 3
---

# Get Cluster Assignments

```r
GetAssignments <- function(data, centroids, distfun){
  # TODO: Return a vector of numeric cluster
  #  assignments by matching each point with
  #  its nearest centroid
  
  return(assignment)
}
```


---
level: 3
---

# Get Cluster Assignments

```r
GetAssignments <- function(data, centroids, distfun){
  dist <- matrix(rep(NA, nrow(data)*nrow(centroids)), 
                 ncol=nrow(centroids))
  for (i in 1:nrow(centroids)){
    dist[,i] <- distfun(data, centroids[i,])
  }
  assignment <- max.col(-dist)
  return(assignment)
}
```



---
level: 3
---

# Recalculate Centroids

```r
RecalculateCentroids <- function(data, centroids, assignment){
  # TODO: Return a dataframe of new centroids
  #  calculated from the means of the points 
  #  in each cluster
  
  return(centroids)
}
```



---
level: 3
---

# Recalculate Centroids

```r
RecalculateCentroids <- function(data, centroids, assignment){
  for (i in 1:nrow(centroids)){
    centroids[i,] <- colMeans(data[assignment==i,])
  }
  return(centroids)
}
```


---
level: 3
---

# Evaluation Function

```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  # TODO: Return the total within-cluster sum of squares
  
  return(WCSS)
}
```


---
level: 3
---

# Evaluation Function

```r
WithinClusterSumSquares <- function(data, centroids, assignment){
  WCSS <- 0
  for (i in 1:nrow(centroids)){
    WCSS <- WCSS + sum(GetDistances(data[assignment==i,], 
                                    centroids[i,])^2)
  }
  return(WCSS)
}
```


---
level: 3
---

# Some New Data

```r
# New data, same solution but larger variance
d <- data.frame(x = c(rnorm(250, 0, 0.5), 
                      rnorm(100, 1, 0.5)),
                y = c(rnorm(250, 1, 0.5), 
                      rnorm(100, 0, 0.5)))
# shuffle to destroy any "known" solution
d <- d[sample(1:nrow(d)),]

# looks worse
ggplot(d, aes(x=x, y=y)) +
  geom_point() +
  theme_bw()
```


---
level: 3
---

# Some New Data

```r
set.seed(8675309)
d <- data.frame(x = c(rnorm(250, 0, 0.5), 
                      rnorm(100, 1, 0.5)),
                y = c(rnorm(250, 1, 0.5), 
                      rnorm(100, 0, 0.5)))

d <- d[sample(1:nrow(d)),]

ggplot(d, aes(x=x, y=y)) +
  geom_point() +
  theme_minimal()
```


---
level: 3
---

# Putting it All Together

```r
# TODO: initialize starting values


# TODO: run until convergence
while() {

  
}

# TODO: get WCSS for cluster solution
```

---
level: 3
---

# Putting it All Together

```r
# TODO: initialize starting values


# TODO: run until convergence
while() {


}

# TODO: get WCSS for cluster solution
WithinClusterSumSquares(d, centroids, assignment)
```

---
level: 3
---

# Putting it All Together

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

---
level: 3
---

# Putting it All Together

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



---
level: 3
---

# Putting it All Together: $k=2$

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


---
level: 3
---

# Visualize the Solution: $k=2$

```r
ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  theme_minimal()
```

---
level: 3
---

# What About $k=3$?

```r
# TODO: initialize starting values
k <- 3
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


---
level: 3
---

# Visualize the Solution: $k=3$

```r
ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  theme_minimal()
```

---
level: 3
---

# What About $k=4$?

```r
# TODO: initialize starting values
k <- 4
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


---
level: 3
---

# Visualize the Solution: $k=4$

```r
ggplot(d, aes(x=x, y=y, color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  theme_minimal()
```

---
level: 3
---

# How Do You Decide What the Right Answer is?

- You'll never know the right answer!
- Look at some evaluation metric
  - Here we use within-cluster variance
  - Other ones exist (like silhouette scores)
- The problem is that adding an additional cluster always makes the evaluation metric go down
- Ask "when does adding another cluster stop making a big difference in my evaluation metric?"
  - This is a judgement call!
  - Often we look at "scree plot" and try and identify the "elbow"
  - Plot WCSS vs. $k$


---
level: 3
---

# The Elbow Plot

```r
ks <- 1:12
wcss <- vector('numeric', length(ks))

for (k in ks){
  centroids <- InitializeCentroids(d, k)
  old_centroids <- InitializeCentroids(d, k)

  while(!identical(old_centroids, centroids)){
    old_centroids <- centroids
    assignment <- GetAssignments(d, centroids, GetDistances)
    centroids <- RecalculateCentroids(d, centroids, assignment)
  }

  wcss[k] <- WithinClusterSumSquares(d, centroids, assignment)
}

cluster_results <- data.frame(k=ks, wcss=wcss)

ggplot(cluster_results, aes(x=k, y=wcss)) +
  geom_point(size=3, color="#59B2D1") +
  geom_line(color="#59B2D1") +
  theme_minimal()
```