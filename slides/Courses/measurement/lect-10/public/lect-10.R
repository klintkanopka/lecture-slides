library(tidyverse)
library(see)
library(glca)

setwd('~/projects/lecture-slides/slides/Courses/measurement/lect-10/public/')

d <- read_csv('citywide-mobility-survey.csv')


# first (bad) pass

f <- item(
  attitude_street_dining,
  attitude_drive,
  attitude_walk,
  attitude_bike,
  attitude_bus,
  attitude_stay_home
) ~ 1

m2 <- glca(f, data = d, nclass = 2, verbose = F)
m3 <- glca(f, data = d, nclass = 3, verbose = F)
m4 <- glca(f, data = d, nclass = 4, verbose = F)
m5 <- glca(f, data = d, nclass = 5, verbose = F)

gofglca(m2, m3, m4, m5, test = 'boot')


summary(m4)
plot(m4)


# recoded pass

d_subset <- d |>
  select(
    person_id,
    attitude_street_dining,
    attitude_drive,
    attitude_walk,
    attitude_bike,
    attitude_bus,
    attitude_stay_home
  ) |>
  mutate(across(
    starts_with('attitude_'),
    ~ case_when(
      .x %in% c(1, 2) ~ 3,
      .x == 3 ~ 2,
      .x %in% c(4, 5) ~ 1,
      TRUE ~ NA
    )
  ))


m2 <- glca(f, data = d_subset, nclass = 2, verbose = F)
m3 <- glca(f, data = d_subset, nclass = 3, verbose = F)
m4 <- glca(f, data = d_subset, nclass = 4, verbose = F)
m5 <- glca(f, data = d_subset, nclass = 5, verbose = F)
m6 <- glca(f, data = d_subset, nclass = 6, verbose = F)
m7 <- glca(f, data = d_subset, nclass = 7, verbose = F)

gofglca(m2, m3, m4, m5, m6, m7, test = 'boot')


plot(m2)
