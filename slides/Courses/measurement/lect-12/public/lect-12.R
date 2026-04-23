library(tidyverse)
library(see)

setwd('~/projects/lecture-slides/slides/Courses/measurement/lect-12/public/')

read_delim(
  '~/Desktop/ml-100k/u.data',
  col_names = c('user', 'movie', 'rating', 'timestamp')
)
