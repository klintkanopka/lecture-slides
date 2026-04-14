---
level: 1
layout: section
---

# Positive Continuous Data

---
level: 2
hideInToc: true
---

# Positive Continuous Data

<v-clicks depth="2">

- Often we care about quantities that cannot be negative, but are not restricted to integers
  - Lengths of time
  - Distances
  - Incomes
- These are similar to counts because they cannot be negative, but they take on real values
  - Support: $\{x \in \mathbb{R}; x > 0\}$
- We will use two distributions for this type of data:
  1. Gamma
  2. Inverse Gaussian

</v-clicks>

---
level: 2
---

# Gamma Distribution

<v-clicks depth="2">

- The Gamma distribution is a two-parameter distribution with support over the positive reals
- Two common parameterizations:
  - $X \sim \text{Gamma}(k, \theta)$
  - $X \sim \text{Gamma}(\alpha, \beta)$
- $k$ and $\alpha$ are shape parameters, with $k = \alpha$
- $\theta$ is a scale parameter and $\beta$ is a rate parameter, with $\beta = \frac{1}{\theta}$

</v-clicks>

---
level: 3
---

# Gamma PDFs

<v-click>

- For $x > 0;\ \alpha, \beta > 0$:

$$
f(x;\alpha, \beta) = \frac{x^{\alpha-1}e^{-\beta x}\beta^\alpha}{\Gamma(\alpha)}
$$



</v-click>

<v-click>

- For $x > 0;\ k, \theta > 0$:

$$
f(x;k, \theta) = \frac{x^{k-1}e^{-x/\theta}}{\theta^k \Gamma(k)}
$$

</v-click>

---
level: 3
layout: image-right
image: /gamma-shape.svg
---

# Varying $\alpha$ and $\beta = 1$

```r
ggplot() +
  xlim(0, 20) +
  geom_function(aes(color = '1'),
                fun = dgamma,
                args = list(shape = 1,
                            rate = 1)) +
  geom_function(aes(color = '2'),
                fun = dgamma,
                args = list(shape = 2,
                            rate = 1)) +
  geom_function(aes(color = '3'),
                fun = dgamma,
                args = list(shape = 3,
                            rate = 1)) +
  geom_function(aes(color = '5'),
                fun = dgamma,
                args = list(shape = 5,
                            rate = 1)) +
  labs(y = 'p', color = 'alpha') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /gamma-rate.svg
---

# Varying $\beta$ and $\alpha = 2$

```r
ggplot() +
  xlim(0, 20) +
  geom_function(aes(color = '0.1'),
                fun = dgamma,
                args = list(shape = 2,
                            rate = 0.1)) +
  geom_function(aes(color = '0.3'),
                fun = dgamma,
                args = list(shape = 2,
                            rate = 0.3)) +
  geom_function(aes(color = '0.7'),
                fun = dgamma,
                args = list(shape = 2,
                            rate = 0.7)) +
  geom_function(aes(color = '1.5'),
                fun = dgamma,
                args = list(shape = 2,
                            rate = 1.5)) +
  labs(y = 'p', color = 'beta') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
---

# Gamma Family Connections

<v-clicks depth="2">

- The Gamma is really a family of distributions
- Exponential distribution:
  - Gamma with $\alpha = 1$ and $\beta = \lambda$
  - $f(x;\lambda) = \lambda e^{-\lambda x}$
- Chi-squared distribution:
  - Gamma with $\alpha = \frac{k}{2}$ and $\beta = \frac{1}{2}$
- Erlang distribution:
  - Gamma with $\beta = \lambda$ and $\alpha = k$ for integer $k$

</v-clicks>

---
level: 2
---

# Inverse Gaussian Distribution

<v-clicks depth="2">

- Sometimes called the Wald distribution
- Probability density function:

</v-clicks>

<v-click>

$$
f(x;\mu, \lambda) =
\sqrt{\frac{\lambda}{2\pi x^3}}
\exp\left(-\frac{\lambda(x-\mu)^2}{2\mu^2x}\right)
$$

</v-click>

<v-clicks depth="2">

- for $x, \mu, \lambda > 0$
- It is called the inverse Gaussian because of its relationship to the Gaussian in Brownian motion
- We can implement the inverse Gaussian PDF in `R`:
</v-clicks>
<v-click>
```r
dinvgaussian <- function(x, mu, lambda) {
  f <- sqrt(lambda / (2 * pi * x^3)) * exp(-1 * lambda * (x - mu)^2 / (2 * mu^2 * x))
  return(f)
}
```
</v-click>

---
level: 3
layout: image-right
image: invgaussian-lambda.svg
---

# Varying $\lambda$ and $\mu = 1$

```r
ggplot() + xlim(0.01, 5) +
  geom_function(aes(color = '0.3'),
                fun = dinvgaussian,
                args = list(mu = 1,
                            lambda = 0.3)) +
  geom_function(aes(color = '1.0'),
                fun = dinvgaussian,
                args = list(mu = 1,
                            lambda = 1.0)) +
  geom_function(aes(color = '3.0'),
                fun = dinvgaussian,
                args = list(mu = 1,
                            lambda = 3.0)) +
  geom_function(aes(color = '5.0'),
                fun = dinvgaussian,
                args = list(mu = 1,
                            lambda = 5.0)) +
  geom_function(aes(color = '7.0'),
                fun = dinvgaussian,
                args = list(mu = 1,
                            lambda = 7.0)) +
  labs(y = 'p', color = 'lambda') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: invgaussian-mu.svg
---

# Varying $\mu$ and $\lambda = 1$

```r
ggplot() +
  xlim(0.01, 5) +
  geom_function(aes(color = '0.5'),
                fun = dinvgaussian,
                args = list(mu = 0.5,
                            lambda = 1)) +
  geom_function(aes(color = '1.0'),
                fun = dinvgaussian,
                args = list(mu = 1,
                            lambda = 1)) +
  geom_function(aes(color = '3.0'),
                fun = dinvgaussian,
                args = list(mu = 3,
                            lambda = 1)) +
  geom_function(aes(color = '5.0'),
                fun = dinvgaussian,
                args = list(mu = 5,
                            lambda = 1)) +
  labs(y = 'p', color = 'mu') +
  scale_color_okabeito() +
  theme_bw()
```
