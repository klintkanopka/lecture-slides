---
level: 1
layout: section
---

# Motivating Problem


---
level: 3
---

# Sensitivity to Unusual Points

````md magic-move
```r
d <- data.frame(x = rnorm(50))
d$y <- -1.5 + 3*d$x + rnorm(50, sd=0.5)

m <- lm(y~x, d)
coef(m)
```

```r
d <- data.frame(x = rnorm(50))
d$y <- -1.5 + 3*d$x + rnorm(50, sd=0.5)

m <- lm(y~x, d)
coef(m)

# (Intercept)           x 
#  -1.425421    2.883035 
```
````

---
level: 3
layout: image
image: /overfit-01.png
---

---
level: 3
---

# Sensitivity to Unusual Points

````md magic-move
```r
d2 <- rbind(d, data.frame(x=2, y=-8))

m2 <- lm(y~x, d2)
coef(m2)
```

```r
d2 <- rbind(d, data.frame(x=2, y=-8))

m2 <- lm(y~x, d2)
coef(m2)

# (Intercept)           x 
#   -1.659093    2.391916 
```
````

---
level: 3
layout: image
image: /overfit-02.png
---


---
level: 3
---

# Sensitivity to Unusual Points

````md magic-move
```r
d3 <- rbind(d2, data.frame(x=50, y=-100))
m3 <- lm(y~x, d3)
coef(m3)
```
```r
d3 <- rbind(d2, data.frame(x=50, y=-100))
m3 <- lm(y~x, d3)
coef(m3)

# (Intercept)           x 
#   -1.124650   -1.908941 
```
````

---
level: 3
layout: image
image: /overfit-03.png
---

---
level: 3
---

# Overfitting

- _Overfitting_ occurs when the model you are estimating has too much flexibility and can make large adjustments for small variations in the data it is fit to (or _trained on_)
- Overfitting hurts the ability of your model to _generalize_, or make reasonable predictions with data it hasn't seen yet (we call these predictions _out of sample_, or OOS)
- Overfitting often occurs under one of two conditions:
  1. The individual parameter estimates grow unusually large
  2. Your model has a large number of estimable parameters relative to the amount of data

---
level: 3
layout: image-right
image: /overfit-04.png
---

# Overfitting

- Even a rigid model (like a line) can be pulled around by one unusual point
- What happens when the model itself is flexible?
- We'll plot ten data points and then a polynomial function of best fit:

```r
d <- data.frame(x = rnorm(10))
d$y <- -1.5 + 3*d$x + rnorm(10)

ggplot(d, aes(x=x, y=y)) + 
  geom_point() +
  theme_bw()
```

---
level: 3
layout: image
image: /overfit-05.png
---

---
level: 3
layout: image
image: /overfit-06.png
---

---
level: 3
layout: image
image: /overfit-07.png
---

---
level: 3
layout: image
image: /overfit-08.png
---

---
level: 3
layout: image
image: /overfit-09.png
---

---
level: 3
layout: image
image: /overfit-10.png
---

---
level: 3
layout: image
image: /overfit-11.png
---

---
level: 3
layout: image
image: /overfit-12.png
---

---
level: 3
layout: image
image: /overfit-13.png
---

---
level: 3
layout: image
image: /overfit-14.png
---

---
level: 3
---

# Look at the Coefficients

- The true model is $y = -1.5 + 3x + \varepsilon$, so the only slope we need is 3
- But watch how big the coefficients get as we add polynomial terms (`sqrt(sum(coef(m)[-1]^2))`):

| Degree | 1 | 3 | 5 | 6 | 7 | 8 | 9 |
|---|---|---|---|---|---|---|---|
| $\lVert\beta\rVert_2$ | 2.3 | 2.4 | 7.0 | 46 | 81 | 693 | 991 |

- The degree-9 slopes: $\beta = (7.7,\ -43.8,\ -54.7,\ 303.2,\ 200.4,\ -654.7,\ -380.0,\ 440.4,\ 279.4)$
- Huge coefficients with alternating signs cancel each other out at the 10 training points, and blow up everywhere else
- We never asked for coefficients in the hundreds: OLS chose them because they fit the 10 points perfectly

---
level: 3
layout: image-right
image: /overfit-15.png
---

# Fit vs. Generalization

- Fit each polynomial to the same 10 points
- Then check its error on 10,000 _new_ points from the same population (and the same range of $x$)
- Training error keeps falling as the degree goes up, all the way to zero at degree 9 (plotted at the floor of the log scale)
- Test error is lowest at degree 1 (the true model!), then climbs
  - Degree 1: test MSE = 1.18
  - Degree 9: test MSE = 28.3
- The flexible model memorized the noise in its 10 points
