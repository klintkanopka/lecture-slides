library(ggplot2)
library(tidyverse)
library(see)

setwd('~/projects/lecture-slides/slides/statcomp-lect-06/public/')

d <- data.frame(x = seq(from = -4, to = 4, length.out = 1e3))

ggplot(d, aes(x = x)) +
  geom_function(fun = dnorm, color = okabeito_colors(3)) +
  labs(title = 'Standard normal density function') +
  theme_bw()

ggsave('density-01.png', height = 4.5, width = 8)


parabolic <- function(x) {
  k <- 0.75 * (1 - x^2)
  return(k)
}

d <- data.frame(x = seq(from = -1, to = 1, length.out = 1e3))

ggplot(d, aes(x = x)) +
  geom_function(fun = parabolic, color = okabeito_colors(3), linewidth = 1.5) +
  theme_bw()

ggsave('density-02.png', height = 9, width = 8)

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

ggsave('density-03.png', height = 9, width = 8)


d$accept <- if_else(d$p < parabolic(d$x), 'accept', 'reject')

ggplot(d, aes(x = x, y = p, color = accept)) +
  geom_point(alpha = 0.3) +
  geom_function(
    fun = parabolic,
    color = okabeito_colors(3),
    linewidth = 1.5
  ) +
  scale_color_okabeito() +
  theme_bw()

ggsave('density-04.png', height = 9, width = 8)

d |>
  filter(accept == 'accept') |>
  ggplot(aes(x = x)) +
  geom_density(color = okabeito_colors(1), linewidth = 1.5) +
  geom_function(
    fun = parabolic,
    color = okabeito_colors(3),
    linewidth = 1.5
  ) +
  theme_bw()

sum(d$accept == 'accept')

ggsave('density-05.png', height = 9, width = 8)


u <- c(2, 3)
v <- c(cos(pi / 9), sin(pi / 9))
s <- sum(u * v)
shadow <- s * v

ggplot() +
  geom_abline(slope = v[2] / v[1], intercept = 0, linetype = 'dotted') +
  annotate(
    'segment',
    x = u[1],
    y = u[2],
    xend = shadow[1],
    yend = shadow[2],
    linetype = 'dashed'
  ) +
  annotate(
    'segment',
    x = 0,
    y = 0,
    xend = shadow[1],
    yend = shadow[2],
    color = okabeito_colors(3),
    linewidth = 3,
    alpha = 0.5
  ) +
  annotate(
    'segment',
    x = 0,
    y = 0,
    xend = u[1],
    yend = u[2],
    arrow = arrow(length = unit(0.15, 'inches')),
    color = okabeito_colors(2),
    linewidth = 1.5
  ) +
  annotate(
    'segment',
    x = 0,
    y = 0,
    xend = v[1],
    yend = v[2],
    arrow = arrow(length = unit(0.15, 'inches')),
    color = okabeito_colors(1),
    linewidth = 1.5
  ) +
  annotate('text', x = 0.9, y = 2.1, label = 'u', size = 7, fontface = 'bold') +
  annotate(
    'text',
    x = 0.55,
    y = 0.45,
    label = 'v',
    size = 7,
    fontface = 'bold'
  ) +
  annotate(
    'text',
    x = 2.4,
    y = 0.45,
    label = 'u · v = length of the\n"shadow" of u on v',
    size = 5
  ) +
  coord_equal(xlim = c(-0.25, 3.5), ylim = c(-0.25, 3.5)) +
  labs(x = NULL, y = NULL) +
  theme_bw()

ggsave('dot-product.png', height = 9, width = 8)


set.seed(2352)
n <- 100
math <- rnorm(n, mean = 70, sd = 10)
reading <- 25 + 0.6 * math + rnorm(n, sd = 6)
scores <- data.frame(math, reading)

X <- scale(scores, center = TRUE, scale = FALSE)
A <- crossprod(X)
eig <- eigen(A)
v1 <- eig$vectors[, 1]
if (v1[1] < 0) {
  v1 <- -v1
}


