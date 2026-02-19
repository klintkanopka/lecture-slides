library(tidyverse)
library(mirt)

setwd('~/projects/lecture-slides/slides/measurement-lect-05/public')

d <- read_csv('grit_brummerhoffman_2021.csv')

resp <- d |>
  select(id, item, resp) |>
  pivot_wider(id_cols = id, names_from = item, values_from = resp) |>
  select(-id)

m <- mirt(resp, model = 2, itemtype = 'graded')

coef(m, simplify = TRUE)

summary(m)

fscores(m)
