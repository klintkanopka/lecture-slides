library(tidyverse)
library(see)
library(lme4)

setwd('~/projects/lecture-slides/slides/Courses/glm/lect-05/public/')


# Simulated Data

set.seed(242424)

# simulate data for individuals, assign to groups
d_sim <- data.frame(student_id = 1:(9 * 30))
d_sim$classroom <- rep(1:9, each = 30)
d_sim$study_time <- sample(0:5, 9 * 30, replace = T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
d_classroom$teacher_effect <- rnorm(9, mean = 30, sd = 20)
d_classroom$teacher_factor <- rnorm(9, 1, 2)

# join them together - left join group to individuals
d_sim <- left_join(d_sim, d_classroom, by = 'classroom')

# generate your outcome variable, don't forget to add noise!
d_sim$score <- set.seed(242424)

# simulate data for individuals, assign to groups
d_sim <- data.frame(student_id = 1:(9 * 30))
d_sim$classroom <- rep(1:9, each = 30)
d_sim$study_time <- sample(0:5, 9 * 30, replace = T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
d_classroom$teacher_effect <- rnorm(9, mean = 30, sd = 20)
d_classroom$teacher_factor <- rnorm(9, 1, 2)

# join them together - left join group to individuals
d_sim <- left_join(d_sim, d_classroom, by = 'classroom')

# generate your outcome variable, don't forget to add noise!
d_sim$score <- d_sim$teacher_effect +
  10 * d_sim$teacher_factor * d_sim$study_time +
  rnorm(nrow(d_sim), mean = 0, sd = 10)

# fit models

summary(lm(score ~ study_time, data = d_sim))

summary(lm(score ~ 0 + study_time + as.character(classroom), data = d_sim))

summary(lmer(score ~ (1 | classroom) + study_time, data = d_sim))

summary(lm(score ~ as.character(classroom) * study_time, data = d_sim))

summary(lmer(score ~ study_time + (1 + study_time | classroom), data = d_sim))

m <- lmer(score ~ study_time + (1 + study_time | classroom), data = d_sim)

ranef(m)

# fun stuff, new data!

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

m_1 <- lm(posttest ~ pretest + years_experience, data = d)
m_1a <- lmer(
  posttest ~ pretest + years_experience + (years_experience | school_id),
  data = d
)

summary(m_2)
