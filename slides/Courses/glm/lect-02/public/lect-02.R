library(tidyverse)
library(see)
library(pROC)

setwd("~/projects/lecture-slides/slides/Courses/glm/lect-02/public/")


data.frame(x = seq(-4, 4, length.out = 1e3)) |>
  mutate(logit = plogis(x), probit = pnorm(x), cloglog = 1 - exp(-exp(x))) |>
  pivot_longer(-x, names_to = 'link', values_to = 'p') |>
  ggplot(aes(x = x, y = p, color = link)) +
  geom_line(linewidth = 1) +
  scale_color_okabeito() +
  theme_bw() +
  labs(color = NULL) +
  theme(legend.position = "bottom")

ggsave('binary-links.svg', width = 4, height = 4.5)


set.seed(242424)

n <- 500
d <-
  data.frame(
    x1 = rnorm(n),
    x2 = rnorm(n)
  )

d$p <- plogis(0.4 + 0.9 * d$x1 - 0.5 * d$x2)
d$y <- rbinom(n, 1, p = d$p)

m1_int <- glm(y ~ 1, data = d, family = binomial(link = 'logit'))
m1_x1 <- glm(y ~ x1, data = d, family = binomial(link = "logit"))
m1 <- glm(y ~ x1 + x2, data = d, family = binomial(link = 'logit'))

m2 <- glm(y ~ x1 + x2, data = d, family = binomial(link = "probit"))
m3 <- glm(y ~ x1 + x2, data = d, family = binomial(link = "cloglog"))


anova(m1_int, m1_x1, m1)

anova(m1, m2, m3)


AIC(m1_int, m1_x1, m1)
AIC(m1, m2, m3)

BIC(m1_int, m1_x1, m1)
BIC(m1, m2, m3)


d$p_hat_m1_int <- predict(m1_int, type = "response")
d$y_hat_m1_int <- ifelse(d$p_hat_m1_int > 0.5, 1, 0)

mean(d$y_hat_m1_int == d$y)

d$p_hat_m1_x1 <- predict(m1_x1, type = "response")
d$y_hat_m1_x1 <- ifelse(d$p_hat_m1_x1 > 0.5, 1, 0)

mean(d$y_hat_m1_x1 == d$y)

d$p_hat_m1 <- predict(m1, type = "response")
d$y_hat_m1 <- ifelse(d$p_hat_m1 > 0.5, 1, 0)

mean(d$y_hat_m1 == d$y)

d$p_hat_m2 <- predict(m2, type = "response")
d$y_hat_m2 <- ifelse(d$p_hat_m2 > 0.5, 1, 0)

mean(d$y_hat_m2 == d$y)

d$p_hat_m3 <- predict(m3, type = "response")
d$y_hat_m3 <- ifelse(d$p_hat_m3 > 0.5, 1, 0)

mean(d$y_hat_m3 == d$y)

table(d[, c("y_hat_m1_int", "y")])
table(d[, c("y_hat_m1_x1", "y")])
table(d[, c("y_hat_m1", "y")])


table(d[, c("y_hat_m1", "y")])
table(d[, c("y_hat_m2", "y")])
table(d[, c("y_hat_m3", "y")])

roc1 <- roc(d$y, d$p_hat_m1)
roc2 <- roc(d$y, d$p_hat_m2)
roc3 <- roc(d$y, d$p_hat_m3)

auc(roc1)
auc(roc2)
auc(roc3)

ggroc(list(logit = roc1, probit = roc2, cloglog = roc3)) +
  geom_abline(intercept = 1, slope = 1, linetype = 2, alpha = 0.5) +
  coord_equal() +
  scale_color_okabeito() +
  theme_bw() +
  labs(color = NULL) +
  theme(legend.position = "bottom")

ggsave('roc-curves.svg', width = 4, height = 4.5)

roc1 <- roc(d$y, d$p_hat_m1_int)
roc2 <- roc(d$y, d$p_hat_m1_x1)
roc3 <- roc(d$y, d$p_hat_m1)

auc(roc1)
auc(roc2)
auc(roc3)

ggroc(list(intercept = roc1, x1 = roc2, full = roc3)) +
  geom_abline(intercept = 1, slope = 1, linetype = 2, alpha = 0.5) +
  coord_equal() +
  scale_color_okabeito() +
  theme_bw() +
  labs(color = NULL) +
  theme(legend.position = "bottom")

ggsave('roc-curves-nested.svg', width = 4, height = 4.5)
