library(tidyverse)
library(see)

setwd('~/projects/lecture-slides/slides/statcomp-lect-11/public/')

set.seed(242424)

# visualizing uncertainty in mean estimates

Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

for (i in seq_along(Ns)) {
  N <- Ns[i]
  means[[i]] <- vector(length = M)
  for (j in 1:M) {
    means[[i]][j] <- mean(rnorm(N))
  }
}

d_mean <- data.frame(n = rep(Ns, each = M), mean = do.call(c, means))

ggplot(d_mean, aes(x = n, y = mean, group = n)) +
  geom_boxplot(alpha = 0.5, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('apply-01.png', height = 9, width = 8)


# Estimating Uncertainty

sds <- vector(length = length(Ns))

for (i in 1:length(Ns)) {
  sds[i] <- sd(means[[i]])
}

d_sd <- data.frame(n = Ns, sd = sds)

ggplot(d_sd, aes(x = n, y = sd)) +
  geom_point(color = okabeito_colors(2)) +
  geom_line(color = okabeito_colors(2)) +
  theme_bw()

ggsave('apply-02.png', height = 9, width = 8)


# Let's create a function for one replication of the simulation

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

n <- rep(Ns, each = M)

d_mean_apply <- data.frame(n = n, mean = sapply(n, SimFun1))

ggplot(d_mean_apply, aes(x = n, y = mean, group = n)) +
  geom_boxplot(alpha = 0.5, fill = okabeito_colors(3)) +
  theme_bw()

ggsave('apply-03.png', height = 9, width = 8)


# second simulation!

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), nrow = n_draws, ncol = n_reps)
  means <- apply(draws, 2, mean)
  sdev <- sd(means)
  return(sdev)
}

sim_control_2 <- data.frame(n_draws = Ns, n_reps = M)

sim_control_2$sd <- mapply(SimFun2, sim_control_2$n_draws, sim_control_2$n_reps)


ggplot(sim_control_2, aes(x = n_draws, y = sd)) +
  geom_point(color = okabeito_colors(2)) +
  geom_line(color = okabeito_colors(2)) +
  theme_bw()

ggsave('apply-04.png', height = 9, width = 8)


# expanded more!

distributions <- c('rnorm', 'runif', 'rexp')

sim_control_3 <- data.frame(
  n_draws = rep(Ns, times = length(distributions)),
  n_reps = M,
  distribution = rep(distributions, each = length(Ns))
)

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(draws, 2, mean)
  sdev <- sd(means)
  return(sdev)
}

sim_control_3$sd <- mapply(
  SimFun3,
  sim_control_3$n_draws,
  sim_control_3$n_reps,
  sim_control_3$distribution
)

ggplot(sim_control_3, aes(x = n_draws, y = sd, color = distribution)) +
  geom_point() +
  geom_line() +
  scale_color_okabeito() +
  theme_bw()

ggsave('apply-05.png', height = 9, width = 8)


# Expanded simulation with data frame output

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(draws, 2, mean))
  return(out)
}

out <- mapply(
  SimFun4,
  sim_control_3$n_draws,
  sim_control_3$n_reps,
  sim_control_3$distribution,
  SIMPLIFY = FALSE
)

d_sim_4 <- do.call('rbind', out)

ggplot(d_sim_4, aes(x = n, y = mean, group = n, fill = dist)) +
  geom_boxplot(alpha = 0.5) +
  facet_grid(. ~ dist) +
  scale_fill_okabeito() +
  theme_bw()

ggsave('apply-06.png', height = 9, width = 16)

# make a control dataframe that varies the number of replications - do your
# results seem to change?
