library(tidyverse)
library(see)
library(mirt)
library(ggrepel)

setwd('~/projects/lecture-slides/slides/measurement-lect-03/public/')

set.seed(242424)


N <- 100
beta_2 <- 1

beta_1 <- beta_2 / 2

x <- rnorm(N, mean = 0, sd = 3)
y <- beta_2 * x + rnorm(N)

d <- data.frame(x = x, y = y)

d$x_1 <- (x + beta_1 * y) / (beta_1^2 + 1)
d$y_1 <- beta_1 * (x + beta_1 * y) / (beta_1^2 + 1)
d$x_2 <- (x + beta_2 * y) / (beta_2^2 + 1)
d$y_2 <- beta_2 * (x + beta_2 * y) / (beta_2^2 + 1)

ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.75) +
  geom_hline(aes(yintercept = 0), linewidth = 1, color = okabeito_colors(3)) +
  geom_segment(
    aes(x = x, y = y, xend = x, yend = 0),
    linetype = 2,
    alpha = 0.25
  ) +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  coord_equal() +
  theme_bw()

ggsave('pca-rot-1.svg', height = 4.5, width = 4)

ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.75) +
  geom_abline(
    aes(intercept = 0, slope = beta_1),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  geom_segment(
    aes(x = x, y = y, xend = x_1, yend = y_1),
    linetype = 2,
    alpha = 0.25
  ) +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  coord_equal() +
  theme_bw()

ggsave('pca-rot-2.svg', height = 4.5, width = 4)


ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.75) +
  geom_abline(
    aes(intercept = 0, slope = beta_2),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  geom_segment(
    aes(x = x, y = y, xend = x_2, yend = y_2),
    linetype = 2,
    alpha = 0.25
  ) +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  coord_equal() +
  theme_bw()

ggsave('pca-rot-3.svg', height = 4.5, width = 4)

# Factor Analysis Rotations

## Unrotated Coordinates

N1 <- 500
N2 <- 250

x1 <- rnorm(N1, mean = 0, sd = 3)
x2 <- rnorm(N2, mean = 0, sd = 1)

y1 <- 0.5 * x1 + rnorm(N1)
y2 <- 3 * x2 + rnorm(N2)

d <- data.frame(
  x = c(x1, x2),
  y = c(y1, y2),
  group = c(rep('A', N1), rep('B', N2))
)

p <- 24

ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.25) +
  geom_hline(aes(yintercept = 0), linewidth = 1, color = okabeito_colors(3)) +
  geom_vline(aes(xintercept = 0), linewidth = 1, color = okabeito_colors(3)) +
  annotate(
    'point',
    x = d$x[p],
    y = d$y[p],
    size = 2,
    color = okabeito_colors(3)
  ) +
  annotate(
    'segment',
    x = d$x[p],
    y = d$y[p],
    xend = d$x[p],
    yend = 0,
    linetype = 2,
    color = okabeito_colors(3)
  ) +
  annotate(
    'segment',
    x = d$x[p],
    y = d$y[p],
    xend = 0,
    yend = d$y[p],
    linetype = 2,
    color = okabeito_colors(3)
  ) +
  coord_equal() +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  theme_bw()

ggsave('fa-rot-1.svg', height = 9, width = 16)


## Orthogonal Rotation of Coordinates (PCA)

library(FactoMineR)
pca <- PCA(d[, 1:2], ncp = 1)

#d$x_1 <- (x + beta_1*y)/(beta_1^2 + 1)
#d$y_1 <- beta_1*(x + beta_1*y)/(beta_1^2 +1)

