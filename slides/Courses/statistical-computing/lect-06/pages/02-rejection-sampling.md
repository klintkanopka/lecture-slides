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
- **Core Idea:** Monte Carlo simulations are a really powerful problem-solving tool<v-click>, _assuming you can generate random samples from an appropriate distribution_</v-click>
<v-click>

- What if you need to draw samples from a complicated distribution? One that doesn't have a handy built-in function in `R`?

</v-click>
<v-click>

- **Rejection sampling** can be a useful tool for sampling from almost _any_ density function, as long as you can put a "box" around it

</v-click>

---
level: 3
---

# Probability Density Functions

- First, what is a **density function**?
- A _probability density function_ (PDF) describes the relative likelihood of observing different values of a continuous random variable (RV)
- We call the values an RV can take on the _support_
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

Generic approach to draw $N$ samples from a random variable $X$ with PDF $f_X$, where the support of $X$ is a bounded interval $[a, b]$ and $f_X(x) \le M$ everywhere:

1. **Propose a sample**
    1. Draw a proposed sample, $x \sim \text{Uniform}(a, b)$
    2. Draw a height, $p_x \sim \text{Uniform}(0, M)$
2. **Evaluate the proposal**
    1. If $p_x < f_X(x)$, _accept_ the sample $x$
    2. Otherwise, _reject_ the sample $x$
3. **Repeat** steps 1 and 2 until you have accepted $N$ samples
    1. The accepted samples are distributed exactly according to $f_X$
    2. You accept about $\frac{1}{M(b-a)}$ of proposals (area under $f_X$ divided by the area of the box)

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

ggplot(d, aes(x = x, y = p, color = accept)) +
  geom_point(alpha = 0.3) +
  geom_function(
    fun = parabolic,
    color = okabeito_colors(3),
    linewidth = 1.5
  ) +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /density-05.png
---

# Parabolic Density Function

Did it work? With $M = 1$ and $b - a = 2$, expect to accept about half

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
level: 3
---

# Rejection Sampling Without a Box

- You can't draw a box around an unbounded support (like the normal's), so cover $f_X$ with a _curve_ instead
- Pick a _proposal_ density, $g$, that you can already sample from, and a constant $M$ so that $f_X(x) \le Mg(x)$ everywhere. $Mg$ is the _envelope_
  1. Propose $x \sim g$
  2. Draw a height, $p_x \sim \text{Uniform}(0, Mg(x))$
  3. Accept if $p_x < f_X(x)$
- You accept about $1/M$ of proposals
- The box is the special case $g = \text{Uniform}(a, b)$

---
level: 3
layout: image-right
image: /density-06.png
---

# Rejection Sampling Without a Box

Example: standard normal from Cauchy proposals, with $M = \max_x \frac{f_X(x)}{g(x)} = \sqrt{2\pi/e} \approx 1.52$

```r
N <- 1e4
M <- sqrt(2 * pi / exp(1))
x <- rcauchy(N)
p <- runif(N, 0, M * dcauchy(x))
samples <- x[p < dnorm(x)]

length(samples) / N
# [1] 0.6588
```

- **Catch:** $g$ needs heavier tails than $f_X$. A normal proposal can't cover a Cauchy target, because no finite $M$ exists
