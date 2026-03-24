---
level: 1
---

# A (Much) Harder Problem

**Given a list of cities and the distances between each pair of cities, what is the shortest possible route that visits each city exactly once and returns to the origin city?**

- Known as the “Traveling Salesman Problem” (TSP)
- NP-Hard Problem
- We think (but have not proven) that there are no polynomial-time algorithms to solve NP-Hard problems
- The issue is that this problem is non-convex, meaning that we're not trying to find the min/max on some smooth curve that's a function of some variables!
- This makes optimization potentially trickier than what we’ve dealt with so far!

---
level: 3
---

# Plan of Attack

- Write down a function to minimize
- Decide how to explore the solution space
- MCMC the hell out of it!


---
level: 2
---

# The Traveling Salesman with MCMC

First, we generate a matrix that holds distances between locations:

````md magic-move
```r
n_locations <- 10
dist_mat <- matrix(0, nrow=n_locations, ncol=n_locations)

```
```r
n_locations <- 10
dist_mat <- matrix(0, nrow=n_locations, ncol=n_locations)

for (i in 1:n_locations){
  for (j in 1:n_locations){

  }
}
```
```r
n_locations <- 10
dist_mat <- matrix(0, nrow=n_locations, ncol=n_locations)

for (i in 1:n_locations){
  for (j in 1:n_locations){
    if (i == j){
      dist_mat[i,j] <- 0
    }
  }
}
```
```r
n_locations <- 10
dist_mat <- matrix(0, nrow=n_locations, ncol=n_locations)

for (i in 1:n_locations){
  for (j in 1:n_locations){
    if (i == j){
      dist_mat[i,j] <- 0
    } else if (j > i){
      dist_mat[i,j] <- runif(1, min=1, max=10)
    }
  }
}
```
```r
n_locations <- 10
dist_mat <- matrix(0, nrow=n_locations, ncol=n_locations)

for (i in 1:n_locations){
  for (j in 1:n_locations){
    if (i == j){
      dist_mat[i,j] <- 0
    } else if (j > i){
      dist_mat[i,j] <- runif(1, min=1, max=10)
    } else if (j < i) {
      dist_mat[i,j] <- dist_mat[j,i]
    }
  }
}
```
```r
n_locations <- 10
dist_mat <- matrix(0, nrow=n_locations, ncol=n_locations)

for (i in 1:n_locations){
  for (j in 1:n_locations){
    if (i == j){
      dist_mat[i,j] <- 0
    } else if (j > i){
      dist_mat[i,j] <- runif(1, min=1, max=10)
    } else if (j < i) {
      dist_mat[i,j] <- dist_mat[j,i]
    }
  }
}

dist_mat[1:3, 1:3]
```
```r
n_locations <- 10
dist_mat <- matrix(0, nrow=n_locations, ncol=n_locations)

for (i in 1:n_locations){
  for (j in 1:n_locations){
    if (i == j){
      dist_mat[i,j] <- 0
    } else if (j > i){
      dist_mat[i,j] <- runif(1, min=1, max=10)
    } else if (j < i) {
      dist_mat[i,j] <- dist_mat[j,i]
    }
  }
}

dist_mat[1:3, 1:3]

#           [,1]     [,2]     [,3] 
#  [1,] 0.000000 4.388056 8.869981 
#  [2,] 4.388056 0.000000 3.998735 
#  [3,] 8.869981 3.998735 0.000000
```
````
---
level: 3
---

# The Traveling Salesman with MCMC

Next, we need a loss function to evaluate the total trip length of our proposed solution:

````md magic-move
```r
TripDist <- function(path, dist_matrix){

}
```
```r
TripDist <- function(path, dist_matrix){
  total_dist <- 0

  return(total_dist)
}
```
```r
TripDist <- function(path, dist_matrix){
  total_dist <- 0
  for (i in seq_along(path)){

  }
  return(total_dist)
}
```
```r
TripDist <- function(path, dist_matrix){
  total_dist <- 0
  for (i in seq_along(path)){
    total_dist <- total_dist + dist_mat[path[i], path[i+1]]
  }
  return(total_dist)
}
```
```r
TripDist <- function(path, dist_matrix){
  total_dist <- 0
  for (i in seq_along(path)){
    if (i == length(path)) {
      total_dist <- total_dist + dist_mat[path[i], path[1]]
    } else {
      total_dist <- total_dist + dist_mat[path[i], path[i+1]]
    }
  }
  return(total_dist)
}
```
```r
TripDist <- function(path, dist_matrix){
  total_dist <- 0
  for (i in seq_along(path)){
    if (i == length(path)) {
      total_dist <- total_dist + dist_mat[path[i], path[1]]
    } else {
      total_dist <- total_dist + dist_mat[path[i], path[i+1]]
    }
  }
  return(total_dist)
}

TripDist(1:10, dist_mat)
```
```r
TripDist <- function(path, dist_matrix){
  total_dist <- 0
  for (i in seq_along(path)){
    if (i == length(path)) {
      total_dist <- total_dist + dist_mat[path[i], path[1]]
    } else {
      total_dist <- total_dist + dist_mat[path[i], path[i+1]]
    }
  }
  return(total_dist)
}

TripDist(1:10, dist_mat)

# [1] 51.36853
```
````

