library(tidyverse)
library(see)
library(mirt)
library(lubridate)

setwd('~/projects/lecture-slides/slides/measurement-lect-04/public/')

set.seed(242424)

load('SCDB_2022_01_justiceCentered_Citation.Rdata')


d <- SCDB_2022_01_justiceCentered_Citation |>
  filter(year(dateDecision) >= 2000) |>
  select(caseId, justiceName, vote) |>
  mutate(
    vote = case_when(vote %in% c(1, 3) ~ 1, vote == 2 ~ 0, TRUE ~ NA_real_)
  ) |>
  na.omit() |>
  group_by(caseId) |>
  mutate(var = var(vote, na.rm = T)) |>
  filter(var != 0) |>
  pivot_wider(id_cols = justiceName, names_from = caseId, values_from = vote)


resp <- select(d, -justiceName) # mirt doesn't want respondent ids
m1 <- mirt(resp, model = 1, itemtype = 'Rasch')
m2 <- mirt(resp, model = 1, itemtype = '2PL')

d$onepl_score <- fscores(m1) # estimate scores for justices and append it

ggplot(d, aes(x = onepl_score, y = reorder(justiceName, onepl_score))) +
  geom_point(color = okabeito_colors(3)) +
  labs(y = NULL) +
  theme_bw()

ggsave('1pl-score.svg', height = 4.5, width = 4)

anova(m1, m2)

d$twopl_score <- fscores(m2)

ggplot(d, aes(x = twopl_score, y = reorder(justiceName, twopl_score))) +
  geom_point(color = okabeito_colors(3)) +
  labs(y = NULL) +
  theme_bw()

ggsave('2pl-score.svg', height = 4.5, width = 4)


case_names <- SCDB_2022_01_justiceCentered_Citation |>
  select(caseId, caseName) |>
  distinct()

items <- data.frame(coef(m2, IRTpars = TRUE, simplify = TRUE)$items) |>
  select(-g, -u) |>
  rownames_to_column('caseId') |>
  left_join(case_names, by = 'caseId')


items |>
  arrange(-b) |>
  head(5) |>
  pull(caseName)

# Top 5 extreme "negative" cases

items |>
  arrange(b) |>
  head(5) |>
  pull(caseName)

# Cases with small difficulties

items |>
  filter(abs(b) < 1) |>
  arrange(b) |>
  head(5) |>
  pull(caseName)
