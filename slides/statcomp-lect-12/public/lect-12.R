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

########################
# parallel comparisons #
########################

system.time(single_out <- TravelingSalesmanMCMC(1, 1e5, 0.01, dist_mat))

ggplot(single_out$dist, aes(x = i, y = dist)) +
  geom_line(color = okabeito_colors(2)) +
  theme_bw()

ggsave('parallel-01.png', height = 9, width = 8)


system.time({
  lapply_out <- lapply(
    1:10,
    TravelingSalesmanMCMC,
    N_iter = 1e5,
    temp = 0.01,
    dist_mat = dist_mat
  )
})

system.time({
  mc_out <- mclapply(
    1:10,
    TravelingSalesmanMCMC,
    N_iter = 1e5,
    temp = 0.01,
    dist_mat = dist_mat,
    mc.cores = 4
  )
})


control <- expand.grid(
  chain_id = 1:10,
  temp = c(0.0001, 0.001, 0.01, 0.1),
  N_iter = 1e5
)

system.time({
  cl <- makeCluster(6)
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


d <- data.frame(
  x1 = rnorm(1e3),
  x2 = rnorm(1e3),
  x3 = rnorm(1e3)
)

d$y <- -2 + 0.3 * d$x1 - 7 * d$x2 * d$x3 + rnorm(1e3)

m <- lm(y ~ x1 * x2 * x3, d)
summary(m)

coef(m)
est_real <- unname(coef(m)[7])

boot <- function(rep, data) {
  idx <- sample(nrow(data), replace = T)
  d_tmp <- data[idx, ]
  m <- lm(y ~ x1 * x2 * x3, d_tmp)
  est <- unname(coef(m)[7])
  return(data.frame(rep = rep, est = est))
}


boot_out <- lapply(1:1e4, boot, data = d)

boot_out <- do.call('rbind', boot_out)
boot_out

ggplot(boot_out, aes(x = est)) +
  geom_histogram() +
  geom_vline(aes(xintercept = est_real))


cl <- makeCluster(4)
clusterExport(cl, c('boot', 'd'))

par_out <- parLapply(cl, 1:1e5, boot, data = d)

stopCluster(cl)
par_out
par_out <- do.call('rbind', par_out)
par_out

ggplot(par_out, aes(x = est)) +
  geom_histogram() +
  geom_vline(aes(xintercept = est_real))
