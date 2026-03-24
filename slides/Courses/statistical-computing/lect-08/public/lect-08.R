library(ggplot2)
library(tidyverse)
library(see)

setwd('~/projects/lecture-slides/slides/statcomp-lect-08/public/')
set.seed(8675309)

# 02-overfitting.md

d <- data.frame(x = rnorm(50))
d$y <- -1.5 + 3 * d$x + rnorm(50, sd = 0.5)

m <- lm(y ~ x, d)
coef(m)

ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_abline(
    aes(intercept = coef(m)[1], slope = coef(m)[2]),
    color = okabeito_colors(1)
  ) +
  scale_x_continuous(limits = c(-3, 3)) +
  scale_y_continuous(limits = c(-9, 5)) +
  theme_bw()

ggsave('overfit-01.png', height = 4.5, width = 8)

d2 <- rbind(d, data.frame(x = 2, y = -8))

m2 <- lm(y ~ x, d2)
coef(m2)

ggplot(d2, aes(x = x, y = y)) +
  geom_point() +
  geom_abline(
    aes(intercept = coef(m)[1], slope = coef(m)[2]),
    color = okabeito_colors(1)
  ) +
  geom_abline(
    aes(intercept = coef(m2)[1], slope = coef(m2)[2]),
    color = okabeito_colors(2)
  ) +
  scale_x_continuous(limits = c(-3, 3)) +
  scale_y_continuous(limits = c(-9, 5)) +
  theme_bw()

ggsave('overfit-02.png', height = 4.5, width = 8)

d3 <- rbind(d2, data.frame(x = 50, y = -100))
m3 <- lm(y ~ x, d3)
coef(m3)

ggplot(d3, aes(x = x, y = y)) +
  geom_point() +
  geom_abline(
    aes(intercept = coef(m)[1], slope = coef(m)[2]),
    color = okabeito_colors(1)
  ) +
  geom_abline(
    aes(intercept = coef(m2)[1], slope = coef(m2)[2]),
    color = okabeito_colors(2)
  ) +
  geom_abline(
    aes(intercept = coef(m3)[1], slope = coef(m3)[2]),
    color = okabeito_colors(3)
  ) +
  scale_x_continuous(limits = c(-3, 3)) +
  scale_y_continuous(limits = c(-9, 5)) +
  theme_bw()

ggsave('overfit-03.png', height = 4.5, width = 8)


d <- data.frame(x = rnorm(10))
d$y <- -1.5 + 3 * d$x + rnorm(10)


ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  theme_bw()

ggsave('overfit-04.png', height = 9, width = 8)


m0 <- lm(y ~ 1, d)
m1 <- lm(y ~ x, d)
m2 <- lm(y ~ poly(x, 2, raw = TRUE), d)
m3 <- lm(y ~ poly(x, 3, raw = TRUE), d)
m4 <- lm(y ~ poly(x, 4, raw = TRUE), d)
m5 <- lm(y ~ poly(x, 5, raw = TRUE), d)
m6 <- lm(y ~ poly(x, 6, raw = TRUE), d)
m7 <- lm(y ~ poly(x, 7, raw = TRUE), d)
m8 <- lm(y ~ poly(x, 8, raw = TRUE), d)
m9 <- lm(y ~ poly(x, 9, raw = TRUE), d)

ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], color = okabeito_colors(3)) +
  #geom_function(fun=function(x) coef(m1)[1] + coef(m1)[2]*x) +
  #geom_function(fun=function(x) coef(m2)[1] + coef(m2)[2]*x + coef(m2)[3]*x^2) +
  #geom_function(fun=function(x) coef(m3)[1] + coef(m3)[2]*x + coef(m3)[3]*x^2 + coef(m3)[4]*x^3) +
  #geom_function(fun=function(x) coef(m4)[1] + coef(m4)[2]*x + coef(m4)[3]*x^2 + coef(m4)[4]*x^3 + coef(m4)[5]*x^4) +
  #geom_function(fun=function(x) coef(m5)[1] + coef(m5)[2]*x + coef(m5)[3]*x^2 + coef(m5)[4]*x^3 + coef(m5)[5]*x^4 + coef(m5)[6]*x^5) +
  theme_bw()