pca_beta <- pca$var$coord[1]

ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.25) +
  geom_abline(
    aes(intercept = 0, slope = pca_beta),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  geom_abline(
    aes(intercept = 0, slope = (-1 / pca_beta)),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  annotate(
    'point',
    x = d$x[p],
    y = d$y[p],
    size = 2,
    color = okabeito_colors(3)
  ) +
  annotate(
    'segment',
    x = d$x[p],
    y = d$y[p],
    xend = (d$x[p] + pca_beta * d$y[p]) / (pca_beta^2 + 1),
    yend = pca_beta * (d$x[p] + pca_beta * d$y[p]) / (pca_beta^2 + 1),
    linetype = 2,
    color = okabeito_colors(3)
  ) +
  annotate(
    'segment',
    x = d$x[p],
    y = d$y[p],
    xend = (d$x[p] + (-1 / pca_beta) * d$y[p]) / ((-1 / pca_beta)^2 + 1),
    yend = (-1 / pca_beta) *
      (d$x[p] + (-1 / pca_beta) * d$y[p]) /
      ((-1 / pca_beta)^2 + 1),
    linetype = 2,
    color = okabeito_colors(3)
  ) +
  coord_equal() +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  theme_bw()

ggsave('fa-rot-2.svg', height = 9, width = 16)


## Orthogonal Rotation of Coordinates (not PCA)

ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.25) +
  geom_abline(
    aes(intercept = 0, slope = 0.5),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  geom_abline(
    aes(intercept = 0, slope = -2),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  annotate(
    'point',
    x = d$x[p],
    y = d$y[p],
    size = 2,
    color = okabeito_colors(3)
  ) +
  annotate(
    'segment',
    x = d$x[p],
    y = d$y[p],
    xend = (2 * d$x[p] + d$y[p]) * 2 / 5,
    yend = (2 * d$x[p] + d$y[p]) / 5,
    linetype = 2,
    color = okabeito_colors(3)
  ) +
  annotate(
    'segment',
    x = d$x[p],
    y = d$y[p],
    xend = (2 * d$y[p] - d$x[p]) / -5,
    yend = (2 * d$y[p] - d$x[p]) * 2 / 5,
    linetype = 2,
    color = okabeito_colors(3)
  ) +
  coord_equal() +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  theme_bw()

ggsave('fa-rot-3.svg', height = 9, width = 16)

## Oblique Rotation of Coordinates (Factor Analysis)

ggplot(d, aes(x = x, y = y)) +
  geom_point(alpha = 0.25) +
  geom_abline(
    aes(intercept = 0, slope = 0.5),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  geom_abline(
    aes(intercept = 0, slope = 3),
    linewidth = 1,
    color = okabeito_colors(3)
  ) +
  annotate(
    'point',
    x = d$x[p],
    y = d$y[p],
    size = 2,
    color = okabeito_colors(3)
  ) +
  annotate(
    'segment',
    x = d$x[p],
    y = d$y[p],
    xend = (2 * d$x[p] + d$y[p]) * 2 / 5,
    yend = (2 * d$x[p] + d$y[p]) / 5,
    linetype = 2,
    color = okabeito_colors(3)
  ) +
  annotate(
    'segment',
    x = d$x[p],
    y = d$y[p],
    xend = (d$x[p] + 3 * d$y[p]) / 10,
    yend = (3 * d$x[p] + 9 * d$y[p]) / 10,
    linetype = 2,
    color = okabeito_colors(3)
  ) +
  coord_equal() +
  scale_x_continuous(limits = c(-11, 11)) +
  scale_y_continuous(limits = c(-11, 11)) +
  theme_bw()

ggsave('fa-rot-4.svg', height = 9, width = 16)


# EM Algorithm

flips <- matrix(c(5, 9, 8, 4, 7, 5, 1, 2, 6, 3), nrow = 5, ncol = 2, byrow = F)
p_new <- c(0.6, 0.5)
p_old <- c(0, 0)

while (!identical(round(p_old, 2), round(p_new, 2))) {
  p_old <- p_new
  p <- matrix(p_new, nrow = 5, ncol = 2, byrow = T)
  likelihood <- p^flips * (1 - p)^(10 - flips)
  theta <- likelihood / rowSums(likelihood)
  theta_A <- theta[, 1] * flips
  theta_B <- theta[, 2] * flips
  p_new <- c(sum(theta_A[, 1]) / sum(theta_A), sum(theta_B[, 1]) / sum(theta_B))
  print(round(p_new, 2))
}

# Item response functions

data.frame(theta = seq(-4, 4, length.out = 1e4), b_1 = -2, b_2 = 0, b_3 = 2) |>
  pivot_longer(starts_with('b_'), names_to = 'param', values_to = 'b') |>
  select(-param) |>
  mutate(p = plogis(theta - b)) |>
  ggplot(aes(x = theta, y = p, color = as.character(b))) +
  geom_line() +
  labs(color = 'b') +
  scale_color_okabeito() +
  theme_bw()

ggsave('irt-1pl.svg', height = 9, width = 8)

data.frame(
  theta = seq(-4, 4, length.out = 1e4),
  b_1 = -1.5,
  b_2 = 0,
  b_3 = 1.5,
  b_4 = -3,
  b_5 = 3
) |>
  pivot_longer(starts_with('b_'), names_to = 'param', values_to = 'b') |>
  select(-param) |>
  mutate(
    a = case_when(
      b == -3 ~ 0,
      b == -1.5 ~ 0.1,
      b == 0 ~ 1,
      b == 1.5 ~ 2,
      b == 3 ~ 5e3
    )
  ) |>
  mutate(p = plogis(a * (theta - b))) |>
  ggplot(aes(x = theta, y = p, color = as.character(a))) +
  geom_line() +
  labs(color = 'a') +
  scale_color_okabeito() +
  theme_bw()

ggsave('irt-2pl.svg', height = 9, width = 8)

data.frame(theta = seq(-4, 4, length.out = 1e4), b_1 = -2, b_2 = 0, b_3 = 2) |>
  pivot_longer(starts_with('b_'), names_to = 'param', values_to = 'b') |>
  select(-param) |>
  mutate(a = case_when(b == -2 ~ 1.5, b == 0 ~ 1.75, b == 2 ~ 2)) |>
  mutate(c = case_when(b == -2 ~ 0, b == 0 ~ 0.25, b == 2 ~ 0.4)) |>
  mutate(p = c + (1 - c) * plogis(a * (theta - b))) |>
  ggplot(aes(x = theta, y = p, color = as.character(c))) +
  geom_line() +
  labs(color = 'c') +
  scale_color_okabeito() +
  theme_bw()

ggsave('irt-3pl.svg', height = 9, width = 8)


library(mirt)
d <- read_rds('animalfights_clean.rds')

resp <- d |> select(starts_with('d_'))

# Fit a 1PL
m_1pl <- mirt(resp, 1, itemtype = 'Rasch')
coef(m_1pl)
params_1pl <- coef(m_1pl, IRTpars = TRUE, simplify = TRUE)
params_1pl
params_1pl$items
thetas_1pl <- fscores(m_1pl)

## Fit a 2PL and extract the parameters into a dataframe:

# Fit a 1PL
m_2pl <- mirt(resp, 1, itemtype = '2PL')
coef(m_2pl)
params_2pl <- coef(m_2pl, IRTpars = TRUE, simplify = TRUE)
params_2pl$items
thetas_2pl <- fscores(m_2pl)

items <- data.frame(
  item = rownames(params_1pl$items),
  b_1pl = params_1pl$items[, 2],
  b_2pl = params_2pl$items[, 2],
  a_2pl = params_2pl$items[, 1]
)

persons <- data.frame(
  sum_score = rowSums(resp),
  theta_1pl = as.vector(thetas_1pl),
  theta_2pl = as.vector(thetas_2pl)
)

ggplot(persons, aes(x = sum_score, y = theta_1pl)) +
  geom_point(color = okabeito_colors(3), alpha = 0.5) +
  theme_bw()

ggsave('irt-theta-sum-1pl.svg', height = 4.5, width = 4)


ggplot(persons, aes(x = sum_score, y = theta_2pl)) +
  geom_point(color = okabeito_colors(3), alpha = 0.5) +
  theme_bw()

ggsave('irt-theta-sum-2pl.svg', height = 4.5, width = 4)


ggplot(persons, aes(x = theta_1pl, y = theta_2pl)) +
  geom_point(color = okabeito_colors(3), alpha = 0.5) +
  theme_bw()

ggsave('irt-theta-1pl-2pl.svg', height = 4.5, width = 4)


items |>
  ggplot(aes(x = b_1pl, y = b_2pl, color = a_2pl, label = item)) +
  geom_point() +
  scale_color_viridis_c() +
  theme_bw()

ggsave('irt-items-diff.svg', height = 4.5, width = 4)


items |>
  ggplot(aes(x = b_1pl, y = b_2pl, color = a_2pl, label = item)) +
  geom_point() +
  geom_label_repel(color = 'black', max.overlaps = 15) +
  scale_color_viridis_c() +
  theme_bw()

ggsave('irt-items-labeled.svg', height = 9 * 0.66, width = 16 * 0.66)
