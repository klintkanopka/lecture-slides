---
level: 1
layout: section
---

# Applying Item Response Theory

---
level: 2
hideInToc: true
---


# A Familiar Dataset

```r
d <- read_rds('animalfights_clean.rds')

# Isolate the item response matrix
resp <- d |> select(starts_with('d_'))
```
---
level: 3
---

# Fitting a 1PL

```r
m_1pl <- mirt(resp, 1, itemtype='Rasch')

# Check default item parameterization
coef(m_1pl)

# Extract something less stupid
params_1pl <- coef(m_1pl, IRTpars = TRUE, simplify = TRUE)

# Generate ability estimates for each person
thetas_1pl <- fscores(m_1pl)

```

---
level: 3
---

# Fitting a 1PL

```r
m_2pl <- mirt(resp, 1, itemtype='2PL')

# Check default item parameterization
coef(m_2pl)

# Extract better item parameters
params_2pl <- coef(m_2pl, IRTpars = TRUE, simplify = TRUE)

# Generate ability estimates for each person
thetas_2pl <- fscores(m_2pl)
```

---
level: 3
---

# Combine Output for Plotting

```r
items <- data.frame(item = rownames(params_1pl$items),
                    b_1pl = params_1pl$items[,2],
                    b_2pl = params_2pl$items[,2],
                    a_2pl = params_2pl$items[,1])

persons <- data.frame(sum_score = rowSums(resp),
                      theta_1pl = as.vector(thetas_1pl),
                      theta_2pl = as.vector(thetas_2pl))

```


---
level: 3
layout: image-right
image: /irt-theta-sum-1pl.svg
---

# Ability Estimation: Sum Score vs. 1PL

```r
ggplot(persons, aes(x = sum_score, 
                    y = theta_1pl)) +
  geom_point(color = okabeito_colors(3), 
             alpha = 0.5) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /irt-theta-sum-2pl.svg
---

# Ability Estimation: Sum Score vs. 2PL

```r
ggplot(persons, aes(x = sum_score, 
                    y = theta_2pl)) +
  geom_point(color = okabeito_colors(3), 
             alpha = 0.5) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /irt-theta-1pl-2pl.svg
---

# Ability Estimation: 1PL vs. 2PL

```r
ggplot(persons, aes(x = theta_1pl, 
                    y = theta_2pl)) +
  geom_point(color = okabeito_colors(3), 
             alpha = 0.5) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /irt-items-diff.svg
---

# Item Difficulties

```r
items |> 
  ggplot(aes(x= b_1pl, 
             y= b_2pl, 
             color=a_2pl, 
             label=item)) +
  geom_point() +
  scale_color_viridis_c() +
  theme_bw()
```

---
level: 3
layout: image
image: /irt-items-labeled.svg
---
