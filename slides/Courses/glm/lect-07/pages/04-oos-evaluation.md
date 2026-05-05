---
level: 1
layout: section
---

# Generalized Additive Models

---
level: 2
---

# Motivating Idea

<v-clicks depth="3">

- You want to run the regression:
  - $Y_i = \beta_0 + \beta_1 X_i + \varepsilon_i$
  - You don't think the relationship between $X_i, Y_i$ is linear
  - What can you do?
    - Polynomial transformations
    - ML specifications
    - Something else?
- What about if you have three variables?
  - $Y_i = \beta_0 + \beta_1 X_{1i} + \beta_2 X_{2i} + \beta_3 X_{3i}+ \varepsilon_i$
- Generalized Additive Models (GAMs) allow you to replace coefficients with _smooth functions_ of variables that best fit your data
  - $Y_i = \beta_0 + f_{1}\big(X_{1i}\big) + f_{2}\big(X_{2i}\big) + f_{3}\big(X_{3i}\big) + \varepsilon_i$
  - The model estimates each $f_k (\cdot)$ to best predict the data

</v-clicks>

---
level: 2
---

# Generalized Additive Models in Practice

<v-clicks depth="3">

- The library that holds all the functions you'll need for GAMs is `mgcv`
- The main workhorse functions are going to be `gam()` and `s()`
  - `gam()` takes a formula, data, and an optional `family=` argument, so it handles GLMs natively
  - `s()` is a "smoother" function that fits a flexible curve to your data using _splines_
    - There are a _bunch_ of arguments for `s()`, but today we'll use `k`
    - Higher values of `k` allow for more flexible functions
  - Usage examples:
    - `gam(y ~ x + z, data = d)` fits a standard linear regression, estimating coefficients for $x,z$
    - `gam(y ~ s(x) + z, data = d)` fits a GAM with splines on $x$ and a coefficient on $z$
    - `gam(y ~ s(x) + s(z), data = d)` fits a GAM with (separate) spline functions on $x,z$
    - `gam(y ~ s(x, k=3) + s(z, k=5), data = d)` fits a GAM with (separate) spline functions on $x,z$ where the fit on $z$ is more flexible (wiggly) than the fit on $x$

</v-clicks>

---
level: 3
---

# Simulating Some Data

- Let's simulate something that we'd expect a linear regression to do a bad job with:


```r
set.seed(777)

N <- 1000

d <- data.frame(
  x = rnorm(N),
  z = rnorm(N)
)

d$y <- -8 + 2 * d$x^3 + d$x + 2 * exp(d$z) + rnorm(N)
```

---
level: 3
layout: image-right
image: /gam-1.svg
---

# What does the DGP look like?

```r
ggplot(d, aes(x = x, y = y, color = z)) +
  geom_point(alpha=0.5) +
  scale_color_viridis() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /gam-2.svg
---

# How well does a linear model predict $y$?

```r
m <- lm(y ~ x + z, data = d)

d$y_hat_lm <- predict(m)

ggplot(d, aes(x = y, y = y_hat_lm)) +
  geom_point(alpha=0.2) +
  geom_abline(aes(intercept = 0,
                  slope = 1),
              lty = 2) +
  theme_bw()
```

<v-click>

- Not great in the tails!

</v-click>

---
level: 3
---

# Looking at GAM Output

- Let's start with just an OLS using the `gam()` function:

````md magic-move
```r
m1 <- gam(y ~ x + z, data = d)
summary(m1)
```
```r
m1 <- gam(y ~ x + z, data = d)
summary(m1)

Family: gaussian
Link function: identity

Formula:
y ~ x + z

Parametric coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept)  -4.6969     0.2049  -22.93   <2e-16 ***
x             7.2214     0.2057   35.10   <2e-16 ***
z             3.3351     0.2110   15.80   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


R-sq.(adj) =  0.602   Deviance explained = 60.3%
GCV = 42.087  Scale est. = 41.96     n = 1000
```
````

---
level: 3
---

# Looking at More GAM Output

- Now let's add a smoothing function to $x$:

````md magic-move
```r
m2 <- gam(y ~ s(x) + z, data = d)
summary(m2)
```
```r
m2 <- gam(y ~ s(x) + z, data = d)
summary(m2)

Formula:
y ~ s(x) + z

Parametric coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept)  -4.6833     0.1050  -44.61   <2e-16 ***
z             3.3986     0.1087   31.28   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Approximate significance of smooth terms:
       edf Ref.df     F p-value
s(x) 8.685  8.972 834.4  <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

