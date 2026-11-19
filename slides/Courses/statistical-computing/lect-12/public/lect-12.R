library(tidyverse)
library(see)
library(parallel)

setwd('~/projects/lecture-slides/slides/Courses/statistical-computing/lect-12/public/')

# L'Ecuyer-CMRG gives every parallel worker its own independent, reproducible
# random number stream (mclapply() uses it automatically; for socket clusters
# we call clusterSetRNGStream() below)
RNGkind("L'Ecuyer-CMRG")
set.seed(242424)

# how many cores do we have? leave one free for the operating system (and you)
detectCores()
detectCores(logical = FALSE)
n_cores <- max(1, detectCores() - 1)
n_cores

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

TripDist <- function(path, dist_mat) {
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

    if (TripDist(path, dist_mat) < TripDist(best, dist_mat)) {
      best <- path
    }

    dist[i] <- TripDist(path, dist_mat)
  }

  out <- list(
    best = best,
    best_dist = TripDist(best, dist_mat),
    dist = data.frame(
      i = 1:N_iter,
      dist = dist,
      temp = temp,
      chain_id = chain_id
    )
  )

  return(out)
}

###############
# Amdahl's law #
###############

# if a fraction p of the work can run in parallel on k cores, the best possible
# speedup is 1 / ((1 - p) + p / k)

Amdahl <- function(p, k) {
  1 / ((1 - p) + p / k)
}

Amdahl(p = 0.9, k = 8)
Amdahl(p = 0.9, k = 1e6)

d_amdahl <- expand.grid(k = 1:64, p = c(0.5, 0.75, 0.9, 0.95, 0.99))
d_amdahl$speedup <- Amdahl(d_amdahl$p, d_amdahl$k)

ggplot(d_amdahl, aes(x = k, y = speedup, color = as.factor(p))) +
  geom_line(linewidth = 1) +
  scale_color_okabeito() +
  labs(x = 'cores', color = 'parallel\nfraction') +
  theme_bw(base_size = 16)

ggsave('amdahl.png', height = 9, width = 8)


########################
# parallel comparisons #
########################

timings <- data.frame()

AddTiming <- function(timings, task, method, t) {
  rbind(timings, data.frame(task = task, method = method, seconds = t[['elapsed']]))
}

t_single <- system.time(
  single_out <- TravelingSalesmanMCMC(1, 1e5, 0.01, dist_mat)
)
timings <- AddTiming(timings, 'TSP: 1 chain', 'serial', t_single)

ggplot(single_out$dist, aes(x = i, y = dist)) +
  geom_line(color = okabeito_colors(2)) +
  theme_bw()

ggsave('parallel-01.png', height = 9, width = 8)


# ten chains, three ways

t_lapply <- system.time({
  lapply_out <- lapply(
    1:10,
    TravelingSalesmanMCMC,
    N_iter = 1e5,
    temp = 0.01,
    dist_mat = dist_mat
  )
})
timings <- AddTiming(timings, 'TSP: 10 chains', 'lapply()', t_lapply)

t_mc <- system.time({
  mc_out <- mclapply(
    1:10,
    TravelingSalesmanMCMC,
    N_iter = 1e5,
    temp = 0.01,
    dist_mat = dist_mat,
    mc.cores = n_cores
  )
})
timings <- AddTiming(timings, 'TSP: 10 chains', 'mclapply()', t_mc)

t_par <- system.time({
  cl <- makeCluster(n_cores)
  clusterSetRNGStream(cl, 242424)
  # workers are fresh R sessions: they need the helper functions that
  # TravelingSalesmanMCMC() calls
  clusterExport(cl, c('TripDist', 'PermutePath'))
  par_lapply_out <- parLapply(
    cl,
    1:10,
    TravelingSalesmanMCMC,
    N_iter = 1e5,
    temp = 0.01,
    dist_mat = dist_mat
  )
  stopCluster(cl)
})
timings <- AddTiming(timings, 'TSP: 10 chains', 'parLapply()', t_par)


# 10 chains at each of 4 temperatures with clusterMap()

control <- expand.grid(
  chain_id = 1:10,
  temp = c(0.0001, 0.001, 0.01, 0.1),
  N_iter = 1e5
)

t_map <- system.time({
  cl <- makeCluster(n_cores)
  clusterSetRNGStream(cl, 242424)
  clusterExport(cl, c('TripDist', 'PermutePath'))
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
timings <- AddTiming(timings, 'TSP: 40 chains', 'clusterMap()', t_map)


d_out_par <- data.frame()

for (i in 1:nrow(control)) {
  print(par_out[[i]]$best)
  print(par_out[[i]]$best_dist)
  d_out_par <- rbind(d_out_par, par_out[[i]]$dist)
}

# Okabe-Ito only has 9 colors, so we add a tenth for chain 10
chain_colors <- c(unname(okabeito_colors()), '#882255')

ggplot(d_out_par, aes(x = i, y = dist, color = as.factor(chain_id))) +
  geom_line() +
  facet_grid(temp ~ .) +
  scale_color_manual(values = chain_colors) +
  labs(color = 'chain') +
  theme_bw()

ggsave('parallel-02.png', height = 9, width = 8)


#####################
# parallel bootstrap #
#####################

d <- data.frame(
  x1 = rnorm(1e3),
  x2 = rnorm(1e3),
  x3 = rnorm(1e3)
)

d$y <- -2 + 0.3 * d$x1 - 7 * d$x2 * d$x3 + rnorm(1e3)

m <- lm(y ~ x1 * x2 * x3, d)
summary(m)

coef(m)
est_real <- unname(coef(m)['x2:x3'])

boot <- function(rep, data) {
  idx <- sample(nrow(data), replace = TRUE)
  m <- lm(y ~ x1 * x2 * x3, data[idx, ])
  data.frame(rep = rep, est = unname(coef(m)['x2:x3']))
}

B <- 1e4

t_boot_serial <- system.time({
  boot_out <- lapply(1:B, boot, data = d)
  boot_out <- do.call('rbind', boot_out)
})
timings <- AddTiming(timings, 'Bootstrap: 10,000 reps', 'lapply()', t_boot_serial)

t_boot_par <- system.time({
  cl <- makeCluster(n_cores)
  clusterSetRNGStream(cl, 242424)
  # nothing to export: boot() and d are sent along as arguments
  par_boot_out <- parLapply(cl, 1:B, boot, data = d)
  stopCluster(cl)
  par_boot_out <- do.call('rbind', par_boot_out)
})
timings <- AddTiming(timings, 'Bootstrap: 10,000 reps', 'parLapply()', t_boot_par)

# same answer either way: compare the two bootstrap distributions

d_boot <- rbind(
  data.frame(method = 'lapply()', est = boot_out$est),
  data.frame(method = 'parLapply()', est = par_boot_out$est)
)

ggplot(d_boot, aes(x = est, fill = method)) +
  geom_histogram(bins = 50, alpha = 0.5) +
  geom_vline(xintercept = est_real, linetype = 'dashed') +
  facet_grid(method ~ .) +
  scale_fill_okabeito() +
  labs(x = 'bootstrap estimates of the x2:x3 coefficient') +
  theme_bw()

ggsave('parallel-03.png', height = 9, width = 8)


# how much faster was each parallel version?

timings$speedup <- NA
for (task in unique(timings$task)) {
  serial <- timings$seconds[timings$task == task][1]
  timings$speedup[timings$task == task] <- serial / timings$seconds[timings$task == task]
}
timings