ggsave('overfit-05.png', height = 4.5, width = 8)


ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], alpha = 0.3) +
  geom_function(
    fun = function(x) coef(m1)[1] + coef(m1)[2] * x,
    color = okabeito_colors(3)
  ) +
  #geom_function(fun=function(x) coef(m2)[1] + coef(m2)[2]*x + coef(m2)[3]*x^2) +
  #geom_function(fun=function(x) coef(m3)[1] + coef(m3)[2]*x + coef(m3)[3]*x^2 + coef(m3)[4]*x^3) +
  #geom_function(fun=function(x) coef(m4)[1] + coef(m4)[2]*x + coef(m4)[3]*x^2 + coef(m4)[4]*x^3 + coef(m4)[5]*x^4) +
  #geom_function(fun=function(x) coef(m5)[1] + coef(m5)[2]*x + coef(m5)[3]*x^2 + coef(m5)[4]*x^3 + coef(m5)[5]*x^4 + coef(m5)[6]*x^5) +
  theme_bw()

ggsave('overfit-06.png', height = 4.5, width = 8)


ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], alpha = 0.3) +
  geom_function(fun = function(x) coef(m1)[1] + coef(m1)[2] * x, alpha = 0.3) +
  geom_function(
    fun = function(x) coef(m2)[1] + coef(m2)[2] * x + coef(m2)[3] * x^2,
    color = okabeito_colors(3)
  ) +
  #geom_function(fun=function(x) coef(m3)[1] + coef(m3)[2]*x + coef(m3)[3]*x^2 + coef(m3)[4]*x^3) +
  #geom_function(fun=function(x) coef(m4)[1] + coef(m4)[2]*x + coef(m4)[3]*x^2 + coef(m4)[4]*x^3 + coef(m4)[5]*x^4) +
  #geom_function(fun=function(x) coef(m5)[1] + coef(m5)[2]*x + coef(m5)[3]*x^2 + coef(m5)[4]*x^3 + coef(m5)[5]*x^4 + coef(m5)[6]*x^5) +
  theme_bw()

ggsave('overfit-07.png', height = 4.5, width = 8)


ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], alpha = 0.3) +
  geom_function(fun = function(x) coef(m1)[1] + coef(m1)[2] * x, alpha = 0.3) +
  geom_function(
    fun = function(x) coef(m2)[1] + coef(m2)[2] * x + coef(m2)[3] * x^2,
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m3)[1] + coef(m3)[2] * x + coef(m3)[3] * x^2 + coef(m3)[4] * x^3
    },
    color = okabeito_colors(3)
  ) +
  #geom_function(fun=function(x) coef(m4)[1] + coef(m4)[2]*x + coef(m4)[3]*x^2 + coef(m4)[4]*x^3 + coef(m4)[5]*x^4) +
  #geom_function(fun=function(x) coef(m5)[1] + coef(m5)[2]*x + coef(m5)[3]*x^2 + coef(m5)[4]*x^3 + coef(m5)[5]*x^4 + coef(m5)[6]*x^5) +
  theme_bw()

ggsave('overfit-08.png', height = 4.5, width = 8)


ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], alpha = 0.3) +
  geom_function(fun = function(x) coef(m1)[1] + coef(m1)[2] * x, alpha = 0.3) +
  geom_function(
    fun = function(x) coef(m2)[1] + coef(m2)[2] * x + coef(m2)[3] * x^2,
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m3)[1] + coef(m3)[2] * x + coef(m3)[3] * x^2 + coef(m3)[4] * x^3
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m4)[1] +
        coef(m4)[2] * x +
        coef(m4)[3] * x^2 +
        coef(m4)[4] * x^3 +
        coef(m4)[5] * x^4
    },
    color = okabeito_colors(3)
  ) +
  #geom_function(fun=function(x) coef(m5)[1] + coef(m5)[2]*x + coef(m5)[3]*x^2 + coef(m5)[4]*x^3 + coef(m5)[5]*x^4 + coef(m5)[6]*x^5) +
  theme_bw()

