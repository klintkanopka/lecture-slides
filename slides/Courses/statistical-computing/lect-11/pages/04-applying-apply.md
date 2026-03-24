---
level: 2
layout: section
---

# Applying `apply()`

---
level: 3
---

# Uncertainty in mean estimates

- First we conduct a simulation study to observe how the uncertainty in estimating the mean of a normal distribution depends on the number of samples we draw from it

````md magic-move
```r
# TODO
```

```r
Ns <- seq(from = 50, to = 1000, by = 50)

```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

for (i in seq_along(Ns)) {

}
```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

for (i in seq_along(Ns)) {
  for (j in 1:M) {

  }
}
```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

for (i in seq_along(Ns)) {
  means[[i]] <- vector(length = M)
  for (j in 1:M) {

  }
}
```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

for (i in seq_along(Ns)) {
  means[[i]] <- vector(length = M)
  for (j in 1:M) {
    means[[i]][j] <- mean(rnorm(Ns[i]))
  }
}
```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

for (i in seq_along(Ns)) {
  means[[i]] <- vector(length = M)
  for (j in 1:M) {
    means[[i]][j] <- mean(rnorm(Ns[i]))
  }
}

d_mean <- data.frame()
```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

for (i in seq_along(Ns)) {
  means[[i]] <- vector(length = M)
  for (j in 1:M) {
    means[[i]][j] <- mean(rnorm(Ns[i]))
  }
}

d_mean <- data.frame(n = , mean = )
```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

for (i in seq_along(Ns)) {
  means[[i]] <- vector(length = M)
  for (j in 1:M) {
    means[[i]][j] <- mean(rnorm(Ns[i]))
  }
}

d_mean <- data.frame(n = , mean = do.call(c, means))
```
```r
Ns <- seq(from = 50, to = 1000, by = 50)
M <- 1000
means <- list(length = length(Ns))

for (i in seq_along(Ns)) {
  means[[i]] <- vector(length = M)
  for (j in 1:M) {
    means[[i]][j] <- mean(rnorm(Ns[i]))
  }
}

d_mean <- data.frame(n = rep(Ns, each = M), mean = do.call(c, means))
```
````

---
level: 3
layout: image-right
image: /apply-01.png
---

# Visualizing uncertainty in mean estimates

```r
ggplot(d_mean, aes(x = n, 
                   y = mean, 
                   group = n)) +
  geom_boxplot(alpha = 0.5, 
               fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
---

# Estimating uncertainty directly

- Next we visualize our estimates of the standard errors of these sampling distributions at each sample size

````md magic-move
```r
# TODO
```
```r
sds <- vector(length = length(Ns))
```
```r
sds <- vector(length = length(Ns))

for (i in seq_along(Ns)) {

}
```
```r
sds <- vector(length = length(Ns))

for (i in seq_along(Ns)) {
  sds[i] <- sd(means[[i]])
}
```
```r
sds <- vector(length = length(Ns))

for (i in seq_along(Ns)) {
  sds[i] <- sd(means[[i]])
}

d_sd <- data.frame()
```
```r
sds <- vector(length = length(Ns))

for (i in seq_along(Ns)) {
  sds[i] <- sd(means[[i]])
}

d_sd <- data.frame(n = , sd = )
```
```r
sds <- vector(length = length(Ns))

for (i in seq_along(Ns)) {
  sds[i] <- sd(means[[i]])
}

d_sd <- data.frame(n = , sd = sds)
```
```r
sds <- vector(length = length(Ns))

for (i in seq_along(Ns)) {
  sds[i] <- sd(means[[i]])
}

d_sd <- data.frame(n = Ns, sd = sds)
```
````

---
level: 3
layout: image-right
image: /apply-02.png
---

# Visualizing uncertainty estimates

```r

ggplot(d_sd, aes(x = n, y = sd)) +
  geom_point(color = okabeito_colors(2)) +
  geom_line(color = okabeito_colors(2)) +
  theme_bw()
```

---
level: 3
---


# Uncertainty in mean estimates with `apply()`

- Now we redo the first simulation with something from the `apply()` family

````md magic-move
```r
# TODO: Write a simulation function

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun1 <- function() {

}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```

```r
# TODO: Write a simulation function

SimFun1 <- function() {
  return(m)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  return(m)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

# TODO: Construct the object to apply() over

n <- rep(Ns, each = M)

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

# TODO: Construct the object to apply() over

n <- rep(Ns, each = M)

# TODO: Construct the output

d_mean_apply <- data.frame()
```
```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

# TODO: Construct the object to apply() over

n <- rep(Ns, each = M)

# TODO: Construct the output

d_mean_apply <- data.frame(n = , mean = )
```
```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

# TODO: Construct the object to apply() over

n <- rep(Ns, each = M)

# TODO: Construct the output

d_mean_apply <- data.frame(n = n, mean = )
```
```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

# TODO: Construct the object to apply() over

n <- rep(Ns, each = M)

# TODO: Construct the output

d_mean_apply <- data.frame(n = n, mean = sapply())
```
```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

# TODO: Construct the object to apply() over

n <- rep(Ns, each = M)

# TODO: Construct the output

d_mean_apply <- data.frame(n = n, mean = sapply(X = , FUN = ))
```
```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

# TODO: Construct the object to apply() over

n <- rep(Ns, each = M)

# TODO: Construct the output

d_mean_apply <- data.frame(n = n, mean = sapply(X = , FUN = SimFun1))
```

```r
# TODO: Write a simulation function

SimFun1 <- function(n_draws) {
  draws <- rnorm(n_draws)
  m <- mean(draws)
  return(m)
}

# TODO: Construct the object to apply() over

n <- rep(Ns, each = M)

# TODO: Construct the output

d_mean_apply <- data.frame(n = n, mean = sapply(X = n, FUN = SimFun1))
```
````

---
level: 3
layout: image-right
image: /apply-03.png
---


# Visualizing uncertainty in mean estimates with `apply()`

```r
ggplot(d_mean_apply, aes(x = n, 
                         y = mean, 
                         group = n)) +
  geom_boxplot(alpha = 0.5, 
               fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
---

# Estimating uncertainty directly with `apply()`


````md magic-move
```r
# TODO: Write a simulation function

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function() {

}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function() {
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function() {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = , MARGIN = , FUN = )
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = , MARGIN = , FUN = mean)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = , FUN = mean)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

