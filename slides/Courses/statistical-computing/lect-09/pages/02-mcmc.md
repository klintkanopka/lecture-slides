---
level: 1
layout: section
---

# Markov Chain Monte Carlo

---
level: 3
---

# Markov Chain Monte Carlo (MCMC)

- A super clever algorithm that fits somewhere between direct numerical optimization and just guessing random answers
- Conceptually really kind of weird, but practically pretty straightforward
- **Core idea:** We define a random walk across our search space that places higher probability of landing on “good” answers than “bad” answers. Then we take the walk for a while and find our answer from the places we go  

---
level: 2
---

# Random Walks

- A process that describes a succession of random steps on some mathematical space
- Imagine a new way to pick a restaurant:
  1. Stand outside your apartment and flip a coin twice
    - If you get H,H, you walk one block north
    - If you get H,T, you walk one block south
    - If you get T,H you walk one block east
    - If you get T,T you walk one block west
  2. Repeat this a whole bunch of times
  3. After some number of steps, eat at the first restaurant you pass
- Sometimes called a “drunkard’s walk”

---
level: 2
---

# Markov Chains

- A Markov process is defined by two parts:
  1. A set of states
  2. A transition function that dictates the probability of moving from one state to any other
- Markov processes are “memoryless”
  - Predicting the next state relies only on the current state, not anything before!
  - Called the “Markov Property” 
  - Sampling from a Markov process is a sequential process
- A Markov chain is a type of Markov process
  - Nobody really agrees on the exact definition
  - This doesn’t really matter
  
---
level: 3
---

# The Stationary Distribution

- **The Fundamental Theorem of Markov Chains**: Consider a Markov Chain that satisfies the following two conditions
  1. For all pairs of states $s_i, s_j$, it is possible to eventually get to state $s_j$ if you start at $s_i$ 
  2. The chain is _aperiodic_ (satisfied if there are no directed cycles and the states aren’t bipartite)
- As the number of samples from the chain grows large, the probability of being in any particular state converges to a _stationary distribution_ and this distribution is independent of time and starting state

---
level: 3
---

# Getting Sick as a Markov Chain

- Two states: Healthy (H) and Sick (S)
- Transition Probabilities:
  - $P(H,H)=0.9$
  - $P(H,S)=0.1$
  - $P(S,H)=0.4$
  - $P(S,S)=0.6$
  
$$T(S_1,S_2)=\begin{bmatrix} 0.9 & 0.1 \\ 0.4 & 0.6 \end{bmatrix}$$

---
level: 3
layout: image
image: /sick.png
---

# Getting Sick as a Markov Chain


---
level: 3
---

# Taking the Walk

- If we want to know what percentage of the time we can expect to be sick, we just start somewhere and take the random walk
- If we sample from the Markov Chain for a while, eventually we converge to the stationary distribution
- The proportion of time we spend in each state is the proportion of time we expect to be in that state given the Markov Chain
- Also gives the probability a random observation is in that location
- Another approach is _power iteration_
  1. Pick some random state vector to start (doesn’t matter where you start!)
  2. Multiply by the transition matrix a bunch of times
  3. The state vector converges to the stationary distribution

---
level: 2
---

# Google PageRank

- Google is Google because of PageRank
- **Core idea**: Important and relevant webpages have incoming links from important and relevant webpages
- **How to estimate**: Take a random walk through websites and see what sites are visited the most often
- **Core problem**: It’s not possible to reach every possible website from every possible starting location---so it doesn’t satisfy the fundamental theorem of Markov Chains!
- **Solution**: Teleportation! With some random chance, instead of clicking a link, teleport to a random website
- You’ll implement this on a smallish graph in the homework

---
level: 3
---

# MCMC Problem Solving Process

1. Define your state space
2. Define the transition function
  - Be sure it can (eventually) make it to every possible state
  - Be sure it is aperiodic (no directed loops)