ggsave('overfit-09.png', height = 4.5, width = 8)


ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], alpha = 0.3) +
  geom_function(fun = function(x) coef(m1)[1] + coef(m1)[2] * x, alpha = 0.3) +
  geom_function(
    fun = function(x) coef(m2)[1] + coef(m2)[2] * x + coef(m2)[3] * x^2,
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m3)[1] + coef(m3)[2] * x + coef(m3)[3] * x^2 + coef(m3)[4] * x^3
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m4)[1] +
        coef(m4)[2] * x +
        coef(m4)[3] * x^2 +
        coef(m4)[4] * x^3 +
        coef(m4)[5] * x^4
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m5)[1] +
        coef(m5)[2] * x +
        coef(m5)[3] * x^2 +
        coef(m5)[4] * x^3 +
        coef(m5)[5] * x^4 +
        coef(m5)[6] * x^5
    },
    color = okabeito_colors(3)
  ) +
  theme_bw()

ggsave('overfit-10.png', height = 4.5, width = 8)

ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], alpha = 0.3) +
  geom_function(fun = function(x) coef(m1)[1] + coef(m1)[2] * x, alpha = 0.3) +
  geom_function(
    fun = function(x) coef(m2)[1] + coef(m2)[2] * x + coef(m2)[3] * x^2,
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m3)[1] + coef(m3)[2] * x + coef(m3)[3] * x^2 + coef(m3)[4] * x^3
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m4)[1] +
        coef(m4)[2] * x +
        coef(m4)[3] * x^2 +
        coef(m4)[4] * x^3 +
        coef(m4)[5] * x^4
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m5)[1] +
        coef(m5)[2] * x +
        coef(m5)[3] * x^2 +
        coef(m5)[4] * x^3 +
        coef(m5)[5] * x^4 +
        coef(m5)[6] * x^5
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m6)[1] +
        coef(m6)[2] * x +
        coef(m6)[3] * x^2 +
        coef(m6)[4] * x^3 +
        coef(m6)[5] * x^4 +
        coef(m6)[6] * x^5 +
        coef(m6)[7] * x^6
    },
    color = okabeito_colors(3)
  ) +
  #geom_function(fun=function(x) coef(m7)[1] + coef(m7)[2]*x + coef(m7)[3]*x^2 + coef(m7)[4]*x^3 + coef(m7)[5]*x^4 + coef(m7)[6]*x^5 + coef(m7)[7]*x^6 + coef(m7)[8]*x^7, alpha=0.3) +
  #geom_function(fun=function(x) coef(m8)[1] + coef(m8)[2]*x + coef(m8)[3]*x^2 + coef(m8)[4]*x^3 + coef(m8)[5]*x^4 + coef(m8)[6]*x^5 + coef(m8)[7]*x^6 + coef(m8)[8]*x^7 + coef(m8)[9]*x^8, alpha=0.3) +
  #geom_function(fun=function(x) coef(m9)[1] + coef(m9)[2]*x + coef(m9)[3]*x^2 + coef(m9)[4]*x^3 + coef(m9)[5]*x^4 + coef(m9)[6]*x^5 + coef(m9)[7]*x^6 + coef(m9)[8]*x^7 + coef(m9)[9]*x^8 + coef(m9)[10]*x^9, alpha=0.3) +
  theme_bw()

ggsave('overfit-11.png', height = 4.5, width = 8)


ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], alpha = 0.3) +
  geom_function(fun = function(x) coef(m1)[1] + coef(m1)[2] * x, alpha = 0.3) +
  geom_function(
    fun = function(x) coef(m2)[1] + coef(m2)[2] * x + coef(m2)[3] * x^2,
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m3)[1] + coef(m3)[2] * x + coef(m3)[3] * x^2 + coef(m3)[4] * x^3
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m4)[1] +
        coef(m4)[2] * x +
        coef(m4)[3] * x^2 +
        coef(m4)[4] * x^3 +
        coef(m4)[5] * x^4
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m5)[1] +
        coef(m5)[2] * x +
        coef(m5)[3] * x^2 +
        coef(m5)[4] * x^3 +
        coef(m5)[5] * x^4 +
        coef(m5)[6] * x^5
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m6)[1] +
        coef(m6)[2] * x +
        coef(m6)[3] * x^2 +
        coef(m6)[4] * x^3 +
        coef(m6)[5] * x^4 +
        coef(m6)[6] * x^5 +
        coef(m6)[7] * x^6
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m7)[1] +
        coef(m7)[2] * x +
        coef(m7)[3] * x^2 +
        coef(m7)[4] * x^3 +
        coef(m7)[5] * x^4 +
        coef(m7)[6] * x^5 +
        coef(m7)[7] * x^6 +
        coef(m7)[8] * x^7
    },
    color = okabeito_colors(3)
  ) +
  #geom_function(fun=function(x) coef(m8)[1] + coef(m8)[2]*x + coef(m8)[3]*x^2 + coef(m8)[4]*x^3 + coef(m8)[5]*x^4 + coef(m8)[6]*x^5 + coef(m8)[7]*x^6 + coef(m8)[8]*x^7 + coef(m8)[9]*x^8, alpha=0.3) +
  #geom_function(fun=function(x) coef(m9)[1] + coef(m9)[2]*x + coef(m9)[3]*x^2 + coef(m9)[4]*x^3 + coef(m9)[5]*x^4 + coef(m9)[6]*x^5 + coef(m9)[7]*x^6 + coef(m9)[8]*x^7 + coef(m9)[9]*x^8 + coef(m9)[10]*x^9, alpha=0.3) +
  theme_bw()

