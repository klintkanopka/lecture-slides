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
layout: image-right
image: /k-means-new-k-3.png
---

# Visualize the Solution: $k=3$

```r
ggplot(d, aes(x=x, 
              y=y, 
              color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
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
layout: image-right
image: /k-means-new-k-4.png
---

# Visualize the Solution: $k=4$

```r
ggplot(d, aes(x=x, 
              y=y, 
              color=as.factor(assignment))) +
  geom_point() +
  geom_point(data=centroids, aes(x=x, y=y), 
             color="black", size=4) +
  labs(color='cluster') +
  scale_color_okabeito() +
  theme_bw()
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
  - Pick the "elbow," or the point where adding another cluster doesn't give much improvement


---
level: 3
layout: image-right
image: /k-means-elbow-plot.png
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
    assignment <- GetAssignments(d, 
                                 centroids, 
                                 GetDistances)
    centroids <- RecalculateCentroids(d, 
                                      centroids, 
                                      assignment)
  }
  wcss[k] <- WithinClusterSumSquares(d, 
                                     centroids, 
                                     assignment)
}
cluster_results <- data.frame(k=ks, wcss=wcss)

ggplot(cluster_results, aes(x=k, y=wcss)) +
  geom_point(size=3, color="#59B2D1") +
  geom_line(color="#59B2D1") +
  theme_bw()
```
<arrow v-click x1="700" y1="240" x2="590" y2="345" width="2" color="#df2935" />