R-sq.(adj) =  0.895   Deviance explained = 89.6%
GCV = 11.138  Scale est. = 11.019    n = 1000
```
````

---
level: 3
layout: image-right
image: /gam-3.svg
---

# How well does this GAM with a smoother on $x$ predict $y$?

```r
d$y_hat_gam_x <- predict(m2)

ggplot(d, aes(x = y, y = y_hat_gam_x)) +
  geom_point(alpha = 0.2) +
  geom_abline(aes(intercept = 0,
                  slope = 1),
              lty = 2) +
  theme_bw()
```

<v-click>

- Way better!

</v-click>


---
level: 3
---

# Looking at More GAM Output

- Now let's add a smoothing function to $z$:

````md magic-move
```r
m3 <- gam(y ~ x + s(z), data = d)
summary(m3)
```
```r
m3 <- gam(y ~ x + s(z), data = d)
summary(m3)

Formula:
y ~ x + s(z)

Parametric coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept)  -4.6624     0.1753  -26.59   <2e-16 ***
x             7.1789     0.1768   40.61   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Approximate significance of smooth terms:
       edf Ref.df     F p-value
s(z) 6.921  8.036 87.43  <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

R-sq.(adj) =  0.708   Deviance explained = 71.1%
GCV = 31.018  Scale est. = 30.741    n = 1000
```
````

---
level: 3
layout: image-right
image: /gam-4.svg
---

# How well does this GAM with a smoother on $z$ predict $y$?

```r
d$y_hat_gam_z <- predict(m3)

ggplot(d, aes(x = y, y = y_hat_gam_z)) +
  geom_point(alpha = 0.2) +
  geom_abline(aes(intercept = 0,
                  slope = 1),
              lty = 2) +
  theme_bw()
```

<v-clicks>

- Worse than the smoother on $x$, but better than no smoothers at all!
- Turns out the nonlinearity in $x$ is more important than the nonlinearity in $z$

</v-clicks>


---
level: 3
---

# Looking at Even More GAM Output

- Now let's add a smoothing function to $x$ and $z$:

````md magic-move
```r
m4 <- gam(y ~ s(x) + s(z), data = d)
summary(m4)
```
```r
m4 <- gam(y ~ s(x) + s(z), data = d)
summary(m4)

Formula:
y ~ s(x) + s(z)

Parametric coefficients:
            Estimate Std. Error t value Pr(>|t|)
(Intercept) -4.64823    0.03312  -140.4   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Approximate significance of smooth terms:
       edf Ref.df    F p-value
s(x) 8.978  9.000 8092  <2e-16 ***
s(z) 8.932  8.999 2087  <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

R-sq.(adj) =   0.99   Deviance explained =   99%
GCV = 1.1179  Scale est. = 1.0968    n = 1000
```
````

---
level: 3
layout: image-right
image: /gam-5.svg
---

# How well does this GAM with a smoother on $x$ and $z$ predict $y$?

```r
d$y_hat_gam_xz <- predict(m4)

ggplot(d, aes(x = y, y = y_hat_gam_xz)) +
  geom_point(alpha = 0.2) +
  geom_abline(aes(intercept = 0,
                  slope = 1),
              lty = 2) +
  theme_bw()
```

<v-click>

- Turns out, pretty damn well!

</v-click>


---
level: 2
---

# Visualizing Model Response

<v-clicks depth="3">

- When you break into really flexible models, it can be hard to understand what your model is doing
- A good technique to help visualize what your model is doing is to pick a focal variable, $X$, then:
  - Generate a grid of values for $X$ that covers the values in your data
  - Fix the other variables in your dataset to some value (mean, median, some variable of interest, etc)
  - Use the `predict()` function on your model to generate $Y$ values for this new dataset
  - Plot a line for $Y$ vs $X$
- You can also pick two variables and do the same thing
  - Instead of plotting a line, you plot $X_1$ vs $X_2$ and make a heatmap that varies color by $Y$
  - This can help to understand interactions in complex models

</v-clicks>


---
level: 3
layout: image-right
image: /gam-1.svg
---

# Recall the data:

```r
ggplot(d, aes(x = x, y = y, color = z)) +
  geom_point(alpha=0.5) +
  scale_color_viridis() +
  theme_bw()
```

<v-click>

- Let's visualize what the GAM learned from this:

</v-click>

<v-click>

````md magic-move
```r
d_grid <- data.frame(x = seq(from = -4, to = 4,
                             length.out = 1000))
