library(ggplot2)
library(tidyverse)
library(see)

setwd('~/projects/lecture-slides/slides/statcomp-lect-07/public/')

d <- data.frame(x = seq(from = -2, to = 4, length.out = 1e3))

quad_func <- function(x) {
  result <- x^2 - 2 * x - 3
  return(result)
}

ggplot(d, aes(x = x)) +
  geom_function(fun = quad_func, color = okabeito_colors(3)) +
  theme_bw()

ggsave('quadratic-01.png', height = 4.5, width = 8)


set.seed(242424)
N <- 1e3
true_beta <- c(2.718, -2.718)

d <- data.frame(x = rnorm(N))
d$y <- true_beta[1] + true_beta[2] * d$x + rnorm(N)

ols <- lm(y ~ x, d)
ols_beta <- coef(ols)
ols_beta

ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.5) +
  theme_bw()

ggsave('ols-01.png', height = 9, width = 8)

lr <- 1e-4
beta <- c(0, 0)

beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))
beta
beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))
beta


M <- 1e2
lr <- 1e-4
beta <- c(0, 0)
betas <- data.frame(i = 1:M, beta_0 = numeric(M), beta_1 = numeric(M))

for (i in 1:M) {
  beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
  beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

  betas$beta_0[i] <- beta[1]
  betas$beta_1[i] <- beta[2]
}

gd_beta <- beta
beta

ggplot(betas, aes(x = i)) +
  geom_line(aes(y = beta_0), color = okabeito_colors(1)) +
  geom_line(aes(y = beta_1), color = okabeito_colors(2)) +
  geom_point(aes(y = beta_0), size = 0.5, color = okabeito_colors(1)) +
  geom_point(aes(y = beta_1), size = 0.5, color = okabeito_colors(2)) +
  geom_hline(aes(yintercept = true_beta[1]), lty = 2, alpha = 0.5) +
  geom_hline(aes(yintercept = true_beta[2]), lty = 2, alpha = 0.5) +
  labs(x = 'Gradient Descent Iteration', y = 'beta') +
  theme_bw()

ggsave('ols-02.png', height = 9, width = 8)

M <- 1e2
lr <- 1e-3
beta <- c(0, 0)
betas <- data.frame(i = 1:M, beta_0 = numeric(M), beta_1 = numeric(M))

for (i in 1:M) {
  beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
  beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

  betas$beta_0[i] <- beta[1]
  betas$beta_1[i] <- beta[2]
}

beta

ggplot(betas, aes(x = i)) +
  geom_line(aes(y = beta_0), color = okabeito_colors(1)) +
  geom_line(aes(y = beta_1), color = okabeito_colors(2)) +
  geom_point(aes(y = beta_0), size = 0.5, color = okabeito_colors(1)) +
  geom_point(aes(y = beta_1), size = 0.5, color = okabeito_colors(2)) +
  geom_hline(aes(yintercept = true_beta[1]), lty = 2, alpha = 0.5) +
  geom_hline(aes(yintercept = true_beta[2]), lty = 2, alpha = 0.5) +
  labs(x = 'Gradient Descent Iteration', y = 'beta') +
  theme_bw()


ggsave('ols-03.png', height = 9, width = 8)

M <- 1e2
lr <- 1e-5
beta <- c(0, 0)
betas <- data.frame(i = 1:M, beta_0 = numeric(M), beta_1 = numeric(M))

for (i in 1:M) {
  beta[1] <- beta[1] + 2 * lr * sum(d$y - (beta[1] + beta[2] * d$x))
  beta[2] <- beta[2] + 2 * lr * sum(d$x * (d$y - (beta[1] + beta[2] * d$x)))

  betas$beta_0[i] <- beta[1]
  betas$beta_1[i] <- beta[2]
}

beta

ggplot(betas, aes(x = i)) +
  geom_line(aes(y = beta_0), color = okabeito_colors(1)) +
  geom_line(aes(y = beta_1), color = okabeito_colors(2)) +
  geom_point(aes(y = beta_0), size = 0.5, color = okabeito_colors(1)) +
  geom_point(aes(y = beta_1), size = 0.5, color = okabeito_colors(2)) +
  geom_hline(aes(yintercept = true_beta[1]), lty = 2, alpha = 0.5) +
  geom_hline(aes(yintercept = true_beta[2]), lty = 2, alpha = 0.5) +
  labs(x = 'Gradient Descent Iteration', y = 'beta') +
  theme_bw()

ggsave('ols-04.png', height = 9, width = 8)

# optim

SumSquaredResid <- function(beta, d) {
  resid <- d$y - (beta[1] + beta[2] * d$x)
  ssr <- sum(resid^2)
  return(ssr)
}

SumSquaredResid(c(0, 0), d)

out <- optim(
  c(0, 0), # starting vals for parameters
  SumSquaredResid, # fn to minimize
  d = d
) # args to pass to fn

# pass control=list(scale=-1) to make optim argmax

mle_beta <- out$par

mle_beta

true_beta
ols_beta
gd_beta
mle_beta
