library(tidyverse)
library(see)
library(parallel)

setwd('~/projects/lecture-slides/slides/statcomp-lect-13/public/')

set.seed(242424)

d <- read.csv('drug_use_personality.csv') |>
  select(
    id,
    gender,
    education,
    age,
    extraversion,
    openness,
    agreeableness,
    conscientiousness,
    impulsivity,
    neuroticism,
    sensation_seeking,
    cocaine_ever
  )

mean(d$cocaine_ever)

m <- glm(cocaine_ever ~ . - id, family = binomial, data = d)
summary(m)

d$p_hat_full <- predict(m, type = 'response')

mean(d$cocaine_ever == (d$p_hat_full > 0.5))

# k fold CV!

k <- 5
d$fold <- sample(1:k, nrow(d), replace = TRUE)
d$p_hat_k5 <- 0

for (i in 1:k) {
  m <- glm(
    cocaine_ever ~ gender +
      education +
      age +
      extraversion +
      openness +
      agreeableness +
      conscientiousness +
      impulsivity +
      neuroticism +
      sensation_seeking,
    family = binomial,
    data = d[d$fold != i, ]
  )

  d$p_hat_k5[d$fold == i] <- predict(
    m,
    type = 'response',
    newdata = d[d$fold == i, ]
  )
}

mean(d$cocaine_ever == (d$p_hat_k5 > 0.5))


ggplot(d, aes(x = p_hat_k5, y = p_hat_full)) +
  geom_point(alpha = 0.5) +
  geom_abline(
    aes(intercept = 0, slope = 1),
    color = okabeito_colors(2),
    lty = 2
  ) +
  theme_bw()
