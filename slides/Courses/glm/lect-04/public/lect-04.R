library(tidyverse)
library(see)
library(lme4)

setwd('~/projects/lecture-slides/slides/Courses/glm/lect-04/public/')


ggplot() +
  xlim(0, 20) +
  geom_function(
    aes(color = '1'),
    fun = dgamma,
    args = list(shape = 1, rate = 1)
  ) +
  geom_function(
    aes(color = '2'),
    fun = dgamma,
    args = list(shape = 2, rate = 1)
  ) +
  geom_function(
    aes(color = '3'),
    fun = dgamma,
    args = list(shape = 3, rate = 1)
  ) +
  geom_function(
    aes(color = '5'),
    fun = dgamma,
    args = list(shape = 5, rate = 1)
  ) +
  labs(y = 'p', color = 'alpha') +
  scale_color_okabeito() +
  theme_bw()

ggsave('gamma-shape.svg', height = 4.5, width = 4)

ggplot() +
  xlim(0, 20) +
  geom_function(
    aes(color = '0.1'),
    fun = dgamma,
    args = list(shape = 2, rate = 0.1)
  ) +
  geom_function(
    aes(color = '0.3'),
    fun = dgamma,
    args = list(shape = 2, rate = 0.3)
  ) +
  geom_function(
    aes(color = '0.7'),
    fun = dgamma,
    args = list(shape = 2, rate = 0.7)
  ) +
  geom_function(
    aes(color = '1.5'),
    fun = dgamma,
    args = list(shape = 2, rate = 1.5)
  ) +
  labs(y = 'p', color = 'beta') +
  scale_color_okabeito() +
  theme_bw()

ggsave('gamma-rate.svg', height = 4.5, width = 4)


dinvgaussian <- function(x, mu, lambda) {
  sqrt(lambda / (2 * pi * x^3)) *
    exp(-1 * lambda * (x - mu)^2 / (2 * mu^2 * x))
}

ggplot() +
  xlim(0.01, 5) +
  geom_function(
    aes(color = '0.3'),
    fun = dinvgaussian,
    args = list(mu = 1, lambda = 0.3)
  ) +
  geom_function(
    aes(color = '1.0'),
    fun = dinvgaussian,
    args = list(mu = 1, lambda = 1.0)
  ) +
  geom_function(
    aes(color = '3.0'),
    fun = dinvgaussian,
    args = list(mu = 1, lambda = 3.0)
  ) +
  geom_function(
    aes(color = '5.0'),
    fun = dinvgaussian,
    args = list(mu = 1, lambda = 5.0)
  ) +
  geom_function(
    aes(color = '7.0'),
    fun = dinvgaussian,
    args = list(mu = 1, lambda = 7.0)
  ) +
  labs(y = 'p', color = 'lambda') +
  scale_color_okabeito() +
  theme_bw()

ggsave('invgaussian-lambda.svg', height = 4.5, width = 4)


ggplot() +
  xlim(0.01, 5) +
  geom_function(
    aes(color = '0.5'),
    fun = dinvgaussian,
    args = list(mu = 0.5, lambda = 1)
  ) +
  geom_function(
    aes(color = '1.0'),
    fun = dinvgaussian,
    args = list(mu = 1, lambda = 1)
  ) +
  geom_function(
    aes(color = '3.0'),
    fun = dinvgaussian,
    args = list(mu = 3, lambda = 1)
  ) +
  geom_function(
    aes(color = '5.0'),
    fun = dinvgaussian,
    args = list(mu = 5, lambda = 1)
  ) +
  labs(y = 'p', color = 'mu') +
  scale_color_okabeito() +
  theme_bw()

ggsave('invgaussian-mu.svg', height = 4.5, width = 4)


# fun activity

d <- read_csv('lect-04-warmup-data.csv')

lm1 <- lm(y1 ~ x + z, data = d)
lm2 <- lm(y2 ~ x + z, data = d)
lm3 <- lm(y3 ~ x + z, data = d)
lm4 <- lm(y4 ~ x + z, data = d)

glm1 <- glm(y1 ~ x + z, family = binomial(link = 'logit'), data = d)
glm2 <- glm(y2 ~ x + z, family = Gamma(link = 'log'), data = d)
glm3 <- glm(y3 ~ x + z, family = gaussian(), data = d)
glm4 <- glm(y4 ~ x + z, family = poisson(), data = d)


