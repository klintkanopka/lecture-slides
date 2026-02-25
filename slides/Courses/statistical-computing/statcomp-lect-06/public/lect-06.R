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
