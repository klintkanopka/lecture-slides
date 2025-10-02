---
level: 1
layout: section
---

# Buffon's Needle

---
level: 2
---

# The Problem

Given a needle of length $l$ dropped on a floor with parallel lines distance $t$ apart, what is the probability that the needle will lie across a line when landing?


Plan: 

1. Write a function that simulates tossing one needle on the floor and returns `TRUE` if it crosses a line and `FALSE` otherwise
2. Run the function $10^5$ times
3. Compute the proportion of trials that cross a line

---
level: 3
layout: image
image: /needle.png
---

---
level: 2
---

# Tossing a Needle


````md magic-move
```r
TossNeedle <- function(l, t){
  # TODO: Simulate a needle toss on the floor
  # TODO: Decide if it crosses a threshold
  # TODO: Return TRUE or FALSE depending
  result <- FALSE
  return(result)
}
```
```r
TossNeedle <- function(l, t){
  # TODO: Simulate a needle toss on the floor
  left_edge <- runif(1, min=0, max=t)
  theta <- runif(1, min=-pi/2, max=pi/2)
  # TODO: Decide if it crosses a threshold
  # TODO: Return TRUE or FALSE depending
  result <- FALSE
  return(result)
}
```
```r
TossNeedle <- function(l, t){
  # TODO: Simulate a needle toss on the floor
  left_edge <- runif(1, min=0, max=t)
  theta <- runif(1, min=-pi/2, max=pi/2)
  # TODO: Decide if it crosses a threshold
  right_edge <- left_edge + l * cos(theta)
  result <- right_edge > t
  # TODO: Return TRUE or FALSE depending
  return(result)
}
```
```r
TossNeedle <- function(l, t){
  # TODO: Simulate a needle toss on the floor
  left_edge <- runif(1, min=0, max=t)
  theta <- runif(1, min=-pi/2, max=pi/2)
  # TODO: Decide if it crosses a threshold
  right_edge <- left_edge + l * cos(theta)
  result <- right_edge > t
  # TODO: Return TRUE or FALSE depending
  return(result)
}

TossNeedle(1, 2)
```
```r
TossNeedle <- function(l, t){
  # TODO: Simulate a needle toss on the floor
  left_edge <- runif(1, min=0, max=t)
  theta <- runif(1, min=-pi/2, max=pi/2)
  # TODO: Decide if it crosses a threshold
  right_edge <- left_edge + l * cos(theta)
  result <- right_edge > t
  # TODO: Return TRUE or FALSE depending
  return(result)
}

TossNeedle(1, 2)

# [1] FALSE
```
```r
TossNeedle <- function(l, t){
  # TODO: Simulate a needle toss on the floor
  left_edge <- runif(1, min=0, max=t)
  theta <- runif(1, min=-pi/2, max=pi/2)
  # TODO: Decide if it crosses a threshold
  right_edge <- left_edge + l * cos(theta)
  result <- right_edge > t
  # TODO: Return TRUE or FALSE depending
  return(result)
}

TossNeedle(1, 2)

# [1] FALSE

replicate(3, TossNeedle(1, 2))
```
```r
TossNeedle <- function(l, t){
  # TODO: Simulate a needle toss on the floor
  left_edge <- runif(1, min=0, max=t)
  theta <- runif(1, min=-pi/2, max=pi/2)
  # TODO: Decide if it crosses a threshold
  right_edge <- left_edge + l * cos(theta)
  result <- right_edge > t
  # TODO: Return TRUE or FALSE depending
  return(result)
}

TossNeedle(1, 2)

# [1] FALSE

replicate(3, TossNeedle(1, 2))

# [1]  TRUE FALSE FALSE
```
````


---
level: 3
---

# Tossing Lots of Needles

````md magic-move
```r
mean(replicate(1e5, TossNeedle(1, 2)))
mean(replicate(1e5, TossNeedle(1, 5)))
mean(replicate(1e5, TossNeedle(1, 10)))
```
```r
mean(replicate(1e5, TossNeedle(1, 2)))

# [1] 0.3185

mean(replicate(1e5, TossNeedle(1, 5)))
mean(replicate(1e5, TossNeedle(1, 10)))
```
```r
mean(replicate(1e5, TossNeedle(1, 2)))

# [1] 0.3185

mean(replicate(1e5, TossNeedle(1, 5)))

# [1] 0.12809

mean(replicate(1e5, TossNeedle(1, 10)))
```
```r
mean(replicate(1e5, TossNeedle(1, 2)))

# [1] 0.3185

mean(replicate(1e5, TossNeedle(1, 5)))

# [1] 0.12809

mean(replicate(1e5, TossNeedle(1, 10)))

# [1] 0.06178
```
````
