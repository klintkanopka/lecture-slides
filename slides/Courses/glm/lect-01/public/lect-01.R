library(tidyverse)
library(see)

setwd("~/courses/archive/03-glmm/apsta-2044-s2425/wk01/")
d <- read_csv("data/manhattan_restaurants.csv")


d_logit <- data.frame(mu = seq(0, 1, by = 1e-3))
d_logit$eta <- log(d_logit$mu / (1 - d_logit$mu))

ggplot(d_logit, aes(x = mu, y = eta)) +
  geom_line(color = okabeito_colors(3), linewidth = 1) +
  theme_bw()

ggsave('logit.svg', height = 4.5, width = 4)


ggplot(d_logit, aes(x = eta, y = mu)) +
  geom_line(color = okabeito_colors(3), linewidth = 1) +
  theme_bw()

ggsave('logistic.svg', height = 4.5, width = 4)


m_linear <- lm(critical ~ score + cuisine + 0, data = d)
summary(m_linear)

d$p_hat_linear <- predict(m_linear)

ggplot(d, aes(x = p_hat_linear, y = critical)) +
  geom_point(alpha = 0.3) +
  theme_minimal()

ggplot(d, aes(x = p_hat_linear, y = as.factor(critical))) +
  geom_boxplot() +
  theme_minimal()

m_glm <- glm(
  critical ~ score + cuisine + 0,
  data = d,
  family = binomial(link = "logit")
)

summary(m_glm)

d$p_hat_glm <- predict(m_glm, type = "response")

ggplot(d, aes(x = p_hat_linear, y = p_hat_glm)) +
  geom_point() +
  theme_minimal()

d$y_hat <- ifelse(d$p_hat_glm > 0.5, 1, 0)

table(d$critical, d$y_hat)
mean(d$critical)

ggplot(d, aes(x = p_hat_glm, y = as.factor(critical))) +
  geom_boxplot() +
  theme_minimal()