3. Start somewhere and sample from your Markov Chain a bunch of times
4. Throw away the samples in the beginning (burn-in)
5. Look at what’s left


Today’s approach will be a slightly simplified version of the Metropolis-Hastings algorithm, which will show up a lot in Bayesian inference, but it’s not the only way to MCMC!

---
level: 3
---

# Back to Dogs

- We have a pretty easy to optimize function, so MCMC is way less efficient than solutions we already know
- Who cares, let’s do it anyway


---
level: 3
---

# Setting Up

````md magic-move
```r
# First, we optimize the same loss function:

HotDogsDogs <- function(par){
  x <- par[1]
  y <- par[2]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}
```
```r
# First, we optimize the same loss function:

HotDogsDogs <- function(par){
  x <- par[1]
  y <- par[2]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}

# Next, we propose new parameters:

ProposeParams <- function(params){
  return(new_params)
}
```
```r
# First, we optimize the same loss function:

HotDogsDogs <- function(par){
  x <- par[1]
  y <- par[2]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}

# Next, we propose new parameters:

ProposeParams <- function(params){
  new_params <- params
  return(new_params)
}
```
```r
# First, we optimize the same loss function:

HotDogsDogs <- function(par){
  x <- par[1]
  y <- par[2]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}

# Next, we propose new parameters:

ProposeParams <- function(params){
  new_params <- params + rnorm(2, mean=0)
  return(new_params)
}
```
```r
# First, we optimize the same loss function:

HotDogsDogs <- function(par){
  x <- par[1]
  y <- par[2]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}

# Next, we propose new parameters:

ProposeParams <- function(params, lambda){
  new_params <- params + rnorm(2, mean=0, sd=lambda)
  return(new_params)
}
```
````

---
level: 2
---

# Dogs with MCMC

````md magic-move
```r
params <- rep(0,2)
```
```r
params <- rep(0,2)

new_params <- ProposeParams(params, lambda)
```
```r
params <- rep(0,2)

lambda <- 1e-3

new_params <- ProposeParams(params, lambda)
```
```r
params <- rep(0,2)

lambda <- 1e-3

new_params <- ProposeParams(params, lambda)
if (HotDogsDogs(new_params) > HotDogsDogs(params)){
  params <- new_params
}
```
```r
params <- rep(0,2)
best <- params

lambda <- 1e-3

new_params <- ProposeParams(params, lambda)
if (HotDogsDogs(new_params) > HotDogsDogs(params)){
  params <- new_params
}
```
```r
params <- rep(0,2)
best <- params

lambda <- 1e-3

new_params <- ProposeParams(params, lambda)
if (HotDogsDogs(new_params) > HotDogsDogs(params)){
  params <- new_params
}
if (HotDogsDogs(params) > HotDogsDogs(best)){
  best <- params
}
```
```r
params <- rep(0,2)
best <- params

lambda <- 1e-3

for (i in 1:N_iter){
  new_params <- ProposeParams(params, lambda)
  if (HotDogsDogs(new_params) > HotDogsDogs(params)){
    params <- new_params
  }
  if (HotDogsDogs(params) > HotDogsDogs(best)){
    best <- params
  }
}
```
```r
N_iter <- 5e4

params <- rep(0,2)
best <- params

lambda <- 1e-3

for (i in 1:N_iter){
  new_params <- ProposeParams(params, lambda)
  if (HotDogsDogs(new_params) > HotDogsDogs(params)){
    params <- new_params
  }
  if (HotDogsDogs(params) > HotDogsDogs(best)){
    best <- params
  }
}
```
```r
N_iter <- 5e4

revenue <- vector('numeric', length=N_iter)
params <- rep(0,2)
best <- params

param_history <- matrix(NA, nrow=N_iter, ncol=1+length(params))

lambda <- 1e-3

for (i in 1:N_iter){
  new_params <- ProposeParams(params, lambda)
  if (HotDogsDogs(new_params) > HotDogsDogs(params)){
    params <- new_params
  }
  if (HotDogsDogs(params) > HotDogsDogs(best)){
    best <- params
  }
}
```
```r
N_iter <- 5e4

revenue <- vector('numeric', length=N_iter)
params <- rep(0,2)
best <- params

param_history <- matrix(NA, nrow=N_iter, ncol=1+length(params))

lambda <- 1e-3

for (i in 1:N_iter){
  new_params <- ProposeParams(params, lambda)
  if (HotDogsDogs(new_params) > HotDogsDogs(params)){
    params <- new_params
  }
  if (HotDogsDogs(params) > HotDogsDogs(best)){
    best <- params
  }
  param_history[i,] <- c(i, params)
  revenue[i] <- HotDogsDogs(params)
}
```
```r
N_iter <- 5e4

revenue <- vector('numeric', length=N_iter)
params <- rep(0,2)
best <- params

param_history <- matrix(NA, nrow=N_iter, ncol=1+length(params))

lambda <- 1e-3
temp <- 0.025

for (i in 1:N_iter){
  new_params <- ProposeParams(params, lambda)
  if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < temp){
    params <- new_params
  }
  if (HotDogsDogs(params) > HotDogsDogs(best)){
    best <- params
  }
  param_history[i,] <- c(i, params)
  revenue[i] <- HotDogsDogs(params)
}
```
````