---
level: 3
---

# The Traveling Salesman with MCMC

Finally, we need a "transition matrix"---something to draw our new proposal from:

````md magic-move
```r
PermutePath <- function(path){

}
```
```r
PermutePath <- function(path){
  new_path <- path
  return(new_path)
}
```
```r
PermutePath <- function(path){
  new_path <- path
  p <- sample(1:length(path), 1)
  return(new_path)
}
```
```r
PermutePath <- function(path){
  new_path <- path
  p <- sample(1:length(path), 1)
  new_path[p] <- path[p+1]
  new_path[p+1] <- path[p]
  return(new_path)
}
```
```r
PermutePath <- function(path){
  new_path <- path
  p <- sample(1:length(path), 1)
  if (p == length(path)){
    new_path[p] <- path[1]
    new_path[1] <- path[p]
  } else {
    new_path[p] <- path[p+1]
    new_path[p+1] <- path[p]
  }
  return(new_path)
}
```
```r
PermutePath <- function(path){
  new_path <- path
  p <- sample(1:length(path), 1)
  if (p == length(path)){
    new_path[p] <- path[1]
    new_path[1] <- path[p]
  } else {
    new_path[p] <- path[p+1]
    new_path[p+1] <- path[p]
  }
  return(new_path)
}

PermutePath(1:10)
```
```r
PermutePath <- function(path){
  new_path <- path
  p <- sample(1:length(path), 1)
  if (p == length(path)){
    new_path[p] <- path[1]
    new_path[1] <- path[p]
  } else {
    new_path[p] <- path[p+1]
    new_path[p+1] <- path[p]
  }
  return(new_path)
}

PermutePath(1:10)

#  [1]  1  2  3  4  5  6  7  8 10  9
```
````

---
level: 3
---

# The Traveling Salesman with MCMC

Now we implement MCMC:

````md magic-move
```r
points <- 1:n_locations

path <- sample(points)

new_path <- PermutePath(path)

if (TripDist(new_path, dist_mat)<TripDist(path, dist_mat) | runif(1)<temp){
  path <- new_path
}
```
```r
points <- 1:n_locations

path <- sample(points)
best <- path

new_path <- PermutePath(path)

if (TripDist(new_path, dist_mat)<TripDist(path, dist_mat) | runif(1)<temp){
  path <- new_path
}

if (TripDist(path, dist_matrix) < TripDist(best, dist_mat)){
  best <- path
}
```
```r
points <- 1:n_locations
N_iter <- 1e6
temp <- 0.001

path <- sample(points)
best <- path

for (i in 1:N_iter){
  new_path <- PermutePath(path)
  if (TripDist(new_path, dist_mat)<TripDist(path, dist_mat) | runif(1)<temp){
    path <- new_path
  }
  if (TripDist(path, dist_matrix) < TripDist(best, dist_mat)){
    best <- path
  }
}

```
```r
points <- 1:n_locations
N_iter <- 1e6
temp <- 0.001

dist <- vector('numeric', length=N_iter)
path <- sample(points)
best <- path

for (i in 1:N_iter){
  new_path <- PermutePath(path)
  if (TripDist(new_path, dist_mat)<TripDist(path, dist_mat) | runif(1)<temp){
    path <- new_path
  }
  if (TripDist(path, dist_matrix) < TripDist(best, dist_mat)){
    best <- path
  }
  dist[i] <- TripDist(path, dist_mat)
}

```
```r
points <- 1:n_locations
N_iter <- 1e6
Ts <- c(0, 0.001, 0.005, 0.01, 0.05)

dist <- vector('numeric', length=N_iter)
path <- sample(points)
best <- path

for (i in 1:N_iter){
  new_path <- PermutePath(path)
  if (TripDist(new_path, dist_mat)<TripDist(path, dist_mat) | runif(1)<temp){
    path <- new_path
  }
  if (TripDist(path, dist_matrix) < TripDist(best, dist_mat)){
    best <- path
  }
  dist[i] <- TripDist(path, dist_mat)
}

```
```r
points <- 1:n_locations
N_iter <- 1e6
Ts <- c(0, 0.001, 0.005, 0.01, 0.05)

for (j in seq_along(Ts)){
  dist <- vector('numeric', length=N_iter)
  path <- sample(points)
  best <- path
  for (i in 1:N_iter){
    new_path <- PermutePath(path)
    if (TripDist(new_path, dist_mat)<TripDist(path, dist_mat) | runif(1)<Ts[j]){
      path <- new_path
    }
    if (TripDist(path, dist_matrix) < TripDist(best, dist_mat)){
      best <- path
    }
    dist[i] <- TripDist(path, dist_mat)
  }
}
```
```r
points <- 1:n_locations
N_iter <- 1e6
Ts <- c(0, 0.001, 0.005, 0.01, 0.05)
conv <- best <- vector('list', length=length(Ts))
for (j in seq_along(Ts)){
  dist <- vector('numeric', length=N_iter)
  path <- sample(points)
  best[[j]] <- path
  for (i in 1:N_iter){
    new_path <- PermutePath(path)
    if (TripDist(new_path, dist_mat)<TripDist(path, dist_mat) | runif(1)<Ts[j]){
      path <- new_path
    }
    if (TripDist(path, dist_matrix) < TripDist(best[[j]], dist_mat)){
      best[[j]] <- path
    }
    dist[i] <- TripDist(path, dist_mat)
  }
}
```
```r
points <- 1:n_locations
N_iter <- 1e6
Ts <- c(0, 0.001, 0.005, 0.01, 0.05)
conv <- best <- vector('list', length=length(Ts))
for (j in seq_along(Ts)){
  dist <- vector('numeric', length=N_iter)
  path <- sample(points)
  best[[j]] <- path
  for (i in 1:N_iter){
    new_path <- PermutePath(path)
    if (TripDist(new_path, dist_mat)<TripDist(path, dist_mat) | runif(1)<Ts[j]){
      path <- new_path
    }
    if (TripDist(path, dist_matrix) < TripDist(best[[j]], dist_mat)){
      best[[j]] <- path
    }
    dist[i] <- TripDist(path, dist_mat)
  }
  conv[[j]] <- data.frame(i = 1:N_iter, dist=dist, T=Ts[j])
}
```
````