d_residuals <- data.frame(
  r1_lm = d$y1 - predict(lm1),
  r2_lm = d$y2 - predict(lm2),
  r3_lm = d$y3 - predict(lm3),
  r4_lm = d$y4 - predict(lm4),
  r1_glm = d$y1 - predict(glm1, type = 'response'),
  r2_glm = d$y2 - predict(glm2, type = 'response'),
  r3_glm = d$y3 - predict(glm3, type = 'response'),
  r4_glm = d$y4 - predict(glm4, type = 'response')
)


d_residuals |>
  select(starts_with('r1')) |>
  pivot_longer(everything(), names_to = 'model', values_to = 'residual') |>
  ggplot(aes(x = residual, fill = model)) +
  geom_histogram() +
  scale_fill_okabeito() +
  facet_grid(model ~ .) +
  theme_bw() +
  theme(legend.position = 'bottom')

ggsave('resid-r1.svg', width = 4, height = 4.5)


d_residuals |>
  select(starts_with('r2')) |>
  pivot_longer(everything(), names_to = 'model', values_to = 'residual') |>
  ggplot(aes(x = residual, fill = model)) +
  geom_histogram() +
  scale_fill_okabeito() +
  facet_grid(model ~ .) +
  theme_bw() +
  theme(legend.position = 'bottom')

ggsave('resid-r2.svg', width = 4, height = 4.5)


d_residuals |>
  select(starts_with('r3')) |>
  pivot_longer(everything(), names_to = 'model', values_to = 'residual') |>
  ggplot(aes(x = residual, fill = model)) +
  geom_histogram() +
  scale_fill_okabeito() +
  facet_grid(model ~ .) +
  theme_bw() +
  theme(legend.position = 'bottom')

ggsave('resid-r3.svg', width = 4, height = 4.5)


d_residuals |>
  select(starts_with('r4')) |>
  pivot_longer(everything(), names_to = 'model', values_to = 'residual') |>
  ggplot(aes(x = residual, fill = model)) +
  geom_histogram() +
  scale_fill_okabeito() +
  facet_grid(model ~ .) +
  theme_bw() +
  theme(legend.position = 'bottom')

ggsave('resid-r4.svg', width = 4, height = 4.5)


# simulate data for individuals, assign to groups
set.seed(242424)

d <- data.frame(student_id = 1:(9 * 30))
d$classroom <- rep(1:9, each = 30)
d$study_time <- sample(0:5, 9 * 30, replace = T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
d_classroom$teacher_effect <- rnorm(9, mean = 30, sd = 20)
d_classroom$teacher_factor <- rnorm(9, 1, 2)

# join them together - left join group to individuals
d <- left_join(d, d_classroom, by = 'classroom')

# generate your outcome variable, dont forget to add noise!
d$score = d$teacher_effect +
  10 * d$teacher_factor * d$study_time +
  rnorm(nrow(d), mean = 0, sd = 10)

ggplot(d, aes(x = study_time, y = score)) +
  geom_point() +
  guides(color = 'none') +
  theme_bw()

ggsave('sim-1.svg', height = 4.5, width = 4)

ggplot(d, aes(x = study_time, y = score)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F) +
  guides(color = 'none') +
  theme_bw()

ggsave('sim-2.svg', height = 4.5, width = 4)


ggplot(d, aes(x = study_time, y = score, color = as.character(classroom))) +
  geom_point() +
  scale_color_okabeito() +
  guides(color = 'none') +
  theme_bw()

ggsave('sim-3.svg', height = 4.5, width = 4)


ggplot(d, aes(x = study_time, y = score, color = as.character(classroom))) +
  geom_point() +
  geom_smooth(method = 'lm', se = F) +
  scale_color_okabeito() +
  guides(color = 'none') +
  theme_bw()

ggsave('sim-4.svg', height = 4.5, width = 4)


m <- lm(score ~ study_time, data = d)
summary(m)
m <- lm(score ~ study_time + as.character(classroom), data = d)
summary(m)
m <- lmer(score ~ (1 | classroom) + study_time, data = d)
summary(m)
m <- lmer(score ~ (study_time | classroom) + study_time, data = d)
summary(m)
m <- lmer(score ~ (1 + study_time | classroom) + study_time, data = d)
summary(m)