---
level: 3
layout: image-right
image: /mcmc-01.png
---

# MCMC Results

```r
conv <- data.frame(
  i = 1:N_iter, 
  revenue=revenue
)

ggplot(conv, aes(x=i, y=revenue)) +
  geom_line(color=okabeito_colors(2)) +
  labs(x='iteration', y='revenue') +
  theme_bw()
  
```


---
level: 3
layout: image-right
image: /mcmc-02.png
---

# MCMC Results

```r
param_history <- data.frame(param_history)
names(param_history) <- c('i', 'x', 'y')

param_history |>
  pivot_longer(-i, names_to='param') |>
  ggplot(aes(x=i, y=value, color=param)) +
  geom_line() +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mcmc-03.png
---

# MCMC Results

```r
param_history |>
  pivot_longer(-i, names_to='param') |>
  filter(i >= 35000) |>
  filter(param=='x') |>
  ggplot(aes(x=value, 
             color=param, 
            fill=param)) +
  geom_histogram(alpha=0.3, bins=100) +
  scale_color_okabeito() +
  scale_fill_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mcmc-04.png
---

# MCMC Results

```r
param_history |>
  pivot_longer(-i, names_to='param') |>
  filter(i >= 35000) |>
  filter(param=='y') |>
  ggplot(aes(x=value, 
             color=param, 
             fill=param)) +
  geom_histogram(alpha=0.3, bins=100) +
  scale_color_okabeito() +
  theme_bw()

colMeans(param_history[35000:N_iter, 2:3])

#        x        y 
# 2.999987 6.000010 

best

# [1] 3.000002 6.000000

```

---
level: 3
---

# What About Temperature?

