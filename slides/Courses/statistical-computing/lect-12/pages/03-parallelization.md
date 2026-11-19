---
level: 1
layout: section
---

# Parallel Computing

---
level: 3
---

# Parallelization

- Some computations and tasks depend on previous results
  - We call these sequential computations
  - MCMC is a great example of this!
- Some computations don't!
  - Bootstrap replications are a great example of this!
  - If they're really easy to separate, we call them _embarrassingly parallel_
- Some computations can be parallelized (or partially parallelized) with some work
  - Map-Reduce is a great example of this!


---
level: 3
---

# What is Parallel Computing?

- Parallel computing refers to engaging multiple compute cores in a task simultaneously
- Computers with multiple cores and multiple processors can do multiple things at once
- Modern computers often have high core counts (my MacBook Air has eight, my AMD desktop at home has 24!)
- Graphics processing units (GPUs) are purpose-built for parallel matrix multiplication operations
- Parallel computing engages more resources in a task, so computation happens simultaneously
- Parallelism isn't free: starting workers and copying data to them takes time, so it pays off when each piece of work is big enough to outweigh that overhead

---
level: 3
layout: image-right
image: /amdahl.png
---

# Amdahl's Law

- Only part of a program can run in parallel: setup, combining results, and anything sequential still runs on one core
- If a fraction $p$ of the work is parallel and we use $k$ cores, the best possible speedup is

$$S(k) = \frac{1}{(1 - p) + \frac{p}{k}}$$

- With $p = 0.9$, 8 cores give $S = 4.7$, not 8
  - As $k \rightarrow \infty$, $S \rightarrow 10$
- Overhead makes real speedups smaller still
- Shrink the sequential part sets the ceiling, so it's often worth shrinking that first

---
level: 3
---

# What about Vectorization?

- Vectorized functions in `R` hand the whole vector to compiled C/Fortran code, so the loop runs in fast compiled code instead of in the `R` interpreter
- Inside that compiled code, the processor can also apply one instruction to several values at once: single instruction, multiple data (SIMD)
- This all happens on a _single_ core, and it is the main reason vectorized code is so much faster
- Compare `apply()`: its loop also runs in C, but each step still calls your `R` function, so it's about as fast as a `for` loop
- Some libraries (like an optimized BLAS for matrix algebra) also use multiple cores behind the scenes
- Parallel computing is a different, complementary trick: vectorize first, then parallelize

---
level: 3
---

# Implementation in `R`

- We'll use the `parallel` package
  - Built into `R` and a combination of two old packages: `snow` and `multicore`
  - The core idea is this: if you can modify your code to use an `apply()` function to solve your problem, you can parallelize for almost no additional cost
- Other options for parallelization in `R` exist
  - The `doParallel` and `foreach` packages work together in ways I find to be really silly
  - The `future` package is another option for parallelization

---
level: 3
---

# How many cores do I have?

```r
library(parallel)

detectCores()                  # logical cores (counts hyperthreads)
detectCores(logical = FALSE)   # physical cores

n_cores <- max(1, detectCores() - 1)
```

- Leave at least one core free for the operating system (and for you!)
- More workers than cores doesn't help: they just take turns
- On a shared machine or an HPC cluster, `detectCores()` reports the whole machine, not what you were given
  - Ask the scheduler instead, e.g. `Sys.getenv("SLURM_CPUS_PER_TASK")`, or use `parallelly::availableCores()`

---
level: 3
---

# Workflows

## Option 1: `mc` versions of `apply()` functions

- Replace your `apply()` function with an `mc` prefixed version:
  - `lapply()` becomes `mclapply()`
  - `mapply()` becomes `mcmapply()`
- Specify the number of cores you want to use in the `mc.cores = ` argument
- Note that this _forks_ processes and can cause huge problems in any GUI-based programs (including RStudio)
- Forking doesn't exist on Windows, so there `mc.cores` must be 1 (no parallelism at all)

---
level: 3
---

# Workflows

## Option 2: Create a socket cluster