ggsave('overfit-12.png', height = 4.5, width = 8)


ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], alpha = 0.3) +
  geom_function(fun = function(x) coef(m1)[1] + coef(m1)[2] * x, alpha = 0.3) +
  geom_function(
    fun = function(x) coef(m2)[1] + coef(m2)[2] * x + coef(m2)[3] * x^2,
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m3)[1] + coef(m3)[2] * x + coef(m3)[3] * x^2 + coef(m3)[4] * x^3
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m4)[1] +
        coef(m4)[2] * x +
        coef(m4)[3] * x^2 +
        coef(m4)[4] * x^3 +
        coef(m4)[5] * x^4
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m5)[1] +
        coef(m5)[2] * x +
        coef(m5)[3] * x^2 +
        coef(m5)[4] * x^3 +
        coef(m5)[5] * x^4 +
        coef(m5)[6] * x^5
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m6)[1] +
        coef(m6)[2] * x +
        coef(m6)[3] * x^2 +
        coef(m6)[4] * x^3 +
        coef(m6)[5] * x^4 +
        coef(m6)[6] * x^5 +
        coef(m6)[7] * x^6
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m7)[1] +
        coef(m7)[2] * x +
        coef(m7)[3] * x^2 +
        coef(m7)[4] * x^3 +
        coef(m7)[5] * x^4 +
        coef(m7)[6] * x^5 +
        coef(m7)[7] * x^6 +
        coef(m7)[8] * x^7
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m8)[1] +
        coef(m8)[2] * x +
        coef(m8)[3] * x^2 +
        coef(m8)[4] * x^3 +
        coef(m8)[5] * x^4 +
        coef(m8)[6] * x^5 +
        coef(m8)[7] * x^6 +
        coef(m8)[8] * x^7 +
        coef(m8)[9] * x^8
    },
    color = okabeito_colors(3)
  ) +
  #geom_function(fun=function(x) coef(m9)[1] + coef(m9)[2]*x + coef(m9)[3]*x^2 + coef(m9)[4]*x^3 + coef(m9)[5]*x^4 + coef(m9)[6]*x^5 + coef(m9)[7]*x^6 + coef(m9)[8]*x^7 + coef(m9)[9]*x^8 + coef(m9)[10]*x^9, alpha=0.3) +
  theme_bw()

ggsave('overfit-13.png', height = 4.5, width = 8)


