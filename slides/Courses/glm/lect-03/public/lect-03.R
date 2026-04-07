library(MASS)
library(tidyverse)
library(see)

setwd(
  '~/projects/lecture-slides/slides/Courses/glm/lect-03/public'
)

set.seed(242424)

N <- 200
d <- data.frame(x1 = rnorm(N), x2 = rnorm(N), x3 = rnorm(N))
d$eta <- -0.5 + 1.2 * d$x1 - 0.7 * d$x2
d$y <- rbinom(N, 1, p = plogis(d$eta))

d |>
  select(-eta) |>
  saveRDS('logistic-data.rds')

m_1 <- glm(y ~ 1, data = d, family = binomial(link = 'logit'))
m_x1 <- glm(y ~ x1, data = d, family = binomial(link = 'logit'))
m_x2 <- glm(y ~ x2, data = d, family = binomial(link = 'logit'))
m_x3 <- glm(y ~ x3, data = d, family = binomial(link = 'logit'))
m_all <- glm(y ~ x1 + x2 + x3, data = d, family = binomial(link = 'logit'))

summary(m_all)$coefficients


summary(m_all)$coefficients |>
  as.data.frame() |>
  rownames_to_column('term') |>
  select(term, estimate = Estimate, se = `Std. Error`) |>
  mutate(ci_upper = estimate + 1.96 * se, ci_lower = estimate - 1.96 * se) |>
  ggplot(aes(
    y = reorder(term, estimate),
    x = estimate,
    xmin = ci_lower,
    xmax = ci_upper
  )) +
  geom_vline(aes(xintercept = 0), lty = 2, alpha = 0.5) +
  geom_point(color = okabeito_colors(3)) +
  geom_errorbar(color = okabeito_colors(3), width = 0) +
  labs(y = NULL) +
  theme_bw()

ggsave('logistic-ci.svg', width = 4, height = 4.5)

summary(m_all)$coefficients |>
  as.data.frame() |>
  rownames_to_column('term') |>
  select(term, estimate = Estimate, se = `Std. Error`) |>
  mutate(ci_upper = estimate + 1.96 * se, ci_lower = estimate - 1.96 * se) |>
  ggplot(aes(
    x = reorder(term, -estimate),
    y = estimate,
    ymin = ci_lower,
    ymax = ci_upper
  )) +
  geom_hline(aes(yintercept = 0), lty = 2, alpha = 0.5) +
  geom_point(color = okabeito_colors(3)) +
  geom_errorbar(color = okabeito_colors(3), width = 0) +
  labs(x = NULL) +
  theme_bw()

ggsave('logistic-ci-2.svg', width = 4, height = 4.5)


# prediction CIs

preds <- predict(m_x1, type = 'response', se.fit = TRUE)

d |>
  mutate(p_hat = preds$fit, se = preds$se.fit) |>
  mutate(ci_upper = p_hat + 1.96 * se, ci_lower = p_hat - 1.96 * se) |>
  ggplot(aes(x = x1, y = p_hat, ymin = ci_lower, ymax = ci_upper)) +
  geom_line(color = okabeito_colors(3)) +
  geom_ribbon(fill = okabeito_colors(3), alpha = 0.4) +
  geom_point(aes(y = y), color = 'black', alpha = 0.5) +
  theme_bw()

ggsave('logistic-pred-ci.svg', height = 4.5, width = 4)

preds <- predict(m_all, type = 'response', se.fit = TRUE)

d |>
  mutate(p_hat = preds$fit, se = preds$se.fit) |>
  mutate(ci_upper = p_hat + 1.96 * se, ci_lower = p_hat - 1.96 * se) |>
  ggplot(aes(x = x1, y = p_hat, ymin = ci_lower, ymax = ci_upper)) +
  geom_point(color = okabeito_colors(3)) +
  geom_errorbar(color = okabeito_colors(3), width = 0, alpha = 0.4) +
  geom_point(aes(y = y), color = 'black', alpha = 0.5) +
  theme_bw()

ggsave('logistic-pred-ci-2.svg', height = 4.5, width = 4)


L <- (deviance(m_1) - deviance(m_x1))
pchisq(L, df.residual(m_1) - df.residual(m_x1), lower.tail = FALSE)

L <- (deviance(m_1) - deviance(m_x3))
pchisq(L, df.residual(m_1) - df.residual(m_x3), lower.tail = FALSE)


anova(m_1, m_x1, m_all, test = 'Chisq')

anova(m_1, m_x3, m_all, test = 'Chisq')

# binomial distributions

n <- 20
ps <- c(0.5, 0.7, 0.9)

probs <- vector('numeric', length = n + 1)

p <- 0.5

for (k in 0:n) {
  probs[k + 1] <- choose(n, k) * p^k * (1 - p)^(n - k)
}

d_b1 <- data.frame(k = 0:n, p = p, prob = probs)

p <- 0.7

for (k in 0:n) {
  probs[k + 1] <- choose(n, k) * p^k * (1 - p)^(n - k)
}

d_b2 <- data.frame(k = 0:n, p = p, prob = probs)

p <- 0.9

for (k in 0:n) {
  probs[k + 1] <- choose(n, k) * p^k * (1 - p)^(n - k)
}

d_b3 <- data.frame(k = 0:n, p = p, prob = probs)

ggplot(
  bind_rows(d_b1, d_b2, d_b3),
  aes(x = k, y = prob, fill = as.character(p))
) +
  geom_col() +
  labs(fill = 'p') +
  facet_grid(as.character(p) ~ .) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position = "bottom")