- Create a local cluster using `makeCluster()`
- Export data and functions to the cluster using `clusterExport()`
- Replace your `apply()` function with a parallelized version
  - `parApply()`, `parLapply()`, `parSapply()` are drop-in replacements
  - I usually use `clusterMap()`, which is like `mapply()` or `Map()`
- Stop the cluster with `stopCluster()` (This is important!)
- Works on every operating system, including Windows
- Each worker is a fresh `R` session: it only knows what you export, and packages must be loaded on it (e.g., with `clusterEvalQ()`)

---
level: 3
---

# Random numbers in parallel

- Every worker draws random numbers, so we need to be careful:
  - Workers must not reuse the same stream, or our "independent" replications aren't
  - We want results to be reproducible
- The `L'Ecuyer-CMRG` generator splits into many independent streams, one per worker

```r
RNGkind("L'Ecuyer-CMRG")
set.seed(242424)          # mclapply() then gives each fork its own stream

cl <- makeCluster(n_cores)
clusterSetRNGStream(cl, 242424)   # same idea for a socket cluster
```

- Reproducible as long as you use the same number of workers

---
level: 3
zoom: 0.8
---

# The traveling salesman, one chain at a time

<div class="grid grid-cols-[3fr_2fr] gap-6">
<div>

```r {all|2-4|7|8-11|12-14|15|18-22}
TravelingSalesmanMCMC <- function(chain_id, N_iter, temp, dist_mat) {
  dist <- vector('numeric', length = N_iter)
  path <- sample(1:nrow(dist_mat))
  best <- path

  for (i in 1:N_iter) {
    new_path <- PermutePath(path)
    if (TripDist(new_path, dist_mat) < TripDist(path, dist_mat) |
        runif(1) < temp) {
      path <- new_path
    }
    if (TripDist(path, dist_mat) < TripDist(best, dist_mat)) {
      best <- path
    }
    dist[i] <- TripDist(path, dist_mat)
  }

  out <- list(best = best,
              best_dist = TripDist(best, dist_mat),
              dist = data.frame(i = 1:N_iter, dist = dist,
                                temp = temp, chain_id = chain_id))
  return(out)
}
```

</div>
<div>

- Back to the traveling salesman!
- Start from a random path through all 50 locations, and remember the best one seen so far
- Each iteration, `PermutePath()` proposes swapping two neighboring stops
- Accept the proposal if it's shorter, or with probability `temp` even if it's longer
- Keep track of the best path and the distance at every iteration
- `TripDist()` and `PermutePath()` are helper functions defined earlier in `lect-12.R`
- `chain_id` isn't used in the computation: it labels the output, and gives `lapply()` something to loop over

</div>
</div>

---
level: 3
layout: image-right
image: /parallel-01.png
---

# One chain

- To run one chain, call:

```
TravelingSalesmanMCMC(chain_id,
                      N_iter,
                      temp,
                      dist_mat)
```

- We plot current distance as a function of iteration

---
level: 3
---

# Example: Ten MCMC chains



- One chain is sequential, but separate chains are embarrassingly parallel

````md magic-move
```r
out <- lapply(1:10,
              TravelingSalesmanMCMC,
              N_iter = 1e5, temp = 0.01, dist_mat = dist_mat)
```
```r
out <- mclapply(1:10,
                TravelingSalesmanMCMC,
                N_iter = 1e5, temp = 0.01, dist_mat = dist_mat,
                mc.cores = n_cores)
```
```r
cl <- makeCluster(n_cores)
clusterSetRNGStream(cl, 242424)
clusterExport(cl, c('TripDist', 'PermutePath'))

out <- parLapply(cl, 1:10,
                 TravelingSalesmanMCMC,
                 N_iter = 1e5, temp = 0.01, dist_mat = dist_mat)

stopCluster(cl)
```
````

- Why export `TripDist()` and `PermutePath()`? `TravelingSalesmanMCMC()` calls them, and the workers start empty

---
level: 3
---

