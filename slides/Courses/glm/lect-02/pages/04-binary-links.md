---
level: 1
layout: section
---

# More Binary Outcomes

---
level: 2
---

# Logistic Regression Revisited

<v-clicks depth="2">

- Logistic regression uses a Bernoulli outcome distribution
- The link function is the logit:
  $$
  \eta_i = \log\left(\frac{\mu_i}{1-\mu_i}\right)
  $$
- This maps probabilities in $(0,1)$ onto the real line
- The inverse map turns the linear predictor back into a probability
  $$
  \mu_i = \frac{1}{1 + e^{-\eta_i}}
  $$
</v-clicks>

---
level: 2
---

# Other Link Functions

<v-clicks depth="2">

- Logistic regression is not the only way to model binary outcomes
- A probit model uses the normal CDF as the inverse link:
  $$
    \mu_i = \Phi(\eta_i) = \frac{1}{\sqrt{2\pi}} \int_{-\infty}^{\eta_i} e^{-t^2}dt
  $$
- A complementary log-log model uses an asymmetric transformation for the inverse link function:
  $$
  \mu_i = 1 - \exp\left[-\exp(\eta_i)\right]
  $$
- All three map the linear predictor to $(0,1)$
- The main difference is the shape of that mapping

</v-clicks>

---
level: 2
layout: image-right
image: /binary-links.svg
---

# Comparing Binary Links

```r
data.frame(x = seq(-4,
                   4,
                   length.out = 1e3)) |>
  mutate(logit = plogis(x),
         probit = pnorm(x),
         cloglog = 1 - exp(-exp(x))) |>
  pivot_longer(-x,
               names_to = 'link',
               values_to = 'p') |>
  ggplot(aes(x = x, y = p, color = link)) +
  geom_line(linewidth = 1) +
  scale_color_okabeito() +
  theme_bw() +
  labs(color = NULL) +
  theme(legend.position = "bottom")

```


---
level: 2
---

# Choosing a Link

<v-clicks depth="2">

- Logit is the most common default
  - Coefficients are interpretable in log-odds units
- Probit is common when latent-normal reasoning is appealing
- Complementary log-log is useful when the response curve is asymmetric
- In practice, predictions are often similar unless probabilities are near the extremes

</v-clicks>

---
level: 2
layout: section
hideInToc: true
---

# Break
