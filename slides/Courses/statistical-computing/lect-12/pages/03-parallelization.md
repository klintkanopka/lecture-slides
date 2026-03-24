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
- Some computations don’t!
  - Bootstrap replications are a great example of this!
  - If they’re really easy to separate, we call them _embarrassingly parallel_
- Some computations can be parallelized (or partially parallelized) with some work
  - Map-Reduce is a great example of this!


---
level: 3
---

# What is Parallel Computing?

- Parallel computing refers to engaging multiple compute cores in a task simultaneously
- Computers with multiple cores and multiple processors can do multiple things at once
- Modern computers often have high core counts (my Macbook Air has eight, my desktop at home has 24!)
- Graphical processing units (GPUs) are purpose built for parallel matrix multiplication operations
- Parallel computing engages more resources in a task, so computation happens simultaneously
- Parallel computing also allocates memory resources to tasks, so there are fewer costs with moving things around and accessing slower memory

---
level: 3
---

# What about Vectorization?

- Vectorized code takes advantage of _implicit parallelization_
- An example of single instruction, multiple data (SIMD) computation
- At the compiler level, the computer knows how to interact with the scheduler to divide up this work across multiple cores and/or threads
- This is why vectorized computation is so much faster: It's parallel by default!

---
level: 3
---

# Implementation in `R`

- We'll use the `parallel` package
  - Built into `R` and a combination of two old packages: `snow` and `multicore`
  - The core idea is this: if you can modify your code to use an `apply()` function to solve your problem, you can parallelize for almost no additional cost
- Other options for parallelization in `R` exist
  - The `doParallel` and `foreach` package work together in ways I find to be really silly
  - The `future` package is another option for parallelization


---
level: 3
---

# Workflows

## Option 1: `mc` versions of `apply()` functions

- Replace your `apply()` function with an `mc` prefixed version:
  - `lapply()` becomes `mclapply()`
  - `mapply()` becomes `mcmapply()`
- Specify the number of cores you want to use in the `mc.cores = ` argument
- Note that this _forks_ processes and can cause huge problems in any GUI-based programs 
- May also behave badly on some operating systems

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
- This may behave badly on other operating systems

---
level: 3
---

# Load-Balancing

- There are also load-balanced versions like `parLapplyLB()` and `clusterMap()` has a dynamic scheduling option
- Normal versions use _static_ scheduling, where work is divided among cores before starting
- Load-balanced versions use _dynamic_ scheduling, assigning tasks to cores as other tasks finish
- In most small to medium sized tasks, normal versions are more efficient
- Load-balancing is most effective when individual jobs have wildly different runtimes