````md magic-move
```r
N_iter <- 5e4

revenue <- vector('numeric', length=N_iter)
params <- rep(0,2)
best <- params

param_history <- matrix(NA, nrow=N_iter, ncol=1+length(params))

lambda <- 1e-3
temp <- 0.025

for (i in 1:N_iter){
  new_params <- ProposeParams(params, lambda)
  if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < temp){
    params <- new_params
  }
  if (HotDogsDogs(params) > HotDogsDogs(best)){
    best <- params
  }
  param_history[i,] <- c(i, params)
  revenue[i] <- HotDogsDogs(params)
}
```
```r
N_iter <- 5e4
lambda <- 1e-3
Ts <- seq(from=0, to=1, by=0.25)

revenue <- vector('numeric', length=N_iter)
params <- rep(0,2)
best <- params

param_history <- matrix(NA, nrow=N_iter, ncol=1+length(params))


for (i in 1:N_iter){
  new_params <- ProposeParams(params, lambda)
  if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < temp){
    params <- new_params
  }
  if (HotDogsDogs(params) > HotDogsDogs(best)){
    best <- params
  }
  param_history[i,] <- c(i, params)
  revenue[i] <- HotDogsDogs(params)
}
```
```r
N_iter <- 5e4
lambda <- 1e-3
Ts <- seq(from=0, to=1, by=0.25)

for (j in seq_along(Ts)){
  revenue <- vector('numeric', length=N_iter)
  params <- rep(0,2)
  best <- params

  param_history <- matrix(NA, nrow=N_iter, ncol=1+length(params))


  for (i in 1:N_iter){
    new_params <- ProposeParams(params, lambda)
    if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < temp){
      params <- new_params
    }
    if (HotDogsDogs(params) > HotDogsDogs(best)){
      best <- params
    }
    param_history[i,] <- c(i, params)
    revenue[i] <- HotDogsDogs(params)
  }
}
```
```r
N_iter <- 5e4
lambda <- 1e-3
Ts <- seq(from=0, to=1, by=0.25)
conv <- best <- T_param_history <- vector('list', length=length(Ts))

for (j in seq_along(Ts)){
  revenue <- vector('numeric', length=N_iter)
  params <- rep(0,2)
  best <- params
  param_history <- matrix(NA, nrow=N_iter, ncol=1+length(params))
  for (i in 1:N_iter){
    new_params <- ProposeParams(params, lambda)
    if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < temp){
      params <- new_params
    }
    if (HotDogsDogs(params) > HotDogsDogs(best)){
      best <- params
    }
    param_history[i,] <- c(i, params)
    revenue[i] <- HotDogsDogs(params)
  }
}
```
```r
N_iter <- 5e4
lambda <- 1e-3
Ts <- seq(from=0, to=1, by=0.25)
conv <- best <- T_param_history <- vector('list', length=length(Ts))

for (j in seq_along(Ts)){
  revenue <- vector('numeric', length=N_iter)
  params <- rep(0,2)
  best[[j]] <- params
  param_history <- matrix(NA, nrow=N_iter, ncol=1+length(params))
  for (i in 1:N_iter){
    new_params <- ProposeParams(params, lambda)
    if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < temp){
      params <- new_params
    }
    if (HotDogsDogs(params) > HotDogsDogs(best[[j]])){
      best[[j]] <- params
    }
    param_history[i,] <- c(i, params)
    revenue[i] <- HotDogsDogs(params)
  }
}
```
```r
N_iter <- 5e4
lambda <- 1e-3
Ts <- seq(from=0, to=1, by=0.25)
conv <- best <- T_param_history <- vector('list', length=length(Ts))

for (j in seq_along(Ts)){
  revenue <- vector('numeric', length=N_iter)
  params <- rep(0,2)
  best[[j]] <- params
  param_history <- matrix(NA, nrow=N_iter, ncol=1+length(params))
  for (i in 1:N_iter){
    new_params <- ProposeParams(params, lambda)
    if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < Ts[j]){
      params <- new_params
    }
    if (HotDogsDogs(params) > HotDogsDogs(best[[j]])){
      best[[j]] <- params
    }
    param_history[i,] <- c(i, params)
    revenue[i] <- HotDogsDogs(params)
  }
}
```
```r
N_iter <- 5e4
lambda <- 1e-3
Ts <- seq(from=0, to=1, by=0.25)
conv <- best <- T_param_history <- vector('list', length=length(Ts))

for (j in seq_along(Ts)){
  revenue <- vector('numeric', length=N_iter)
  params <- rep(0,2)
  best[[j]] <- params
  param_history_tmp <- matrix(NA, nrow=N_iter, ncol=2+length(params))
  for (i in 1:N_iter){
    new_params <- ProposeParams(params, lambda)
    if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < Ts[j]){
      params <- new_params
    }
    if (HotDogsDogs(params) > HotDogsDogs(best[[j]])){
      best[[j]] <- params
    }
    param_history[i,] <- c(i, params)
    revenue[i] <- HotDogsDogs(params)
  }
}
```
```r
N_iter <- 5e4
lambda <- 1e-3
Ts <- seq(from=0, to=1, by=0.25)
conv <- best <- T_param_history <- vector('list', length=length(Ts))

for (j in seq_along(Ts)){
  revenue <- vector('numeric', length=N_iter)
  params <- rep(0,2)
  best[[j]] <- params
  param_history_tmp <- matrix(NA, nrow=N_iter, ncol=2+length(params))
  for (i in 1:N_iter){
    new_params <- ProposeParams(params, lambda)
    if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < Ts[j]){
      params <- new_params
    }
    if (HotDogsDogs(params) > HotDogsDogs(best[[j]])){
      best[[j]] <- params
    }
    param_history_tmp[i,] <- c(i, Ts[j], params)
    revenue[i] <- HotDogsDogs(params)
  }
}
```
```r
N_iter <- 5e4
lambda <- 1e-3
Ts <- seq(from=0, to=1, by=0.25)
conv <- best <- T_param_history <- vector('list', length=length(Ts))

for (j in seq_along(Ts)){
  revenue <- vector('numeric', length=N_iter)
  params <- rep(0,2)
  best[[j]] <- params
  param_history_tmp <- matrix(NA, nrow=N_iter, ncol=2+length(params))
  for (i in 1:N_iter){
    new_params <- ProposeParams(params, lambda)
    if (HotDogsDogs(new_params) > HotDogsDogs(params) | runif(1) < Ts[j]){
      params <- new_params
    }
    if (HotDogsDogs(params) > HotDogsDogs(best[[j]])){
      best[[j]] <- params
    }
    param_history_tmp[i,] <- c(i, Ts[j], params)
    revenue[i] <- HotDogsDogs(params)
  }
  conv[[j]] <- data.frame(i = 1:N_iter, revenue=revenue, T=Ts[j])
  T_param_history[[j]] <- param_history_tmp
}
```
````

