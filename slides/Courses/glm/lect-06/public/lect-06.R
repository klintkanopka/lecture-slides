library(tidyverse)
library(see)
library(viridis)
library(mgcv)

setwd('~/projects/lecture-slides/slides/Courses/glm/lect-06/public/')

set.seed(777)

N <- 1000

d <- data.frame(
  x = rnorm(N),
  z = rnorm(N)
)

d$y <- -8 + 2 * d$x^3 + d$x + 2 * exp(d$z) + rnorm(N)


ggplot(d, aes(x = x, y = y, color = z)) +
  geom_point(alpha = 0.5) +
  scale_color_viridis() +
  theme_bw()

ggsave('gam-1.svg', height = 4.5, width = 4)

m <- lm(y ~ x + z, data = d)
summary(m)

d$y_hat_lm <- predict(m)

ggplot(d, aes(x = y, y = y_hat_lm)) +
  geom_point(alpha = 0.2) +
  geom_abline(aes(intercept = 0, slope = 1), lty = 2) +
  theme_bw()

ggsave('gam-2.svg', height = 4.5, width = 4)


m1 <- gam(y ~ x + z, data = d)
summary(m1)

m2 <- gam(y ~ s(x) + z, data = d)
summary(m2)

d$y_hat_gam_x <- predict(m2)

ggplot(d, aes(x = y, y = y_hat_gam_x)) +
  geom_point(alpha = 0.2) +
  geom_abline(aes(intercept = 0, slope = 1), lty = 2) +
  theme_bw()

ggsave('gam-3.svg', height = 4.5, width = 4)


m3 <- gam(y ~ x + s(z), data = d)
summary(m3)

d$y_hat_gam_z <- predict(m3)


ggplot(d, aes(x = y, y = y_hat_gam_z)) +
  geom_point(alpha = 0.2) +
  geom_abline(aes(intercept = 0, slope = 1), lty = 2) +
  theme_bw()

ggsave('gam-4.svg', height = 4.5, width = 4)


m4 <- gam(y ~ s(x) + s(z), data = d)
summary(m4)

d$y_hat_gam_xz <- predict(m4)


ggplot(d, aes(x = y, y = y_hat_gam_xz)) +
  geom_point(alpha = 0.2) +
  geom_abline(aes(intercept = 0, slope = 1), lty = 2) +
  theme_bw()

ggsave('gam-5.svg', height = 4.5, width = 4)


# visualizing response functions

d_grid <- data.frame(x = seq(from = -4, to = 4, length.out = 1000))
d_grid$z <- median(d$z)

d_grid$y_pred <- predict(m4, newdata = d_grid)

ggplot(d_grid, aes(x = x, y = y_pred)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()

ggsave('gam-6.svg', height = 4.5, width = 4)


ggplot(d, aes(x = z, y = y, color = x)) +
  geom_point(alpha = 0.5) +
  scale_color_viridis() +
  theme_bw()

ggsave('gam-7.svg', height = 4.5, width = 4)


d_grid <- data.frame(z = seq(from = -4, to = 4, length.out = 1000))
d_grid$x <- median(d$x)

d_grid$y_pred <- predict(m4, newdata = d_grid)

ggplot(d_grid, aes(x = z, y = y_pred)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()

ggsave('gam-8.svg', height = 4.5, width = 4)


## new data

d_new <- data.frame(
  x = rnorm(N),
  z = rnorm(N)
)

d_new$y <- 2 * (d_new$x^2) - 2 * (d_new$z^2) + rnorm(N)
m5 <- gam(y ~ s(x) + s(z), data = d_new)
summary(m5)

ggplot(d_new, aes(x = x, y = y)) +
  geom_point(alpha = 0.5) +
  theme_bw()

ggsave('new-gam-1.svg', height = 4.5, width = 4)


d_grid <- data.frame(x = seq(from = -4, to = 4, length.out = 1000))
d_grid$z <- median(d$z)

d_grid$y_pred <- predict(m5, newdata = d_grid)

ggplot(d_grid, aes(x = x, y = y_pred)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()

ggsave('new-gam-2.svg', height = 4.5, width = 4)


ggplot(d_new, aes(x = z, y = y)) +
  geom_point(alpha = 0.5) +
  theme_bw()

ggsave('new-gam-3.svg', height = 4.5, width = 4)


d_grid <- data.frame(z = seq(from = -4, to = 4, length.out = 1000))
d_grid$x <- median(d$x)

d_grid$y_pred <- predict(m5, newdata = d_grid)

ggplot(d_grid, aes(x = z, y = y_pred)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()

ggsave('new-gam-4.svg', height = 4.5, width = 4)


x <- z <- seq(-4, 4, length.out = 100)

d_grid <- expand.grid(list(x = x, z = z))

d_grid$y_pred <- predict(m5, newdata = d_grid)


ggplot(d_grid, aes(x = x, y = z, fill = y_pred)) +
  geom_tile() +
  coord_equal() +
  scale_fill_viridis() +
  theme_bw()


ggsave('new-gam-5.svg', height = 4.5, width = 4)
