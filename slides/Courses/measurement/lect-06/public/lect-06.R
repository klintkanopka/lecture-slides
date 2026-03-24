library(tidyverse)
library(mirt)
library(see)
library(viridis)

setwd(
  '~/projects/lecture-slides/slides/Courses/measurement/measurement-lect-06/public'
)

# IRT models

d <- read_csv('empathizing_systemizing.csv')

unique(d$resp)

# [1]  1  2  3  4 NA

resp <- d |>
  pivot_wider(
    id_cols = id,
    names_prefix = 'item_',
    names_from = item,
    values_from = resp
  ) |>
  select(-id)

tree_resp_node_1 <- resp
tree_resp_node_1[is.na(resp)] <- 0
tree_resp_node_1[!is.na(resp)] <- 1
colnames(tree_resp_node_1) <- paste0('F1_', colnames(tree_resp_node_1))

tree_resp_node_2 <- resp
tree_resp_node_2[resp <= 2] <- 0
tree_resp_node_2[resp >= 3] <- 1
colnames(tree_resp_node_2) <- paste0('F2_', colnames(tree_resp_node_2))

tree_resp_node_3 <- resp
tree_resp_node_3[resp == 2] <- 0
tree_resp_node_3[resp == 3] <- 0
tree_resp_node_3[resp == 1] <- 1
tree_resp_node_3[resp == 4] <- 1
colnames(tree_resp_node_3) <- paste0('F3_', colnames(tree_resp_node_3))


tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(s, itemnames = names(tree_resp))

system.time(m <- mirt(tree_resp, tree_model, itemtype = 'Rasch'))

system.time(thetas <- fscores(m))

tree_pars <- coef(m, IRTpars = TRUE, simplify = TRUE)
tree_pars


# Elo Models

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


tmp <- d |>
  mutate(win = if_else(result == 1, player_1, player_2)) |>
  mutate(loss = if_else(result == 0, player_1, player_2))

wins <- tmp |>
  count(win) |>
  select(player = win, wins = n)

losses <- tmp |>
  count(loss) |>
  select(player = loss, losses = n)


tot <- full_join(wins, losses, by = 'player') |>
  arrange(player)

tot[is.na(tot)] <- 0

tot <- tot |>
  mutate(p = wins / (wins + losses), theta = sol$par, n = wins + losses)

ggplot(tot, aes(x = p, y = theta, color = n)) +
  scale_color_viridis_c() +
  geom_point() +
  theme_bw()

ggsave('elo-output.svg', height = 4.5, width = 4)

cor(tot$p, tot$theta)