```
```r
d_grid <- data.frame(x = seq(from = -4, to = 4,
                             length.out = 1000))
d_grid$z <- median(d$z)
```
```r
d_grid <- data.frame(x = seq(from = -4, to = 4,
                             length.out = 1000))
d_grid$z <- median(d$z)

d_grid$y_pred <- predict(m4, newdata = d_grid)
```
````

</v-click>


---
level: 3
layout: image-right
image: /gam-6.svg
---

# The Response Function:

- Here's how $y$ varies as a function of $x$ when $z$ is held at its median value:

```r
ggplot(d_grid, aes(x = x, y = y_pred)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()
```

<v-click>

- Looks cubic!

</v-click>

---
level: 3
layout: image-right
image: /gam-7.svg
---

# Let's do the same thing for $z$:

```r
ggplot(d, aes(x = z, y = y, color = x)) +
  geom_point(alpha=0.5) +
  scale_color_viridis() +
  theme_bw()
```

<v-click>

- Let's visualize what the GAM learned from this:

</v-click>

<v-click>

````md magic-move
```r
d_grid <- data.frame(z = seq(from = -4, to = 4,
                             length.out = 1000))
```
```r
d_grid <- data.frame(z = seq(from = -4, to = 4,
                             length.out = 1000))
d_grid$x <- median(d$x)
```
```r
d_grid <- data.frame(z = seq(from = -4, to = 4,
                             length.out = 1000))
d_grid$x <- median(d$x)

d_grid$y_pred <- predict(m4, newdata = d_grid)
```
````

</v-click>


---
level: 3
layout: image-right
image: /gam-8.svg
---

# The Response Function:

- Here's how $y$ varies as a function of $z$ when $x$ is held at its median value:

```r
ggplot(d_grid, aes(z = z, y = y_pred)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()
```

<v-click>

- Looks exponential!

</v-click>


---
level: 3
---

# A New DGP

- Just a sum of inverted quadratics!

```r
d_new <- data.frame(
  x = rnorm(N),
  z = rnorm(N)
)

d_new$y <- 2 * (d_new$x^2) - 2 * (d_new$z^2) + rnorm(N)
m5 <- gam(y ~ s(x) + s(z), data = d_new)
```


---
level: 3
layout: image-right
image: /new-gam-1.svg
---

# Visualizing, starting with $x$

```r
ggplot(d_new, aes(x = x, y = y)) +
  geom_point(alpha = 0.5) +
  theme_bw()
```

<v-click>

- As before!

</v-click>

<v-click>

```r
d_grid <- data.frame(
  x = seq(from = -4,
          to = 4,
          length.out = 1000))
d_grid$z <- median(d$z)

d_grid$y_pred <- predict(m5,
                         newdata = d_grid)
```
</v-click>


---
level: 3
layout: image-right
image: /new-gam-2.svg
---

# The GAM response for $x$ at the median value of $z$

```r
ggplot(d_grid, aes(x = x, y = y_pred)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /new-gam-3.svg
---

# Visualizing for $z$

```r
ggplot(d, aes(x = z, y = y)) +
  geom_point(alpha = 0.5) +
  theme_bw()
```

<v-click>

- One more time!

</v-click>

<v-click>

```r
d_grid <- data.frame(
  z = seq(from = -4,
          to = 4,
          length.out = 1000))
d_grid$x <- median(d$x)

d_grid$y_pred <- predict(m5,
                         newdata = d_grid)
```
</v-click>


---
level: 3
layout: image-right
image: /new-gam-4.svg
---

# The GAM response for $z$ at the median value of $x$

```r
ggplot(d_grid, aes(x = z, y = y_pred)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()
```


---
level: 3
---

# Visualizing $y$ as a function of $x$ and $z$

- Here the strategy is to create a grid of $x$ and $z$ values and predict $y$ across them:

````md magic-move
```r
x <- z <- seq(-4, 4, length.out = 100)
```
```r
x <- z <- seq(-4, 4, length.out = 100)

d_grid <- expand.grid(list(x = x, z = z))

```

```r
x <- z <- seq(-4, 4, length.out = 100)

d_grid <- expand.grid(list(x = x, z = z))

d_grid$y_pred <- predict(m5, newdata = d_grid)
```
````

---
level: 3
layout: image-right
image: /new-gam-5.svg
---

# The GAM response as a function of both $x$ and $z$

```r
ggplot(d_grid, aes(x = x,
                   y = z,
                   fill = y_pred)) +
  geom_tile() +
  coord_equal() +
  scale_fill_viridis() +
  theme_bw()
```