ggsave('binomial-p.svg', width = 4, height = 4.5)


p <- 0.5

n <- 5
probs <- vector('numeric', length = n + 1)
for (k in 0:n) {
  probs[k + 1] <- choose(n, k) * p^k * (1 - p)^(n - k)
}
d_b1 <- data.frame(k = 0:n, n = n, prob = probs)

n <- 10
probs <- vector('numeric', length = n + 1)
for (k in 0:n) {
  probs[k + 1] <- choose(n, k) * p^k * (1 - p)^(n - k)
}
d_b2 <- data.frame(k = 0:n, n = n, prob = probs)

n <- 20
probs <- vector('numeric', length = n + 1)
for (k in 0:n) {
  probs[k + 1] <- choose(n, k) * p^k * (1 - p)^(n - k)
}
d_b3 <- data.frame(k = 0:n, n = n, prob = probs)

ggplot(
  bind_rows(d_b1, d_b2, d_b3),
  aes(x = k, y = prob, fill = as.character(n))
) +
  geom_col() +
  labs(fill = 'n') +
  facet_grid(n ~ .) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position = "bottom")


ggsave('binomial-n.svg', height = 4.5, width = 4)

# poisson

n <- 20

probs <- vector('numeric', length = n + 1)

lambda <- 1

for (k in 0:n) {
  probs[k + 1] <- lambda^k * exp(-1 * lambda) / factorial(k)
}

d_b1 <- data.frame(k = 0:n, lambda = lambda, prob = probs)

lambda <- 5

for (k in 0:n) {
  probs[k + 1] <- lambda^k * exp(-1 * lambda) / factorial(k)
}

d_b2 <- data.frame(k = 0:n, lambda = lambda, prob = probs)

lambda <- 10

for (k in 0:n) {
  probs[k + 1] <- lambda^k * exp(-1 * lambda) / factorial(k)
}

d_b3 <- data.frame(k = 0:n, lambda = lambda, prob = probs)

ggplot(
  bind_rows(d_b1, d_b2, d_b3),
  aes(x = k, y = prob, fill = as.factor(lambda))
) +
  geom_col() +
  labs(fill = 'lambda') +
  facet_grid(lambda ~ .) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position = "bottom")

ggsave('poisson.svg', width = 4, height = 4.5)


# negative binomial

p <- 0.5
n <- 15
probs <- vector('numeric', length = n + 1)

r <- 1
for (k in 0:n) {
  probs[k + 1] <- choose(k + r - 1, k) * (1 - p)^k * p^r
}
d_b1 <- data.frame(k = 0:n, r = r, prob = probs)

r <- 3
for (k in 0:n) {
  probs[k + 1] <- choose(k + r - 1, k) * (1 - p)^k * p^r
}
d_b2 <- data.frame(k = 0:n, r = r, prob = probs)

r <- 5
for (k in 0:n) {
  probs[k + 1] <- choose(k + r - 1, k) * (1 - p)^k * p^r
}
d_b3 <- data.frame(k = 0:n, r = r, prob = probs)

ggplot(bind_rows(d_b1, d_b2, d_b3), aes(x = k, y = prob, fill = as.factor(r))) +
  geom_col() +
  labs(fill = 'r') +
  facet_grid(r ~ .) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position = 'bottom')

ggsave('neg-binom-r.svg', width = 4, height = 4.5)

n <- 25
r <- 10

probs <- vector('numeric', length = n + 1)

p <- 0.4
for (k in 0:n) {
  probs[k + 1] <- choose(k + r - 1, k) * (1 - p)^k * p^r
}
d_b1 <- data.frame(k = 0:n, p = p, prob = probs)

p <- 0.5
for (k in 0:n) {
  probs[k + 1] <- choose(k + r - 1, k) * (1 - p)^k * p^r
}
d_b2 <- data.frame(k = 0:n, p = p, prob = probs)

p <- 0.8
for (k in 0:n) {
  probs[k + 1] <- choose(k + r - 1, k) * (1 - p)^k * p^r
}
d_b3 <- data.frame(k = 0:n, p = p, prob = probs)

ggplot(bind_rows(d_b1, d_b2, d_b3), aes(x = k, y = prob, fill = as.factor(p))) +
  geom_col() +
  labs(fill = 'p') +
  facet_grid(p ~ .) +
  scale_fill_okabeito() +
  theme_bw() +
  theme(legend.position = 'bottom')

ggsave('neg-binom-p.svg', width = 4, height = 4.5)


# count glms

d <- readRDS('count-data.rds')

ggplot(d, aes(x = y)) +
  geom_histogram(bins = 10, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('count-hist.svg', width = 4, height = 4.5)

ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.4) +
  geom_smooth(
    formula = y ~ x,
    method = 'loess',
    color = okabeito_colors(3),
    se = FALSE
  ) +
  theme_bw()

ggsave('count-loess.svg', width = 4, height = 4.5)

m <- glm(y ~ x, data = d, family = poisson(link = 'log'))
m_quasi <- glm(y ~ x, data = d, family = quasipoisson(link = 'log'))
m_nb <- glm.nb(y ~ x, data = d)

summary(m)$coefficients
summary(m_quasi)$coefficients
summary(m_nb)$coefficients

d$y_hat <- predict(m, type = 'response')


ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.4) +
  geom_smooth(
    formula = y ~ x,
    method = 'loess',
    color = okabeito_colors(3),
    se = FALSE
  ) +
  geom_line(aes(y = y_hat), color = okabeito_colors(2)) +
  theme_bw()

ggsave('count-loess-glm.svg', height = 4.5, width = 4)