centering <- bind_rows(
  scores |> mutate(panel = '1. Raw scores'),
  as.data.frame(X) |> mutate(panel = '2. Centered scores')
)

ggplot(centering, aes(x = math, y = reading)) +
  geom_hline(yintercept = 0, color = 'grey60') +
  geom_vline(xintercept = 0, color = 'grey60') +
  geom_point(alpha = 0.6, color = okabeito_colors(2)) +
  annotate('point', x = 0, y = 0, shape = 4, size = 4, stroke = 1.5) +
  expand_limits(x = 0, y = 0) +
  facet_wrap(~panel, scales = 'free') +
  labs(x = 'Math', y = 'Reading') +
  theme_bw()

ggsave('pca-centering.png', height = 4.5, width = 8)


perp <- function(X, v) {
  proj <- (X %*% v) %*% t(v)
  data.frame(
    x = X[, 1],
    y = X[, 2],
    xend = proj[, 1],
    yend = proj[, 2]
  )
}

v_bad <- c(cos(-pi / 6), sin(-pi / 6))
lines <- bind_rows(
  perp(X, v_bad) |>
    mutate(
      panel = sprintf(
        'A worse line: avg. squared distance = %.0f',
        mean((X %*% c(-v_bad[2], v_bad[1]))^2)
      )
    ),
  perp(X, v1) |>
    mutate(
      panel = sprintf(
        'The first PC: avg. squared distance = %.0f',
        mean((X %*% c(-v1[2], v1[1]))^2)
      )
    )
)
slopes <- data.frame(
  panel = unique(lines$panel),
  slope = c(v_bad[2] / v_bad[1], v1[2] / v1[1])
)


panel_order <- rev(unique(lines$panel))
lines$panel <- factor(lines$panel, levels = panel_order)
slopes$panel <- factor(slopes$panel, levels = panel_order)

ggplot(lines) +
  geom_segment(
    aes(x = x, y = y, xend = xend, yend = yend),
    color = 'grey50',
    linewidth = 0.3
  ) +
  geom_abline(
    data = slopes,
    aes(slope = slope, intercept = 0),
    color = okabeito_colors(3),
    linewidth = 1.2
  ) +
  geom_point(aes(x = x, y = y), alpha = 0.6, color = okabeito_colors(2)) +
  facet_wrap(~panel) +
  coord_equal() +
  labs(x = 'Math (centered)', y = 'Reading (centered)') +
  theme_bw()

ggsave('pca-lines.png', height = 4.5, width = 8)


b_ols <- sum(X[, 1] * X[, 2]) / sum(X[, 1]^2)

line_errors <- function(s, label) {
  n_hat <- c(-s, 1) / sqrt(1 + s^2)
  sprintf(
    '%s\nreconstruction error = %.0f, prediction error = %.0f',
    label,
    mean((X %*% n_hat)^2),
    mean((X[, 2] - s * X[, 1])^2)
  )
}

ols_vs_pca <- bind_rows(
  perp(X, v1) |>
    mutate(panel = line_errors(v1[2] / v1[1], 'PCA')),
  data.frame(x = X[, 1], y = X[, 2], xend = X[, 1], yend = b_ols * X[, 1]) |>
    mutate(panel = line_errors(b_ols, 'OLS'))
)
ols_slopes <- data.frame(
  panel = unique(ols_vs_pca$panel),
  slope = c(v1[2] / v1[1], b_ols)
)
panel_order <- unique(ols_vs_pca$panel)
ols_vs_pca$panel <- factor(ols_vs_pca$panel, levels = panel_order)
ols_slopes$panel <- factor(ols_slopes$panel, levels = panel_order)