ggplot(d, aes(x = x, y = y)) +
  geom_point() +
  geom_function(fun = function(x) coef(m0)[1], alpha = 0.3) +
  geom_function(fun = function(x) coef(m1)[1] + coef(m1)[2] * x, alpha = 0.3) +
  geom_function(
    fun = function(x) coef(m2)[1] + coef(m2)[2] * x + coef(m2)[3] * x^2,
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m3)[1] + coef(m3)[2] * x + coef(m3)[3] * x^2 + coef(m3)[4] * x^3
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m4)[1] +
        coef(m4)[2] * x +
        coef(m4)[3] * x^2 +
        coef(m4)[4] * x^3 +
        coef(m4)[5] * x^4
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m5)[1] +
        coef(m5)[2] * x +
        coef(m5)[3] * x^2 +
        coef(m5)[4] * x^3 +
        coef(m5)[5] * x^4 +
        coef(m5)[6] * x^5
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m6)[1] +
        coef(m6)[2] * x +
        coef(m6)[3] * x^2 +
        coef(m6)[4] * x^3 +
        coef(m6)[5] * x^4 +
        coef(m6)[6] * x^5 +
        coef(m6)[7] * x^6
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m7)[1] +
        coef(m7)[2] * x +
        coef(m7)[3] * x^2 +
        coef(m7)[4] * x^3 +
        coef(m7)[5] * x^4 +
        coef(m7)[6] * x^5 +
        coef(m7)[7] * x^6 +
        coef(m7)[8] * x^7
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m8)[1] +
        coef(m8)[2] * x +
        coef(m8)[3] * x^2 +
        coef(m8)[4] * x^3 +
        coef(m8)[5] * x^4 +
        coef(m8)[6] * x^5 +
        coef(m8)[7] * x^6 +
        coef(m8)[8] * x^7 +
        coef(m8)[9] * x^8
    },
    alpha = 0.3
  ) +
  geom_function(
    fun = function(x) {
      coef(m9)[1] +
        coef(m9)[2] * x +
        coef(m9)[3] * x^2 +
        coef(m9)[4] * x^3 +
        coef(m9)[5] * x^4 +
        coef(m9)[6] * x^5 +
        coef(m9)[7] * x^6 +
        coef(m9)[8] * x^7 +
        coef(m9)[9] * x^8 +
        coef(m9)[10] * x^9
    },
    color = okabeito_colors(3)
  ) +
  theme_bw()

ggsave('overfit-14.png', height = 4.5, width = 8)


# 03-regularization.md

data.frame(x = seq(-4, 4, length.out = 1e3)) |>
  ggplot(aes(x = x)) +
  geom_function(fun = dnorm, color = okabeito_colors(1), ) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  labs(y = 'p') +
  theme_bw()

ggsave('normal.png', height = 9, width = 8)

data.frame(x = seq(-4, 4, length.out = 1e3)) |>
  ggplot(aes(x = x)) +
  geom_function(
    fun = function(x) 0.5 * exp(-1 * abs(x)),
    color = okabeito_colors(2)
  ) +
  geom_function(fun = dnorm, color = okabeito_colors(1), alpha = 0.3) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  theme_bw()

ggsave('laplace.png', height = 9, width = 8)


# 05-bootstrap.md

d <- data.frame(x = rnorm(1e2))
d$y <- -1.5 + 3 * d$x + rnorm(1e2)

m <- lm(y ~ x, d)

summary(m)$coefficients
coef(m)[2]

Beta1Boot <- function(d) {
  idx <- sample(nrow(d), replace = TRUE)
  m <- lm(y ~ x, d[idx, ])
  beta1 <- unname(coef(m)[2])
  return(beta1)
}

replicate(5, Beta1Boot(d))

N_boot <- 1e6
boot <- data.frame(rep = 1:N_boot, beta1 = replicate(N_boot, Beta1Boot(d)))

ggplot(boot, aes(x = rep, y = beta1)) +
  geom_point(alpha = 0.3) +
  geom_hline(
    aes(yintercept = summary(m)$coefficients[2, 1]),
    color = okabeito_colors(3)
  ) +
  geom_ribbon(
    aes(
      ymin = summary(m)$coefficients[2, 1] -
        1.96 * summary(m)$coefficients[2, 2],
      ymax = summary(m)$coefficients[2, 1] +
        1.96 * summary(m)$coefficients[2, 2]
    ),
    fill = okabeito_colors(3),
    alpha = 0.4
  ) +
  theme_bw()

ggsave('bootstrap-01.png', height = 9, width = 8)

ggplot(boot, aes(x = beta1)) +
  geom_histogram(
    aes(y = after_stat(density)),
    color = 'black',
    fill = okabeito_colors(1),
    alpha = 0.7
  ) +
  geom_function(
    fun = dnorm,
    size = 2,
    color = okabeito_colors(2),
    args = list(
      mean = summary(m)$coefficients[2, 1],
      sd = summary(m)$coefficients[2, 2]
    )
  ) +
  theme_bw()

ggsave('bootstrap-02.png', height = 9, width = 8)


summary(m)$coefficients[2, 1:2]
c(
  summary(m)$coefficients[2, 1] - 1.96 * summary(m)$coefficients[2, 2],
  summary(m)$coefficients[2, 1] + 1.96 * summary(m)$coefficients[2, 2]
)

c(mean(boot$beta1), sd(boot$beta1))
quantile(boot$beta1, c(0.025, 0.975))
