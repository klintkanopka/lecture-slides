---
level: 1
layout: section
---

# Factor Analysis

---
level: 2
hideInToc: true
---

# (Exploratory) Factor Analysis

- Conceptually different from PCA
- Factor analysis is a latent variable model that seeks to estimate item level associations (loadings) onto latent variables
- The core idea is that levels of the latent variable cause individual item responses, which are observed with error
- "Factor Analysis" is really two things:
  - **Confirmatory Factor Analysis (CFA)** is another name for structural equation modeling (SEM) with item responses
  - **Exploratory Factor Analysis (EFA)** is a dimensionality reduction technique that is conceptually different from PCA but _sometimes_ mathematically identical to PCA
- If you allow for correlated factors, EFA is **not** equivalent to PCA


---
level: 3
layout: image-right
image: /fa-rotation-1.png
---

# EFA

- Similar to PCA, EFA constructs dimensions that are linear combinations of observed variables and projects points onto them
- EFA models are not identified; there are an infinite number of solutions that describe data equally well (factor indeterminacy problem)


---
level: 3
layout: image-right
image: /fa-rotation-2.png
---

# EFA

- Similar to PCA, EFA constructs dimensions that are linear combinations of observed variables and projects points onto them
- EFA models are not identified; there are an infinite number of solutions that describe data equally well (factor indeterminacy problem)
- EFA leverages _rotations_ to solve this that try to pick dimensions to satisfy some sort of logical criterion. Varimax rotation is equivalent to PCA

---
level: 3
layout: image-right
image: /fa-rotation-3.png
---

# EFA

- Similar to PCA, EFA constructs dimensions that are linear combinations of observed variables and projects points onto them
- EFA models are not identified; there are an infinite number of solutions that describe data equally well (factor indeterminacy problem)
- EFA leverages _rotations_ to solve this that try to pick dimensions to satisfy some sort of logical criterion. **Varimax** rotation is equivalent to PCA
- EFA also allows for _oblique_ rotations that produce correlated factors. **Promax** is the most commonly used one


---
level: 3
---

# Estimating EFA

```r
library(psych)

# Check the documentation - it's intense!
?fa

efa_1 <- fa(resp, nfactors = 1, rotate = 'oblimin')
efa_2 <- fa(resp, nfactors = 2, rotate = 'oblimin')
efa_3 <- fa(resp, nfactors = 3, rotate = 'oblimin')
```

---
level: 3
---

# One Factor Solution

```r
efa_1$Vaccounted
```

```
                     MR1
SS loadings    3.6045189
Proportion Var 0.2403013
```

---
level: 3
---

# Two Factor Solution

```r
efa_2$Vaccounted
```

```
                            MR1       MR2
SS loadings           3.6227900 2.1692315
Proportion Var        0.2415193 0.1446154
Cumulative Var        0.2415193 0.3861348
Proportion Explained  0.6254794 0.3745206
Cumulative Proportion 0.6254794 1.0000000
```


---
level: 3
---

# Three Factor Solution

```r
efa_3$Vaccounted
```

```
                            MR1       MR2       MR3
SS loadings           2.5972061 1.8689791 1.7516499
Proportion Var        0.1731471 0.1245986 0.1167767
Cumulative Var        0.1731471 0.2977457 0.4145223
Proportion Explained  0.4177026 0.3005836 0.2817138
Cumulative Proportion 0.4177026 0.7182862 1.0000000
```

---
level: 3
layout: image-right
image: /fa-elbow-plot.svg
---

# Selecting Number of Factors

```r
fa_eigenvalues <- data.frame(factors = 1:6, 
  eigenvalues = efa_3$e.values[1:6])

## Selecting Number of Factors

ggplot(fa_eigenvalues, 
       aes(x = factors, y = eigenvalues)) +
  geom_col(fill = okabeito_colors(3)) +
  geom_point(size = 3) +
  geom_line() +
  geom_hline(aes(yintercept = 1), lty = 2) +
  theme_bw()

```

---
level: 3
layout: image-right
image: /fa-factor-1.svg
---

# Factor 1 Loadings

```r
ggplot(efa, 
       aes(x = MR1, 
           y = reorder(item, MR1))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, 
             color = okabeito_colors(3)) +
  labs(y = 'item', x = 'factor loading') +
  theme_bw()
```

---
level: 3
layout: image-right
image: /fa-factor-2.svg
---

# Factor 2 Loadings

```r
ggplot(efa, 
       aes(x = MR2, 
           y = reorder(item, MR2))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, 
             color = okabeito_colors(3)) +
  labs(y = 'item', x = 'factor loading') +
  theme_bw()
```

---
level: 3
layout: image-right
image: /fa-factor-3.svg
---

# Factor 3 Loadings

```r
ggplot(efa, 
       aes(x = MR3, 
           y = reorder(item, MR3))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, 
             color = okabeito_colors(3)) +
  labs(y = 'item', x = 'factor loading') +
  theme_bw()
```

---
level: 3
---

# Individual Scores

```r
efa_3$scores
```
```
                 MR1           MR2          MR3
   [1,] -0.285443975  8.387273e-01  0.603740923
   [2,] -0.448881256  4.989128e-01 -0.636824429
   [3,] -0.505534260  7.864999e-01 -0.314300349
   [4,] -0.327039053 -8.288798e-01 -0.873253278
   [5,]  0.248132302  9.532238e-01  1.131932390
```

---
level: 3
---

# Factor Analysis Summary

- Constructs latent factors from correlation matrix 
- Rotates factors to allow for correlated factors (dimensions)
- Factor loadings can be used to interpreted and describe the factors
- Individual scores on these factors can be recovered
- Generally, the use and interpretation are the same as in PCA