# Example: A grid of settings with `clusterMap()`

- Ten chains at each of four temperatures: 40 runs

```r
control <- expand.grid(chain_id = 1:10,
                       temp = c(0.0001, 0.001, 0.01, 0.1),
                       N_iter = 1e5)

cl <- makeCluster(n_cores)
clusterSetRNGStream(cl, 242424)
clusterExport(cl, c('TripDist', 'PermutePath'))

par_out <- clusterMap(cl, TravelingSalesmanMCMC,
                      chain_id = control$chain_id,
                      N_iter = control$N_iter,
                      temp = control$temp,
                      MoreArgs = list(dist_mat = dist_mat))

stopCluster(cl)
```

- Vectors are matched element by element, like `mapply()`; `MoreArgs` holds what every run shares

---
level: 3
layout: image-right
image: /parallel-02.png
---

# Chains at four temperatures

- Each panel is one temperature: the chance of accepting a worse path
- Too cold (top): chains get stuck early
- Too hot (bottom): chains wander and never settle
- In between, chains keep improving
- 40 runs of 100,000 iterations each, and we only had to write one function

---
level: 3
---

# Example: A parallel bootstrap

```r
boot <- function(rep, data) {
  idx <- sample(nrow(data), replace = TRUE)
  m <- lm(y ~ x1 * x2 * x3, data[idx, ])
  data.frame(rep = rep, est = unname(coef(m)['x2:x3']))
}

B <- 1e4

boot_serial <- do.call('rbind', lapply(1:B, boot, data = d))

cl <- makeCluster(n_cores)
clusterSetRNGStream(cl, 242424)
boot_par <- do.call('rbind', parLapply(cl, 1:B, boot, data = d))
stopCluster(cl)
```

- We simulated data in a dataframe `d` where the true `x2:x3` coefficient is $-7$
- Nothing to export: `boot()` and `d` travel to the workers as arguments

---
level: 3
layout: image-right
image: /parallel-03.png
---

# Bootstrap results

- Recall the true `x2:x3` coefficient is $-7$
- Each panel is the bootstrap distribution of that estimate, 10,000 replications each
- The dashed line is the estimate from the full sample
- The serial and parallel versions give the same distribution
  - The individual draws differ, because the workers use different random number streams
- Same answer, about $2.5\times$ faster

---
level: 3
zoom: 0.8
---

# How much faster?

<!-- Measured 2026-11-18 on an M2 MacBook Air (4 performance + 4 efficiency cores), 7 workers -->

| **Task**                      | **Method**    | **Time (s)** | **Speedup** |
|-------------------------------|---------------|------------:|------------:|
| Traveling Salesman: 10 chains | `lapply()`    | 34.2        | 1.0         |
| Traveling Salesman: 10 chains | `mclapply()`  | 14.7        | 2.3         |
| Traveling Salesman: 10 chains | `parLapply()` | 16.5        | 2.1         |
| Bootstrap: 10,000 reps        | `lapply()`    | 11.2        | 1.0         |
| Bootstrap: 10,000 reps        | `parLapply()` | 4.4         | 2.5         |

- 7 workers, but nowhere near 7 times faster. Why not?
  - 10 chains on 7 workers takes two rounds, so the best case is $10 / 2 = 5\times$
  - My laptop has 4 fast "performance" cores and 4 slow "efficiency" cores, and we wait for the slowest worker
  - Starting workers and sending data is sequential overhead (Amdahl!)
  - `mclapply()` beats `parLapply()` here: forking skips copying data to fresh sessions

---
level: 3
---

# Load-Balancing

- There are also load-balanced versions like `parLapplyLB()`, and `clusterMap()` has a dynamic scheduling option (`.scheduling = "dynamic"`)
- Normal versions use _static_ scheduling, where work is divided among cores before starting
- Load-balanced versions use _dynamic_ scheduling, assigning tasks to cores as other tasks finish
- In most small to medium sized tasks, normal versions are more efficient
- Load-balancing is most effective when individual jobs have wildly different runtimes
