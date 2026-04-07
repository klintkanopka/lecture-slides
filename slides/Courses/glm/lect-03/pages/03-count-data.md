---
level: 1
layout: section
---

# Count Data

---
level: 2
hideInToc: true
---

# Count Data

<v-clicks depth="2">

- Count data is data that keeps track of a count of something
- Importantly, counts take on non-negative **integer** values
  - $\{ x \in \mathbb{Z}; x \geq 0\} = \mathbb{N}_0$
- We will use three distributions for count data:
  1. Binomial
  2. Poisson
  3. Negative Binomial
- We call the values a probability distribution can take on the _support_

</v-clicks>

---
level: 2
---

# The Binomial Distribution

<v-clicks depth="2">

- The number of successes observed in $n$ independent Bernoulli trials, each with probability of success $p$
  - $X \sim \text{Binomial}(n,p)$
  - Can also model the number of successes in $n$ draws (with replacement) from a population
  - If draws are done _without_ replacement, this is modeled by the hypergeometric distribution
- Probability mass function (PMF):

</v-clicks>
<v-clicks>

$$P(X=k) = \binom{n}{k}p^k (1-p)^{n-k}$$
for $k \in \{0,1,2,\ldots,n\}$, where
$$\binom{n}{k} = \frac{n!}{k!(n-k)!}$$

</v-clicks>

---
level: 3
---

# Binomial Distribution: Varying $p$, $n=20$


```r
n <- 20
ps <- c(0.5, 0.7, 0.9)
probs <- vector('numeric', length=n+1)

p <- 0.5
for (k in 0:n){
  probs[k+1] <- choose(n, k) * p^k * (1-p)^(n-k)
}
d_b1 <- data.frame(k=0:n, p=p, prob=probs)

p <- 0.7
for (k in 0:n){
  probs[k+1] <- choose(n, k) * p^k * (1-p)^(n-k)
}
d_b2 <- data.frame(k=0:n, p=p, prob=probs)

p <- 0.9
for (k in 0:n){
  probs[k+1] <- choose(n, k) * p^k * (1-p)^(n-k)
}
d_b3 <- data.frame(k=0:n, p=p, prob=probs)
```


---
level: 3
layout: image-right
image: /binomial-p.svg
---

# Binomial Distribution: Varying $p$, $n=20$

```r
ggplot(
  bind_rows(d_b1, d_b2, d_b3),
  aes(x = k,
      y = prob,
      fill = as.character(p))) +
  geom_col() +
  labs(fill = 'p') +
  facet_grid(as.character(p) ~ .) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position = "bottom")
```

---
level: 3
---


# Binomial Distribution; Varying $n$, $p=0.5$

```r
p <- 0.5

n <- 5
probs <- vector('numeric', length=n+1)
for (k in 0:n){
  probs[k+1] <- choose(n, k) * p^k * (1-p)^(n-k)
}
d_b1 <- data.frame(k=0:n, n=n, prob=probs)

n <- 10
probs <- vector('numeric', length=n+1)
for (k in 0:n){
  probs[k+1] <- choose(n, k) * p^k * (1-p)^(n-k)
}
d_b2 <- data.frame(k=0:n, n=n, prob=probs)

n <- 20
probs <- vector('numeric', length=n+1)
for (k in 0:n){
  probs[k+1] <- choose(n, k) * p^k * (1-p)^(n-k)
}
d_b3 <- data.frame(k=0:n, n=n, prob=probs)
```

---
level: 3
layout: image-right
image: /binomial-n.svg
---

# Binomial Distribution; Varying $n$, $p=0.5$

```r
ggplot(bind_rows(d_b1, d_b2, d_b3),
       aes(x=k,
           y=prob,
           fill=as.character(n))) +
  geom_col() +
  labs(fill='n') +
  facet_grid(n~.) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position = "bottom")

```


---
level: 2
---

# The Poisson Distribution

<v-clicks depth="2">

- The number of events that occur in a fixed interval of time, when the events occur an expected rate of $\lambda$ events per time interval
  - $X \sim \text{Poisson}(\lambda)$
  - Events occur independently of the time elapsed from the last one
  - Importantly, the mean and variance of a Poisson distribution are both equal to $\lambda$
    - $\lambda = \mathbb{E}[X] = \text{Var}[X]$
- Probability mass function (PMF):

</v-clicks>
<v-click>