---
level: 3
---

# MCMC Results

```r
conv <- do.call('rbind', conv)
T_param_history <- do.call('rbind', T_param_history)
T_param_history <- data.frame(T_param_history)
names(T_param_history) <- c('i', 'T', 'x', 'y')

best

# [[1]]
# [1] 3.000006 6.000006

# [[2]]
# [1] 2.999985 6.000006

# [[3]]
# [1] 3.000041 6.000000

# [[4]]
# [1] 1.870241 4.682416

# [[5]]
# [1] 0.16900318 0.01831097
```

---
level: 3
layout: image-right
image: /mcmc-05.png
---

# MCMC Results

```r
ggplot(conv, 
       aes(x=i, 
           y=revenue, 
           color=as.character(T))) +
  geom_line() +
  labs(x='iteration', 
       y='revenue', 
       color='temp') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mcmc-06.png
---

# MCMC Results

```r
T_param_history |>
  pivot_longer(c(x,y), 
               names_to='param', 
               values_to='value') |>
  filter(param == 'x') |>
  ggplot(aes(x=i, 
             y=value, 
             color=as.character(T))) +
  geom_line() +
  labs(x='iteration', color='temp') +
  scale_color_okabeito() +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mcmc-07.png
---

# MCMC Results

```r
T_param_history |>
  pivot_longer(c(x,y), 
               names_to='param', 
               values_to='value') |>
  filter(param == 'y') |>
  ggplot(aes(x=i, 
             y=value, 
             color=as.character(T))) +
  geom_line() +
  labs(x='iteration', color='temp') +
  scale_color_okabeito() +
  theme_bw()
```