library(ggplot2)
library(tidyverse)
library(see)
library(viridis)

setwd('~/projects/lecture-slides/slides/statcomp-lect-09/public/')
set.seed(1337)

###############
# 01-intro.md #
###############

HotDogsDogs <- function(par) {
  x <- par[1]
  y <- par[2]
  R <- -5 * x^2 - 8 * y^2 - 2 * x * y + 42 * x + 102 * y
  return(R)
}

hotdogs <- expand.grid(x = 0:10, y = 0:10, revenue = 0)
for (i in 1:nrow(hotdogs)) {
  hotdogs$revenue[i] <- HotDogsDogs(c(hotdogs$x[i], hotdogs$y[i]))
}

ggplot(hotdogs, aes(x = x, y = y, fill = revenue)) +
  geom_tile() +
  scale_fill_viridis_c() +
  coord_equal() +
  theme_bw()

ggsave('optim.png', height = 9, width = 8)

out <- optim(
  c(1, 1),
  HotDogsDogs,
  lower = c(0, 0),
  upper = c(10, 10),
  method = "L-BFGS-B",
  control = list(fnscale = -1)
)

out$par

##############
# 02-mcmc.md #
##############

# we can optimize the same function

HotDogsDogs <- function(par) {
  x <- par[1]
  y <- par[2]
  R <- -5 * x^2 - 8 * y^2 - 2 * x * y + 42 * x + 102 * y
  return(R)
}

# next we propose new parameters

ProposeParams <- function(params, lambda) {
  new_params <- params + rnorm(2, mean = 0, sd = lambda)
  return(new_params)
}

N_iter <- 5e4

revenue <- vector('numeric', length = N_iter)
params <- rep(0, 2)
best <- params

param_history <- matrix(NA, nrow = N_iter, ncol = 1 + length(params))

lambda <- 1e-3
T <- 0.025

for (i in 1:N_iter) {
  new_params <- ProposeParams(params, lambda)

  if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < T) {
    params <- new_params
  }

  if (HotDogsDogs(params) > HotDogsDogs(best)) {
    best <- params
  }

  param_history[i, ] <- c(i, params)
  revenue[i] <- HotDogsDogs(params)
}

conv <- data.frame(i = 1:N_iter, revenue = revenue)

ggplot(conv, aes(x = i, y = revenue)) +
  geom_line(color = okabeito_colors(2)) +
  labs(x = 'iteration', y = 'revenue') +
  theme_bw()

ggsave('mcmc-01.png', height = 9, width = 8)


param_history <- data.frame(param_history)
names(param_history) <- c('i', 'x', 'y')

param_history |>
  pivot_longer(-i, names_to = 'param') |>
  ggplot(aes(x = i, y = value, color = param)) +
  geom_line() +
  scale_color_okabeito() +
  theme_bw()

ggsave('mcmc-02.png', height = 9, width = 8)


param_history |>
  pivot_longer(-i, names_to = 'param') |>
  filter(i >= 35000) |>
  filter(param == 'x') |>
  ggplot(aes(x = value, color = param, fill = param)) +
  geom_histogram(alpha = 0.3, bins = 100) +
  scale_color_okabeito() +
  scale_fill_okabeito() +
  theme_bw()

ggsave('mcmc-03.png', height = 9, width = 8)


param_history |>
  pivot_longer(-i, names_to = 'param') |>
  filter(i >= 35000) |>
  filter(param == 'y') |>
  ggplot(aes(x = value, color = param, fill = param)) +
  geom_histogram(alpha = 0.3, bins = 100) +
  scale_color_okabeito() +
  scale_fill_okabeito() +
  theme_bw()

ggsave('mcmc-04.png', height = 9, width = 8)


colMeans(param_history[35000:N_iter, 2:3])
best

# check a variety of temperature parameters!

N_iter <- 5e4
lambda <- 1e-3
Ts <- c(0, 0.25, 0.5, 0.75, 1)
conv <- vector('list', length = length(Ts))
best <- vector('list', length = length(Ts))
T_param_history <- vector('list', length = length(Ts))

for (j in seq_along(Ts)) {
  revenue <- vector('numeric', length = N_iter)
  params <- c(0, 0)
  best[[j]] <- params
  param_history_tmp <- matrix(NA, nrow = N_iter, ncol = 2 + length(params))

  for (i in 1:N_iter) {
    new_params <- ProposeParams(params, lambda)

    if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < Ts[j]) {
      params <- new_params
    }

    if (HotDogsDogs(params) > HotDogsDogs(best[[j]])) {
      best[[j]] <- params
    }

    param_history_tmp[i, ] <- c(i, Ts[j], params)
    revenue[i] <- HotDogsDogs(params)
  }

  conv[[j]] <- data.frame(i = 1:N_iter, revenue = revenue, T = Ts[j])
  T_param_history[[j]] <- param_history_tmp
}