$$P(X=k) = \frac{\lambda^k e^{-\lambda}}{k!}$$
for $k \in \{0,1,2,\ldots\}$

</v-click>

---
level: 3
---

# Poisson Distribution with Varying $\lambda$

```r
n <- 20
probs <- vector('numeric', length=n+1)

lambda <- 1
for (k in 0:n){
  probs[k+1] <- lambda^k * exp(-1*lambda) / factorial(k)
}
d_b1 <- data.frame(k=0:n, lambda=lambda, prob=probs)

lambda <- 5
for (k in 0:n){
  probs[k+1] <- lambda^k * exp(-1*lambda) / factorial(k)
}
d_b2 <- data.frame(k=0:n, lambda=lambda, prob=probs)

lambda <- 10
for (k in 0:n){
  probs[k+1] <- lambda^k * exp(-1*lambda) / factorial(k)
}
d_b3 <- data.frame(k=0:n, lambda=lambda, prob=probs)
```

---
level: 3
layout: image-right
image: /poisson.svg
---

# Poisson Distribution with Varying $\lambda$

```r
ggplot(bind_rows(d_b1, d_b2, d_b3),
       aes(x = k,
           y = prob,
           fill = as.factor(lambda))) +
  geom_col() +
  labs(fill='lambda') +
  facet_grid(lambda~.) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position = "bottom")

```
---
level: 2
---

# The Negative Binomial Distribution

<v-clicks depth="2">

- The number of failures that occur in a sequence of independent Bernoulli trials with probability $p$ before observing $r$ successes
  - $X \sim \text{NegBinom}(r,p)$
  - Does not require that mean and variance are equal, unlike Poisson!
- Probability mass function (PMF):

</v-clicks>

<v-click>

$$P(X=k) = \binom{k+r-1}{k}(1-p)^kp^r$$
for $k \in \{0,1,2,\ldots\}$
$$\binom{k+r-1}{k} = \frac{(k+r-1)!}{(r-1)!(k)!}=(-1)^k\binom{-r}{k}$$

</v-click>

---
level: 3
---

# Negative Binomial Distribution; Varying $r$, $p=0.5$

```r
p <- 0.5
n <- 15

probs <- vector('numeric', length=n+1)

r <- 1
for (k in 0:n){
  probs[k+1] <- choose(k+r-1, k)*(1-p)^k*p^r
}
d_b1 <- data.frame(k=0:n, r=r, prob=probs)

r <- 3
for (k in 0:n){
  probs[k+1] <- choose(k+r-1, k)*(1-p)^k*p^r
}
d_b2 <- data.frame(k=0:n, r=r, prob=probs)

r <- 5
for (k in 0:n){
  probs[k+1] <- choose(k+r-1, k)*(1-p)^k*p^r
}
d_b3 <- data.frame(k=0:n, r=r, prob=probs)
```

---
level: 3
layout: image-right
image: /neg-binom-r.svg
---

# Negative Binomial; Varying $r$, $p=0.5$

```r
ggplot(bind_rows(d_b1, d_b2, d_b3),
       aes(x = k,
           y = prob,
           fill = as.factor(r))) +
  geom_col() +
  labs(fill='r') +
  facet_grid(r~.) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position='bottom')

```

---
level: 3
---

# Negative Binomial Distribution; Varying $p$, $r=10$

```r
n <- 25
r <- 10

probs <- vector('numeric', length=n+1)

p <- 0.4
for (k in 0:n){
  probs[k+1] <- choose(k+r-1, k)*(1-p)^k*p^r
}
d_b1 <- data.frame(k=0:n, p=p, prob=probs)

p <- 0.5
for (k in 0:n){
  probs[k+1] <- choose(k+r-1, k)*(1-p)^k*p^r
}
d_b2 <- data.frame(k=0:n, p=p, prob=probs)

p <- 0.8
for (k in 0:n){
  probs[k+1] <- choose(k+r-1, k)*(1-p)^k*p^r
}
d_b3 <- data.frame(k=0:n, p=p, prob=probs)
```

---
level: 3
layout: image-right
image: /neg-binom-p.svg
---

# Negative Binomial; Varying $p$, $r=10$

```r
ggplot(bind_rows(d_b1, d_b2, d_b3),
       aes(x = k,
           y = prob,
           fill = as.factor(p))) +
  geom_col() +
  labs(fill='p') +
  facet_grid(p~.) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position='bottom')

```

