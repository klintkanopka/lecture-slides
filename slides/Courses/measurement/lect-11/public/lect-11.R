library(tidyverse)
library(GDINA)
library(see)

setwd('~/projects/lecture-slides/slides/Courses/measurement/lect-11/public/')
# Cognitive Diagnostic Models!

# GDINA with simulated data

d <- sim10GDINA$simdat
Q <- sim10GDINA$simQ

d
Q

m_1 <- GDINA(dat = d, Q = Q, model = "DINA")
m_1

summary(m_1)

Qval(m_1)

coef(m_1)
coef(m_1, what = 'gs')

personparm(m_1)

plot(m_1, what = 'IRF', item = 10)

ggsave('gdina-item.svg', height = 4.5, width = 4)

plot(m_1, what = 'mp', person = 5:8) +
  scale_fill_okabeito() +
  theme_bw()

ggsave('gdina-mp.svg', height = 4.5, width = 4)


# 20 (real) items about fractions

frac20 <- read_csv('frac20.csv')

d <- frac20 |>
  select(id, item, resp) |>
  pivot_wider(id_cols = id, names_from = item, values_from = 'resp') |>
  arrange(id) |>
  select(-id)

Q <- frac20 |>
  select(item, starts_with("Qmatrix")) |>
  distinct() |>
  mutate(item = as.numeric(str_remove(item, 'item_'))) |>
  arrange(item) |>
  select(-item)


m_2 <- GDINA(dat = d, Q = Q, model = "DINA")
m_2
summary(m_2)

Qval(m_2)

coef(m_2)
coef(m_2, what = 'gs')

personparm(m_2)
plot(m_2)
plot(m_2, what = 'mp', person = 3:5) +
  scale_fill_okabeito() +
  theme_bw()


# Response time now!

d <- read_csv('roar_lexical.csv') |>
  filter(rt <= 5)

d |>
  group_by(item) |>
  mutate(stdz_lrt = scale(log(rt))[, 1]) |>
  ungroup() |>
  group_by(id) |>
  summarize(score = mean(resp), slrt = mean(stdz_lrt)) |>
  ungroup() |>
  mutate(bins = ntile(slrt, 100)) |>
  group_by(bins) |>
  summarize(mean_score = mean(score)) |>
  ggplot(aes(x = bins, y = mean_score)) +
  geom_point() +
  geom_smooth(color = okabeito_colors(3), se = FALSE) +
  labs(x = 'response time quantile', y = 'mean score') +
  theme_bw()

ggsave('rt-score.svg', height = 4.5, width = 4)


d |>
  group_by(id) |>
  mutate(sum_score = sum(resp)) |>
  ungroup() |>
  mutate(adj_score = sum_score - resp) |>
  group_by(item) |>
  mutate(stdz_lrt = scale(log(rt))[, 1]) |>
  mutate(bins = ntile(stdz_lrt, 100)) |>
  group_by(bins) |>
  summarize(itc = cor(resp, adj_score)) |>
  ggplot(aes(x = bins, y = itc)) +
  geom_point() +
  geom_smooth(color = okabeito_colors(3), se = FALSE) +
  labs(x = 'response time quantile', y = 'item-total correlation') +
  theme_bw()

ggsave('rt-itc.svg', height = 4.5, width = 4)