sim_control_2 <- data.frame()

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

sim_control_2 <- data.frame(n_draws = , n_reps = )

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

sim_control_2 <- data.frame(n_draws = Ns, n_reps = M)

# TODO: Construct the output

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

sim_control_2 <- data.frame(n_draws = Ns, n_reps = M)

# TODO: Construct the output

sim_control_2$sd <- mapply(FUN = , ...)

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

sim_control_2 <- data.frame(n_draws = Ns, n_reps = M)

# TODO: Construct the output

sim_control_2$sd <- mapply(FUN = SimFun2, ...)

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

sim_control_2 <- data.frame(n_draws = Ns, n_reps = M)

# TODO: Construct the output

sim_control_2$sd <- mapply(FUN = SimFun2, 
                           sim_control_2$n_draws,
                           ...)

```
```r

# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

sim_control_2 <- data.frame(n_draws = Ns, n_reps = M)

# TODO: Construct the output

sim_control_2$sd <- mapply(FUN = SimFun2, 
                           sim_control_2$n_draws, 
                           sim_control_2$n_reps)

```
````

---
level: 3
layout: image-right
image: /apply-04.png
---

# Visualizing uncertainty estimates with `apply()`

```r

ggplot(sim_control_2, aes(x = n_draws, 
                          y = sd)) +
  geom_point(color = okabeito_colors(2)) +
  geom_line(color = okabeito_colors(2)) +
  theme_bw()
