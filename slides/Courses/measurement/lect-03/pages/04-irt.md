---
level: 1
layout: section
---

# Item Response Theory

---
level: 2
hideInToc: true
---


# Why not sum scores?

- Not all items are created equal!

<v-clicks>

$$7 \times 8 = ?$$
$$9 - 3 \div \frac{1}{3} + 1 = ?$$
$$\int_0^\pi \sin x \ dx = ?$$  

</v-clicks>

---
level: 3
---

# Item Response Theory

- At its core, a probabilistic model that describes how individuals generate responses to individual items
- Produces parameters that describe specific items _independent_ of the sample of respondents used to calibrate them
- Estimates person ability and item difficulty on a common scale
- Produces ability estimates _independent_ of the specific items on a test form
- Can produce interval scales (this is a Rasch thing)

---
level: 3
---

# The most basic IRT model

$$P(X_{ij} = 1 | \theta_i) = \frac{1}{1 + e^{-(\theta_i - b_j)}}$$

- We refer to this as a _one parameter logistic model_, or 1PL
- This is the core model used in Rasch measurement
- Model parameters:
  - $X_{ij}$ is individual $i$'s response to item $j$
  - $\theta_i$ is individual $i$'s latent ability
  - $b_j$ is the difficulty of item $j$
- Note that the only thing the probability depends on is the _difference_ $(\theta_i - b_j)$
  - When $\theta_i = b_j$, $P(X_{ij}=1) = 0.5$
  - When $\theta_i < b_j$, $P(X_{ij}=1) \in (0,0.5)$
  - When $\theta_i > b_j$, $P(X_{ij}=1) \in (0.5,1)$
  
---
level: 3
layout: image-right
image: /irt-1pl.svg
---

# The 1PL item response function (IRF)

```r
data.frame(theta=seq(-4, 4, 
                     length.out=1e4), 
           b_1 = -2, b_2=0, b_3=2) |> 
  pivot_longer(starts_with('b_'), 
               names_to='param', 
               values_to='b') |> 
  select(-param) |> 
  mutate(p = plogis(theta-b)) |> 
  ggplot(aes(x=theta, 
             y=p, 
             color=as.character(b))) +
  geom_line() +
  labs(color='b') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
---

# The two parameter logistic IRT model

$$P(X_{ij} = 1 | \theta_i) = \frac{1}{1 + e^{-a_j(\theta_i - b_j)}}$$

- IRT models are named for the number of item parameters and the link function
- We add one parameter, $a_j$
- Nothing else changes!
- $a_j$ is the _discrimination_
  - It controls the slope of the IRF, and steeper slopes are more discriminating
  - When $a_j=0$, the IRF is flat and response probability does not depend on $\theta_i$
  - As $a_j \rightarrow \infty$, the IRF becomes a vertical line and the item becomes _perfectly_ discriminating
- In the IRT case, discrimination answers the question, "How well does this item separate respondents below its difficulty on the scale from respondents above its difficulty on the scale?"

---
level: 3
layout: image-right
image: /irt-2pl.svg
---

# The 2PL IRF

```r
data.frame(
  theta = seq(-4, 4, length.out = 1e4),
  b_1 = -1.5, b_2 = 0, b_3 = 1.5,
  b_4 = -3, b_5 = 3) |>
  pivot_longer(starts_with('b_'), 
               names_to = 'param', 
               values_to = 'b') |>
  select(-param) |>
  mutate(a = case_when(b == -3 ~ 0,
                       b == -1.5 ~ 0.1,
                       b == 0 ~ 1,
                       b == 1.5 ~ 2,
                       b == 3 ~ 5e3)) |>
  mutate(p = plogis(a * (theta - b))) |>
  ggplot(aes(x = theta, 
             y = p, 
             color = as.character(a))) +
  geom_line() +
  labs(color = 'a') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
---

# The three parameter logistic IRT model

$$P(X_{ij} = 1 | \theta_i) = c_j + \frac{1-c_j}{1 + e^{-a_j(\theta_i - b_j)}}$$ 

- We add one more parameter, $c_j$
- Nothing else changes!
- $c_j$ is the _guessing parameter_
  - It puts a floor on the lowest probability of correct response

---
level: 3
layout: image-right
image: /irt-3pl.svg
---

# The 3PL IRF

```r
data.frame(theta = seq(-4, 4, 
                       length.out = 1e4), 
           b_1 = -2, 
           b_2 = 0, 
           b_3 = 2) |>
  pivot_longer(starts_with('b_'), 
               names_to = 'param', 
               values_to = 'b') |>
  select(-param) |>
  mutate(a = case_when(b == -2 ~ 1.5, 
                       b == 0 ~ 1.75, 
                       b == 2 ~ 2)) |>
  mutate(c = case_when(b == -2 ~ 0, 
                       b == 0 ~ 0.25, 
                       b == 2 ~ 0.4)) |>
  mutate(p = c+(1-c)*plogis(a*(theta-b))) |>
  ggplot(aes(x = theta, 
             y = p, 
             color = as.character(c))) +
  geom_line() +
  labs(color = 'c') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
---

# Scale Identification

- The scale that everything gets projected to is not _identified_
  - This means there are an infinite number of possible item parameters and person abilities that will produce the same predicted probabilities
- There are generally two approaches to enforcing identification in IRT models:
  
  1. Fix something about the ability distribution
      - For a 1PL, fix $\bar{\theta} = 0$ and estimate the variance:
        - $\theta \sim \mathcal{N}(0,\sigma^2)$
      - Otherwise fix the ability distribution to be standard normal:
        - $\theta \sim \mathcal{N}(0,\sigma^2)$
2. Fix some item parameters:
      - $\bar{b}_j = 0$
      - $a_1 = 1$

---
level: 3
---

# Estimation Odds and Ends

- We will use the package `mirt`
  - Short for "multidimensional item response theory"
  - Absolutely the best IRT package in `R`
- `mirt` does one weird thing, however! It writes models like this:

  $$P(X_{ij} = 1 | \theta_i) = \frac{1}{1 + e^{-a_j\theta_i + b_j}}$$

- Observe that instead of $-a_j(\theta_i - b_j)$, it is using $(-a_j\theta_i + b_j)$
  - Called a _slope-intercept_ parameterization
  - This is because `mirt` is designed for multidimensional (i.e., multiple $\theta$s per person) models
  - This means we interpret the default display of the $b$ parameter from `mirt` as an _easiness_ parameter
  - Try `params <- coef(model, IRTpars = TRUE, simplify = TRUE)`