ggplot(ols_vs_pca) +
  geom_segment(
    aes(x = x, y = y, xend = xend, yend = yend),
    color = 'grey50',
    linewidth = 0.3
  ) +
  geom_abline(
    data = ols_slopes,
    aes(slope = slope, intercept = 0),
    color = okabeito_colors(3),
    linewidth = 1.2
  ) +
  geom_point(aes(x = x, y = y), alpha = 0.6, color = okabeito_colors(2)) +
  facet_wrap(~panel) +
  coord_equal() +
  labs(x = 'Math (centered)', y = 'Reading (centered)') +
  theme_bw()

ggsave('pca-vs-ols.png', height = 4.5, width = 8)


i <- which.max(pmin(X %*% v1, X %*% c(-v1[2], v1[1])))
xi <- X[i, ]
pi_i <- sum(xi * v1) * v1

ggplot(as.data.frame(X), aes(x = math, y = reading)) +
  geom_abline(
    slope = v1[2] / v1[1],
    intercept = 0,
    color = okabeito_colors(3),
    linewidth = 1.2
  ) +
  geom_point(alpha = 0.25, color = okabeito_colors(2)) +
  annotate(
    'segment',
    x = 0,
    y = 0,
    xend = xi[1],
    yend = xi[2],
    linewidth = 1.2
  ) +
  annotate(
    'segment',
    x = 0,
    y = 0,
    xend = pi_i[1],
    yend = pi_i[2],
    color = okabeito_colors(1),
    linewidth = 2
  ) +
  annotate(
    'segment',
    x = xi[1],
    y = xi[2],
    xend = pi_i[1],
    yend = pi_i[2],
    color = okabeito_colors(5),
    linewidth = 1.2,
    linetype = 'dashed'
  ) +
  annotate('point', x = xi[1], y = xi[2], size = 3) +
  annotate('point', x = 0, y = 0, shape = 4, size = 4, stroke = 1.5) +
  annotate(
    'label',
    x = xi[1] / 2 - 4,
    y = xi[2] / 2 + 3,
    label = 'paste("\u2016", x[i], "\u2016")',
    parse = TRUE,
    size = 5
  ) +
  annotate(
    'label',
    x = pi_i[1] / 2 + 3,
    y = pi_i[2] / 2 - 4,
    label = 'x[i] %.% v',
    parse = TRUE,
    size = 5,
    color = okabeito_colors(1)
  ) +
  annotate(
    'label',
    x = (xi[1] + pi_i[1]) / 2 + 5,
    y = (xi[2] + pi_i[2]) / 2,
    label = 'dist',
    size = 5,
    color = okabeito_colors(5)
  ) +
  coord_equal() +
  labs(x = 'Math (centered)', y = 'Reading (centered)') +
  theme_bw()

ggsave('pca-pythagoras.png', height = 9, width = 8)


A
eig
prcomp(scores)$rotation
eig$values / (n - 1)
prcomp(scores)$sdev^2

B <- matrix(c(2, 1, 1, 2), nrow = 2)
u <- c(1, 0)
for (step in 1:4) {
  u <- B %*% u
  print(round(as.vector(u / sqrt(sum(u^2))), 3))
}


set.seed(2352)
M <- sqrt(2 * pi / exp(1))
N <- 1e4

d <- data.frame(x = rcauchy(N)) |>
  mutate(
    p = runif(N, 0, M * dcauchy(x)),
    accept = if_else(p < dnorm(x), 'accept', 'reject')
  )

mean(d$accept == 'accept')

envelope <- function(x) M * dcauchy(x)

d |>
  filter(abs(x) < 5) |>
  ggplot(aes(x = x, y = p, color = accept)) +
  geom_point(alpha = 0.3) +
  geom_function(
    fun = envelope,
    color = 'black',
    linewidth = 1.5,
    linetype = 'dashed'
  ) +
  geom_function(fun = dnorm, color = okabeito_colors(3), linewidth = 1.5) +
  scale_color_okabeito() +
  labs(
    subtitle = 'Dashed: envelope M · dcauchy(x); solid: dnorm(x)\nProposals beyond ±5 not shown'
  ) +
  theme_bw()

ggsave('density-06.png', height = 9, width = 8)