```

---
level: 3
---

# Extending to more distributions

````md magic-move
```r
# TODO: Write a simulation function

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun2 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- matrix(rnorm(n = n_draws * n_reps), 
                  nrow = n_draws, 
                  ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  # TODO: draw from distribution
  # TODO: reshape into matrix
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  # TODO: draw from distribution
  draws <- do.call()
  # TODO: reshape into matrix
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  # TODO: draw from distribution
  draws <- do.call(what = , args = )
  # TODO: reshape into matrix
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  # TODO: draw from distribution
  draws <- do.call(what = dist, args = )
  # TODO: reshape into matrix
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  # TODO: draw from distribution
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  # TODO: reshape into matrix
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  # TODO: draw from distribution
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  # TODO: reshape into matrix
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

sim_control_3 <- data.frame()

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame()

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame(n_draws = ,
                            n_reps = ,
                            distribution = )

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame(n_draws = rep(Ns, times = length(distributions)),
                            n_reps = ,
                            distribution = )

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame(n_draws = rep(Ns, times = length(distributions)),
                            n_reps = M,
                            distribution = )

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame(n_draws = rep(Ns, times = length(distributions)),
                            n_reps = M,
                            distribution = rep(distributions, each = length(Ns)))

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame(n_draws = rep(Ns, times = length(distributions)),
                            n_reps = M,
                            distribution = rep(distributions, each = length(Ns)))

# TODO: Construct the output

sim_control_3$sd <- mapply(FUN = , ...)
```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame(n_draws = rep(Ns, times = length(distributions)),
                            n_reps = M,
                            distribution = rep(distributions, each = length(Ns)))

# TODO: Construct the output

sim_control_3$sd <- mapply(FUN = SimFun3,
                           ...)
```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame(n_draws = rep(Ns, times = length(distributions)),
                            n_reps = M,
                            distribution = rep(distributions, each = length(Ns)))

# TODO: Construct the output

sim_control_3$sd <- mapply(FUN = SimFun3,
                           sim_control_3$n_draws,
                           ...)
```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame(n_draws = rep(Ns, times = length(distributions)),
                            n_reps = M,
                            distribution = rep(distributions, each = length(Ns)))

# TODO: Construct the output

sim_control_3$sd <- mapply(FUN = SimFun3,
                           sim_control_3$n_draws,
                           sim_control_3$n_reps,
                           ...)
```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the object to apply() over

distributions <- c('rnorm', 'runif', 'rexp')
sim_control_3 <- data.frame(n_draws = rep(Ns, times = length(distributions)),
                            n_reps = M,
                            distribution = rep(distributions, each = length(Ns)))

# TODO: Construct the output

sim_control_3$sd <- mapply(FUN = SimFun3,
                           sim_control_3$n_draws,
                           sim_control_3$n_reps,
                           sim_control_3$distribution)
```
````

---
level: 3
layout: image-right
image: /apply-05.png
---

# Visualizing uncertainty across distributions 

```r
ggplot(sim_control_3, 
       aes(x = n_draws, 
           y = sd, 
           color = distribution)) +
  geom_point() +
  geom_line() +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
--- 

# Constructing more complex data frame output

````md magic-move
```r
# TODO: Write a simulation function

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun3 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  sdev <- sd(means)
  return(sdev)
}

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  out <- data.frame()
  return(out)
}

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  out <- data.frame(n = , dist = , mean = )
  return(out)
}

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  out <- data.frame(n = n_draws, dist = , mean = )
  return(out)
}

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  out <- data.frame(n = n_draws, dist = dist, mean = )
  return(out)
}

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(what = dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  means <- apply(X = draws, MARGIN = 2, FUN = mean)
  out <- data.frame(n = n_draws, dist = dist, mean = means)
  return(out)
}

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(X = draws, MARGIN = 2, FUN = mean))
  return(out)
}

# TODO: Construct the output

```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(X = draws, MARGIN = 2, FUN = mean))
  return(out)
}

# TODO: Construct the output

out <- mapply(FUN = , ...)


```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(X = draws, MARGIN = 2, FUN = mean))
  return(out)
}

# TODO: Construct the output

out <- mapply(
  FUN = SimFun4,
  ...
)


```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(X = draws, MARGIN = 2, FUN = mean))
  return(out)
}

# TODO: Construct the output

out <- mapply(
  FUN = SimFun4,
  sim_control_3$n_draws,
  ...
)


```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(X = draws, MARGIN = 2, FUN = mean))
  return(out)
}

# TODO: Construct the output

out <- mapply(
  FUN = SimFun4,
  sim_control_3$n_draws,
  sim_control_3$n_reps,
  ...
)


```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(X = draws, MARGIN = 2, FUN = mean))
  return(out)
}

# TODO: Construct the output

out <- mapply(
  FUN = SimFun4,
  sim_control_3$n_draws,
  sim_control_3$n_reps,
  sim_control_3$distribution
)


```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(X = draws, MARGIN = 2, FUN = mean))
  return(out)
}

# TODO: Construct the output

out <- mapply(
  FUN = SimFun4,
  sim_control_3$n_draws,
  sim_control_3$n_reps,
  sim_control_3$distribution,
  SIMPLIFY = FALSE
)


```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(X = draws, MARGIN = 2, FUN = mean))
  return(out)
}

# TODO: Construct the output

out <- mapply(
  FUN = SimFun4,
  sim_control_3$n_draws,
  sim_control_3$n_reps,
  sim_control_3$distribution,
  SIMPLIFY = FALSE
)

d_sim_4 <- do.call('rbind', out)

```
```r
# TODO: Write a simulation function

SimFun4 <- function(n_draws, n_reps, dist) {
  draws <- do.call(dist, args = list(n = n_draws * n_reps))
  draws <- matrix(draws, nrow = n_draws, ncol = n_reps)
  out <- data.frame(n = n_draws, dist = dist, mean = apply(X = draws, MARGIN = 2, FUN = mean))
  return(out)
}

# TODO: Construct the output

out <- mapply(FUN = SimFun4,
              sim_control_3$n_draws,
              sim_control_3$n_reps,
              sim_control_3$distribution,
              SIMPLIFY = FALSE)

d_sim_4 <- do.call('rbind', out)

ggplot(d_sim_4, aes(x = n, y = mean, group = n, fill = dist)) +
  geom_boxplot(alpha = 0.5) +
  facet_grid(. ~ dist) +
  scale_fill_okabeito() +
  theme_bw()
```
````

---
level: 3
layout: image
image: /apply-06.png
---

