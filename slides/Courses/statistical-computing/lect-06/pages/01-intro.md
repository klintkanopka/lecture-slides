---
level: 2
transition: fade
---

# Table of Contents

<Toc text-sm minDepth="1" maxDepth="2"/>


---
level: 2
---

# Announcements

- PS3 is due next week
- PS2 grades and solutions coming soon
- Lecture this week gets pretty math-dense. Please ask questions as we go!



---
level: 2
---

# Check-In

- [PollEv.com/klintkanopka](https://PollEv.com/klintkanopka)

---
level: 1
layout: section
---

# Rejection Sampling

---
level: 3
---

# Rejection Sampling

- Check the .qmd and .pdf I pinned in our Slack channel
- **Core Idea:** Monte Carlo simulations are a really powerful problem solving tool<v-click>, _assuming you can generate random samples from an appropriate distribution_</v-click>
<v-click> 

- What if you need to draw samples from a complicated distribution? One that doesn't have a handy built-in function in `R`?

</v-click>
<v-click> 

- **Rejection sampling** can be a useful tool for sampling from _any_ density function

</v-click>

---
level: 3
---

# Probability Density Functions

- First, what is a **density function**?
- A _probability density function_ (PDF) describes the relative likelihood of observing different values of a continuous random variable (RV)
- We call the values a RV can take on the _support_
- While the probability of each unique value is zero, the integral of the PDF between two points can tell you the probability of observing a value between those points

---
level: 3
layout: image
image: /density-01.png
---

---
level: 3
---

# Rejection Sampling

Generic approach to draw $N$ samples from a random variable $X$ with PDF $f_X$:

1. **Propose a sample**
    1. Draw a proposed sample, $x$, uniformly along the support of $X$
    2. Draw a value, $p_x \sim \text{Uniform}(0,1)$
2. **Evaluate the proposal**
    1. If $p_x < f_X(x)$, _accept_ the sample $x$
    2. Otherwise, _reject_ the sample $x$
3. **Repeat**
    1. Continue repeating 1&2 until you have accepted $N$ samples
    2. These samples are guaranteed to be distributed according to your PDF


---
level: 3
layout: image-right
image: /density-02.png
---

# Parabolic Density Function

```r
parabolic <- function(x){
  k <- 0.75 * (1 - x^2)
  return(k)
}

d <- data.frame(
    x = seq(
        from = -1, 
        to = 1, 
        length.out = 1e3
    )
)

ggplot(d, aes(x = x)) +
  geom_function(
    fun = parabolic, 
    color = okabeito_colors(3),
    linewidth = 1.5
  ) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /density-03.png
---

# Parabolic Density Function

Step 1: Propose samples

```r
N <- 1e4

d <- data.frame(
    x = runif(N, -1, 1),
    p = runif(N, 0, 1)
)

ggplot(d, aes(x = x, y = p)) +
  geom_point(alpha = 0.3) +  
  geom_function(
    fun = parabolic, 
    color = okabeito_colors(3),
    linewidth = 1.5
  ) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /density-04.png
---

# Parabolic Density Function

Step 2: Evaluate Proposals

```r
d <- d |>
  mutate(accept = if_else(
    p < parabolic(x), 
    'accept', 
    'reject'
  )
)

ggplot(d, aes(x = x, y = p)) +
  geom_point(alpha = 0.3) +  
  geom_function(
    fun = parabolic, 
    color = okabeito_colors(3),
    linewidth = 1.5
  ) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /density-05.png
---

# Parabolic Density Function

Did it work?

````md magic-move
```r
d |>
  filter(accept == 'accept') |>
  ggplot(aes(x = x)) +
  geom_density(
    color = okabeito_colors(1), 
    linewidth = 1.5
  ) +
  geom_function(
    fun = parabolic,
    color = okabeito_colors(3),
    linewidth = 1.5
  ) +
  theme_bw()

sum(d$accept == 'accept')
```
```r
d |>
  filter(accept == 'accept') |>
  ggplot(aes(x = x)) +
  geom_density(
    color = okabeito_colors(1), 
    linewidth = 1.5
  ) +
  geom_function(
    fun = parabolic,
    color = okabeito_colors(3),
    linewidth = 1.5
  ) +
  theme_bw()

sum(d$accept == 'accept')

# [1] 4979
```
````

---
level: 1
layout: section
--- 

# Motivating Problem

---
level: 2
---

# Motivating Problem: High Dimensional Data

## Someone gives you a dataset with over 500 variables in it. They ask you to build a predictive model and some visuals to communicate what's going on with the data and the model you fit to some stakeholders of unknown statistical experience. What do you do?
