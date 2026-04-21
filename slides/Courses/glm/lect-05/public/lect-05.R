library(tidyverse)
library(see)
library(lme4)

setwd('~/projects/lecture-slides/slides/Courses/glm/lect-05/public/')


d <- read_csv('lect-05-data.csv')


names(d)

length(unique(d$student_id))
length(unique(d$teacher_id))
length(unique(d$school_id))

nrow(d)

d |>
  count(teacher_id) |>
  ggplot(aes(x = n)) +
  geom_histogram(bins = 20, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-1.svg', height = 4.5, width = 4)


d |>
  count(school_id) |>
  ggplot(aes(x = n)) +
  geom_histogram(bins = 20, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-2.svg', height = 4.5, width = 4)


d |>
  select(teacher_id, school_id) |>
  distinct() |>
  count(school_id) |>
  ggplot(aes(x = n)) +
  geom_histogram(bins = 10, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-3.svg', height = 4.5, width = 4)


d |>
  ggplot(aes(x = debate_team)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-4.svg', height = 4.5, width = 4)

d |>
  ggplot(aes(x = basketball_team)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-5.svg', height = 4.5, width = 4)

d |>
  ggplot(aes(x = only_child)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-6.svg', height = 4.5, width = 4)

d |>
  select(teacher_id, years_experience) |>
  distinct() |>
  ggplot(aes(x = years_experience)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-7.svg', height = 4.5, width = 4)

d |>
  select(teacher_id, class_size) |>
  distinct() |>
  ggplot(aes(x = class_size)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-8.svg', height = 4.5, width = 4)

d |>
  select(school_id, pct_frl) |>
  distinct() |>
  ggplot(aes(x = pct_frl)) +
  geom_histogram(bins = 15, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-9.svg', height = 4.5, width = 4)

d |>
  select(school_id, pct_ell) |>
  distinct() |>
  ggplot(aes(x = pct_ell)) +
  geom_histogram(bins = 15, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-10.svg', height = 4.5, width = 4)

d |>
  ggplot(aes(x = pretest)) +
  geom_histogram(bins = 20, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-11.svg', height = 4.5, width = 4)

d |>
  ggplot(aes(x = posttest)) +
  geom_histogram(bins = 20, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('mlm-12.svg', height = 4.5, width = 4)


# Building MLMs

m_0 <- lm(posttest ~ pretest, data = d)
summary(m_0)
