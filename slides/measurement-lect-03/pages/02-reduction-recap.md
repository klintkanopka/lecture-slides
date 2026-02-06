---
level: 1
layout: section
---

# More PCA and Factor Analysis


---
level: 2
hideInToc: true
---

# What is PCA doing?

- PCA serves to rotate the coordinate axis of your data so that a smaller number of dimensions (variables) can be used to approximate your data
- The first dimension (called a _principal component_) is the single line that explains the most variance in your data
- You find this by minimizing the distance of each point to that line
- To find the next principal component, you subtract out the information captured from that line and find the next best principal component
- Think about this subtraction as squashing the data along your principal component


---
level: 3
---

# Simulating some data

````md magic-move
```r
N <- 100
```
```r
N <- 100
beta_2 <- 1
```
```r
N <- 100
beta_2 <- 1

x <- rnorm(N, mean=0, sd=3)
y <- beta_2*x + rnorm(N)
```
```r
N <- 100
beta_2 <- 1

x <- rnorm(N, mean=0, sd=3)
y <- beta_2*x + rnorm(N)

d <- data.frame(x=x, y=y)
```
```r
N <- 100
beta_2 <- 1

x <- rnorm(N, mean=0, sd=3)
y <- beta_2*x + rnorm(N)

d <- data.frame(x=x, y=y)

d$x_2 <- (x + beta_2 * y) / (beta_2^2 + 1)
d$y_2 <- beta_2 * (x + beta_2 * y) / (beta_2^2 + 1)
```
```r
N <- 100
beta_2 <- 1

x <- rnorm(N, mean=0, sd=3)
y <- beta_2*x + rnorm(N)

d <- data.frame(x=x, y=y)

d$x_2 <- (x + beta_2 * y) / (beta_2^2 + 1)
d$y_2 <- beta_2 * (x + beta_2 * y) / (beta_2^2 + 1)

beta_1 <- beta_2 / 2
```
```r
N <- 100
beta_2 <- 1

x <- rnorm(N, mean=0, sd=3)
y <- beta_2*x + rnorm(N)

d <- data.frame(x=x, y=y)

d$x_2 <- (x + beta_2 * y) / (beta_2^2 + 1)
d$y_2 <- beta_2 * (x + beta_2 * y) / (beta_2^2 + 1)

beta_1 <- beta_2 / 2

d$x_1 <- (x + beta_1 * y) / (beta_1^2 + 1)
d$y_1 <- beta_1 * (x + beta_1 * y) / (beta_1^2 + 1)
```
````

---
level: 3
layout: image-right
image: pca-rot-1.svg
---

# Unrotated $x$-axis

```r
ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.75) +
  geom_hline(aes(yintercept = 0), 
             linewidth = 1, 
             color = okabeito_colors(3)) +
  geom_segment(
    aes(x = x, 
        y = y, 
        xend = x, 
        yend = 0),
        linetype = 2,
        alpha = 0.25
  ) +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  coord_equal() +
  theme_bw()
```

---
level: 3
layout: image-right
image: pca-rot-2.svg
---

# Partially rotated $x$-axis

```r
ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.75) +
  geom_abline(
    aes(intercept = 0, slope = beta_1),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  geom_segment(
    aes(x = x, 
        y = y, 
        xend = x_1, 
        yend = y_1),
        linetype = 2,
        alpha = 0.25
  ) +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  coord_equal() +
  theme_bw()
```


---
level: 3
layout: image-right
image: pca-rot-3.svg
---

# Optimally rotated $x$-axis

```r
ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.75) +
  geom_abline(
    aes(intercept = 0, slope = beta_2),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  geom_segment(
    aes(x = x, 
        y = y, 
        xend = x_2, 
        yend = y_2),
        linetype = 2,
        alpha = 0.25
  ) +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  coord_equal() +
  theme_bw()
```


---
level: 3
---

# Why do we do this?

- When you project a point onto a principal component, you're creating a weighted sum of the variables you started with
- If the weights and patterns of those variables are meaningful, you can interpret what that principal component captures
- Additionally, the first principal components are more informative than any single variable in your original data
  - The _eigenvalues_ tell you how much variance relative to one of the original variables the principal component captures
  - If the eigenvalue of the first principal component is $\lambda_1 = 10$, that single principal component explains $10\times$ the variance of one of your original variables
  - This is why we often use the criterion of keeping principal components with eigenvalues greater than one, as they're more informative than your unrotated variables
  
---
level: 3
---

# PCA vs. Factor Analysis

- The point of PCA is to rotate your coordinates so that you can capture most of your data's information on a smaller number of variables
  - Sometimes we say we are _projecting_ our data onto fewer dimensions
- Factor analysis does basically the same job, but in a _really_ different way
  - A factor is like a dimension or a principal component, it's a new axis to project your higher dimensional data onto
  - Because of the types of available rotations, factors are not restricted to being orthogonal
  

---
level: 3
layout: image
image: fa-rot-1.svg
---

# Unrotated Coordinates

---
level: 3
layout: image
image: fa-rot-2.svg
---

# Orthogonal Rotation of Coordinates (PCA)

---
level: 3
layout: image
image: fa-rot-3.svg
---

# Orthogonal Rotation of Coordinates (not PCA)

---
level: 3
layout: image
image: fa-rot-4.svg
---

# Oblique Rotation of Coordinates (Factor Analysis)


---
level: 3
---

# What is Factor Analysis actually?

- Factor analysis lays out a model:
$$
  \begin{align*}
      \begin{split}
      X_{1i} =& \lambda_{11}\theta_{1i} + \lambda_{12}\theta_{2i} + \cdots + \lambda_{1K}\theta_{Ki} + e_{1i} \\
      X_{2i} =& \lambda_{21}\theta_{1i} + \lambda_{22}\theta_{2i} + \cdots + \lambda_{2K}\theta_{Ki}  + e_{2i} \\
      & \vdots \\
      X_{Mi} =& \lambda_{m1}\theta_{1i} + \lambda_{m2}\theta_{2i} + \cdots + \lambda_{MK}\theta_{Ki}  + e_{Mi} 
      \end{split}
  \end{align*}
$$
- $X_{mi}$ is individual $i$'s observed value of variable $m$ 
- $\lambda_{mk}$ is the _loading_ of factor $k$ onto variable $m$
  - These is the weight of that variable on the dimension defined by that factor
- $\theta_{ki}$ is individual $i$'s _factor score_ on latent factor $k$ 
  - These are the projections of individuals onto the dimensions defined by the factors
- $e_{mi}$ is an error term
- The only things you observe are the $X_{mi}$, so how do you even estimate this?