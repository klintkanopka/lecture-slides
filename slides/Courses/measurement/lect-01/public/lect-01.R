library(tidyverse)
library(see)

setwd('~/projects/lecture-slides/slides/measurement-lect-01/public/')

set.seed(242424)

d <- read_csv('frac20.csv')
d <- d |>
  select(id, item, resp)

write_csv(d, 'frac20_noq.csv')
d <- read_csv('frac20_noq.csv')

length(unique(d$id))
length(unique(d$item))
length(unique(d$resp))

d

d_wide <- pivot_wider(
  d,
  id_cols = id,
  names_from = item,
  values_from = resp
)

d_long <- pivot_longer(
  d_wide,
  cols = -id,
  names_to = 'item',
  values_to = 'resp'
)

# sum score

sum_scores <- d |>
  group_by(id) |>
  summarize(sum_score = sum(resp))

ggplot(sum_scores, aes(x = sum_score)) +
  geom_histogram(
    bins = 10,
    color = 'black',
    fill = okabeito_colors(3)
  ) +
  theme_bw()

ggsave('sum_scores.svg', height = 4.5, width = 4)

# difficulties

diff <- d |>
  group_by(item) |>
  summarize(p = mean(resp))

ggplot(diff, aes(x = p, y = reorder(item, p))) +
  geom_point(
    color = okabeito_colors(3)
  ) +
  labs(x = 'p-value', y = 'item') +
  theme_bw()

ggsave('difficulty.svg', height = 4.5, width = 4)

# discrimination

disc <- left_join(d, sum_scores, by = 'id') |>
  group_by(item) |>
  summarize(a = cor(resp, sum_score))

ggplot(disc, aes(x = a, y = reorder(item, a))) +
  geom_point(
    color = okabeito_colors(3)
  ) +
  labs(x = 'discrimination', y = 'item') +
  theme_bw()

ggsave('discrimination.svg', height = 4.5, width = 4)