---
level: 3
---

# Traveling Salesman Results by Temperature

````md magic-move
```r
for (j in 1:length(Ts)) {
  print(Ts[j])
  print(best[[j]])
  print(TripDist(best[[j]], dist_mat))
}
```
```r
for (j in 1:length(Ts)) {
  print(Ts[j])
  print(best[[j]])
  print(TripDist(best[[j]], dist_mat))
}

# [1] 0
# [1]  7  9  5  3 10  2  1  6  8  4
# [1] 35.75039
```
```r
for (j in 1:length(Ts)) {
  print(Ts[j])
  print(best[[j]])
  print(TripDist(best[[j]], dist_mat))
}

# [1] 0
# [1]  7  9  5  3 10  2  1  6  8  4
# [1] 35.75039
# [1] 0.001
# [1]  7  9  2 10  3  5  6  1  8  4
# [1] 32.90462
```
```r
for (j in 1:length(Ts)) {
  print(Ts[j])
  print(best[[j]])
  print(TripDist(best[[j]], dist_mat))
}

# [1] 0
# [1]  7  9  5  3 10  2  1  6  8  4
# [1] 35.75039
# [1] 0.001
# [1]  7  9  2 10  3  5  6  1  8  4
# [1] 32.90462
# [1] 0.005
# [1]  2 10  9  1  6  3  5  8  4  7
# [1] 32.65007
```
```r
for (j in 1:length(Ts)) {
  print(Ts[j])
  print(best[[j]])
  print(TripDist(best[[j]], dist_mat))
}

# [1] 0
# [1]  7  9  5  3 10  2  1  6  8  4
# [1] 35.75039
# [1] 0.001
# [1]  7  9  2 10  3  5  6  1  8  4
# [1] 32.90462
# [1] 0.005
# [1]  2 10  9  1  6  3  5  8  4  7
# [1] 32.65007
# [1] 0.01
# [1]  8  4  7  2 10  9  1  6  3  5
# [1] 32.65007
```
```r
for (j in 1:length(Ts)) {
  print(Ts[j])
  print(best[[j]])
  print(TripDist(best[[j]], dist_mat))
}

# [1] 0
# [1]  7  9  5  3 10  2  1  6  8  4
# [1] 35.75039
# [1] 0.001
# [1]  7  9  2 10  3  5  6  1  8  4
# [1] 32.90462
# [1] 0.005
# [1]  2 10  9  1  6  3  5  8  4  7
# [1] 32.65007
# [1] 0.01
# [1]  8  4  7  2 10  9  1  6  3  5
# [1] 32.65007
# [1] 0.05
# [1]  6  1  9 10  2  7  4  8  5  3
# [1] 32.65007
```
````


---
level: 3
layout: image-right
image: /traveling-salesman.png
---

# Traveling Salesman Results by Temperature

```r
conv <- do.call('rbind', conv)

ggplot(conv, 
       aes(x=i, 
           y=dist,  
           color=as.character(T))) +
  geom_line() +
  facet_grid(T~.) +
  labs(x='iteration', 
       y='distance', 
       color='temp') +
  theme_bw()
```