best

conv <- do.call('rbind', conv)
T_param_history <- do.call('rbind', T_param_history)
T_param_history <- as.data.frame(T_param_history)
names(T_param_history) <- c('i', 'T', 'x', 'y')

ggplot(conv, aes(x = i, y = revenue, color = as.character(T))) +
  geom_line() +
  labs(x = 'iteration', y = 'revenue', color = 'temp') +
  scale_color_okabeito() +
  theme_bw()

ggsave('mcmc-05.png', height = 9, width = 8)


T_param_history |>
  pivot_longer(c(x, y), names_to = 'param', values_to = 'value') |>
  filter(param == 'x') |>
  ggplot(aes(x = i, y = value, color = as.character(T))) +
  geom_line() +
  labs(x = 'iteration', color = 'temp') +
  scale_color_okabeito() +
  theme_bw()

ggsave('mcmc-06.png', height = 9, width = 8)


T_param_history |>
  pivot_longer(c(x, y), names_to = 'param', values_to = 'value') |>
  filter(param == 'y') |>
  ggplot(aes(x = i, y = value, color = as.character(T))) +
  geom_line() +
  labs(x = 'iteration', color = 'temp') +
  scale_color_okabeito() +
  theme_bw()

ggsave('mcmc-07.png', height = 9, width = 8)


############################
# 03-traveling-salesman.md #
############################

# generate a matrix for distances between locations
n_locations <- 10

dist_mat <- matrix(0, nrow = n_locations, ncol = n_locations)

for (i in 1:n_locations) {
  for (j in 1:n_locations) {
    if (i == j) {
      dist_mat[i, j] <- 0
    } else if (j > i) {
      dist_mat[i, j] <- runif(1, min = 1, max = 10)
    } else if (j < i) {
      dist_mat[i, j] <- dist_mat[j, i]
    }
  }
}

dist_mat[1:3, 1:3]

# next we need a loss function to evaluate our proposed solution

TripDist <- function(path, dist_matrix) {
  total_dist <- 0
  for (i in seq_along(path)) {
    if (i == length(path)) {
      total_dist <- total_dist + dist_mat[path[i], path[1]]
    } else {
      total_dist <- total_dist + dist_mat[path[i], path[i + 1]]
    }
  }
  return(total_dist)
}

TripDist(1:10, dist_mat)

# finally we need a "transition matrix" - something that makes a new proposal

PermutePath <- function(path) {
  new_path <- path
  p <- sample(1:length(path), 1)
  if (p == length(path)) {
    new_path[p] <- path[1]
    new_path[1] <- path[p]
  } else {
    new_path[p] <- path[p + 1]
    new_path[p + 1] <- path[p]
  }
  return(new_path)
}

PermutePath(1:10)

# now we implement MCMC!

points <- 1:n_locations

N_iter <- 1e6
Ts <- c(0, 0.001, 0.005, 0.01, 0.05)
conv <- vector('list', length = length(Ts))
best <- vector('list', length = length(Ts))


for (j in seq_along(Ts)) {
  dist <- vector('numeric', length = N_iter)
  path <- sample(points)
  best[[j]] <- path

  for (i in 1:N_iter) {
    new_path <- PermutePath(path)

    if (
      TripDist(new_path, dist_mat) < TripDist(path, dist_mat) | runif(1) < Ts[j]
    ) {
      path <- new_path
    }

    if (TripDist(path, dist_matrix) < TripDist(best[[j]], dist_mat)) {
      best[[j]] <- path
    }

    dist[i] <- TripDist(path, dist_mat)
  }

  conv[[j]] <- data.frame(i = 1:N_iter, dist = dist, T = Ts[j])
}

for (j in 1:length(Ts)) {
  print(Ts[j])
  print(best[[j]])
  print(TripDist(best[[j]], dist_mat))
}

conv <- do.call('rbind', conv)

ggplot(conv, aes(x = i, y = dist, color = as.character(T))) +
  geom_line() +
  facet_grid(T ~ .) +
  labs(x = 'iteration', y = 'distance', color = 'temp') +
  scale_color_okabeito() +
  theme_bw()

ggsave('traveling-salesman.png', height = 9, width = 8)
