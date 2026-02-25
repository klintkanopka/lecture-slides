library(tidyverse)
library(mirt)

setwd(
  '~/projects/lecture-slides/slides/Courses/measurement/measurement-lect-05/public'
)

GenSquashData <- function(n_matches = 100, n_players = 10, seed = 8675309) {
  set.seed(seed)
  theta <- rnorm(n_players, mean = 0, sd = 1)

  player_1 <- vector('numeric', length = n_matches)
  player_2 <- vector('numeric', length = n_matches)

  for (i in 1:n_matches) {
    match <- sample(1:n_players, 2, replace = FALSE)
    player_1[i] <- match[1]
    player_2[i] <- match[2]
  }

  p <- plogis(theta[player_1] - theta[player_2])
  result <- rbinom(n_matches, 1, p = p)
  out <- list(
    d = data.frame(player_1 = player_1, player_2 = player_2, result = result),
    theta = theta
  )
  return(out)
}


tmp <- GenSquashData(1000, 100)
d <- tmp$d
true_theta <- tmp$theta

starting_theta <- rnorm(100)

LogLikMatch <- function(data, theta) {
  p <- plogis(theta[data$player_1] - theta[data$player_2])
  ll <- sum(data$result * log(p) + (1 - data$result) * log(1 - p))
  return(ll)
}

sol <- optim(
  starting_theta,
  LogLikMatch,
  data = d,
  method = 'L-BFGS-B',
  lower = -3,
  upper = 3,
  control = list(fnscale = -1, maxit = 1e6)
)
cor(sol$par, true_theta)
plot(sol$par, true_theta)


setwd('~/courses/apsta-2094-s2425/wk06')
saveRDS(d, 'data/squash_matches.rds')
saveRDS(true_theta, 'data/true_squash_theta.rds')


tmp <- d |>
  mutate(win = if_else(result == 1, player_1, player_2)) |>
  mutate(loss = if_else(result == 0, player_1, player_2))

wins <- tmp |>
  count(win) |>
  select(player = win, wins = n)

losses <- tmp |>
  count(loss) |>
  select(player = loss, losses = n)


tot <- full_join(wins, losses, by = 'player')

tot[is.na(tot)] <- 0

tot <- tot |>
  mutate(p = wins / (wins + losses)) |>
  mutate(theta = true_theta)

ggplot(tot, aes(x = p, y = theta)) +
  geom_point()

cor(tot$p, tot$theta)
