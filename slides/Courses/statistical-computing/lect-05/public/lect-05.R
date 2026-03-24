library(ggplot2)
library(see)

setwd('~/projects/lecture-slides/slides/statcomp-lect-05/public/')

# 02-permutation-tests.md

set.seed(215)
test_data <- data.frame(
  group = rep(c('A', 'B'), each = 10),
  score = c(
    round(rnorm(10, mean = 90, sd = 5)),
    round(rnorm(10, mean = 75, sd = 15))
  )
)
true_diff <- mean(test_data$score[test_data == 'A']) -
  mean(test_data$score[test_data == 'B'])

true_diff

ggplot(test_data, aes(x = score, fill = group)) +
  geom_histogram() +
  facet_grid(group ~ .) +
  scale_fill_okabeito() +
  theme_bw()

ggsave('test-01.png', height = 9, width = 8)


ReassignScores <- function(data) {
  # TODO: Reassign groups
  new_groups <- sample(data[['group']])

  # TODO: Compute means
  mean_A <- mean(data[['score']][new_groups == 'A'])
  mean_B <- mean(data[['score']][new_groups == 'B'])

  # TODO: Return difference in means
  mean_diff <- mean_A - mean_B
  return(mean_diff)
}

ReassignScores(test_data)

mean_diff = replicate(1e4, ReassignScores(test_data))
mean(mean_diff >= true_diff)

#

data.frame(mean_diff = mean_diff) |>
  ggplot(aes(x = mean_diff)) +
  geom_histogram(alpha = 0.7, color = 'black', bins = 20) +
  geom_vline(
    aes(xintercept = true_diff),
    linewidth = 2,
    color = 'deepskyblue'
  ) +
  theme_bw()

ggsave('test-02.png', height = 9, width = 8)

test_data <- data.frame(
  group = rep(c('A', 'B'), each = 1e4),
  score = c(
    round(rnorm(1e4, mean = 90, sd = 5)),
    round(rnorm(1e4, mean = 75, sd = 15))
  )
)
true_diff <- mean(test_data$score[test_data == 'A']) -
  mean(test_data$score[test_data == 'B'])

true_diff

ggplot(test_data, aes(x = score, fill = group)) +
  geom_histogram(bins = 40) +
  facet_grid(group ~ .) +
  scale_fill_okabeito() +
  theme_bw()

ggsave('test-03.png', height = 9, width = 8)

mean_diff = replicate(1e4, ReassignScores(test_data))
mean(mean_diff >= true_diff)

data.frame(mean_diff = mean_diff) |>
  ggplot(aes(x = mean_diff)) +
  geom_histogram(alpha = 0.7, color = 'black', bins = 20) +
  geom_vline(
    aes(xintercept = true_diff),
    linewidth = 2,
    color = 'deepskyblue'
  ) +
  theme_bw()

ggsave('test-04.png', height = 9, width = 8)

# 03-buffons-needle.md

TossNeedle <- function(l, t) {
  # TODO: Simulate a needle toss on the floor
  left_edge <- runif(1, min = 0, max = t)
  theta <- runif(1, min = -pi / 2, max = pi / 2)
  # TODO: Decide if it crosses a threshold
  right_edge <- left_edge + l * cos(theta)
  result <- right_edge > t
  # TODO: Return TRUE or FALSE depending
  return(result)
}

TossNeedle(1, 2)

replicate(3, TossNeedle(1, 2))

mean(replicate(1e5, TossNeedle(1, 2)))
mean(replicate(1e5, TossNeedle(1, 5)))
mean(replicate(1e5, TossNeedle(1, 10)))
