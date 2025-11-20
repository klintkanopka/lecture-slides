library(tidyverse)
library(see)
library(parallel)

setwd('~/projects/lecture-slides/slides/statcomp-lect-12/public/')

set.seed(242424)

n_locations <- 50

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


# now we implement MCMC!

TravelingSalesmanMCMC <- function(chain_id, N_iter, temp, dist_mat) {
  dist <- vector('numeric', length = N_iter)
  path <- sample(1:nrow(dist_mat))
  best <- path

  for (i in 1:N_iter) {
    new_path <- PermutePath(path)

    if (
      TripDist(new_path, dist_mat) < TripDist(path, dist_mat) | runif(1) < temp
    ) {
      path <- new_path
    }

    if (TripDist(path, dist_matrix) < TripDist(best, dist_mat)) {
      best <- path
    }

    dist[i] <- TripDist(path, dist_mat)
  }

  out <- list(
    best = best,
    best_dist = TripDist(path, dist_mat),
    dist = data.frame(
      i = 1:N_iter,
      dist = dist,
      temp = temp,
      chain_id = chain_id
    )
  )

  return(out)
}

system.time(single_out <- TravelingSalesmanMCMC(1, 1e5, 0.01, dist_mat))

ggplot(single_out$dist, aes(x = i, y = dist)) +
  geom_line(color = okabeito_colors(2)) +
  theme_minimal()

ggsave('parallel-01.png', height = 9, width = 8)

control <- expand.grid(
  chain_id = 1:8,
  temp = c(0.0001, 0.001, 0.01, 0.1),
  N_iter = 1e5
)


system.time({
  cl <- makeCluster(4)
  clusterExport(
    cl,
    c('TripDist', 'PermutePath', 'TravelingSalesmanMCMC', 'control', 'dist_mat')
  )
  par_out <- clusterMap(
    cl,
    TravelingSalesmanMCMC,
    chain_id = control$chain_id,
    N_iter = control$N_iter,
    temp = control$temp,
    MoreArgs = list(dist_mat = dist_mat)
  )
  stopCluster(cl)
})


d_out_par <- data.frame()

for (i in 1:nrow(control)) {
  print(par_out[[i]]$best)
  print(par_out[[i]]$best_dist)
  d_out_par <- rbind(d_out_par, par_out[[i]]$dist)
}

ggplot(d_out_par, aes(x = i, y = dist, color = as.factor(chain_id))) +
  geom_line() +
  facet_grid(temp ~ .) +
  scale_color_okabeito() +
  labs(color = 'chain') +
  theme_bw()

ggsave('parallel-02.png', height = 9, width = 8)

# single

#    user  system elapsed
#   3.931   0.015   3.948

# full

#    user  system elapsed
#   0.101   0.102  34.735
