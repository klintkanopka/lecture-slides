---
level: 1
layout: section
transition: fade
---

# Wrap Up

---
level: 2
hideInToc: true
---

# Recap: Architecture

- Getting data to the processor is usually slower than the arithmetic itself
  - Memory is a hierarchy: registers → caches → RAM → disk, each much slower than the last
  - Neighboring values are cheap to read, which is part of why vectorized code is fast
  - Running out of RAM is a disaster for speed
- The operating system's scheduler shares a few cores among many processes
  - More workers than cores just means taking turns
- One `R` session uses one core; parallel `R` runs several `R` processes
- GPUs have thousands of simple cores and shine on big, uniform matrix arithmetic

---
level: 2
hideInToc: true
---

# Recap: Parallel computing

- Embarrassingly parallel work (bootstrap replications, MCMC chains, simulation conditions) is the easy win
- Amdahl's law: the sequential part limits the speedup, and overhead eats into it further
- Two workflows in the `parallel` package:
  - `mclapply()` / `mcmapply()`: forks, fast to start, but not on Windows or in GUIs
  - `makeCluster()` + `parLapply()` / `clusterMap()`: works everywhere, but export what workers need and always `stopCluster()`
- Use `detectCores() - 1` workers on your own machine, and ask the scheduler on a shared one
- Use `L'Ecuyer-CMRG` streams so parallel random numbers are independent and reproducible
- Load-balancing helps when tasks have very different runtimes

---
level: 2
hideInToc: true
---

# Before you parallelize: a checklist

1. **Is it actually slow?** Time it with `system.time()` and find the slow part
2. **Can you vectorize it?** That's often a bigger win, and it's free
3. **Write one function for one unit of work** (one replication, one chain, one condition)
4. **Run it with `lapply()` / `mapply()` on a small input** and check the results
5. **Swap in the parallel version** and set up random number streams
6. **Time it again** and compare: is the speedup worth the extra complexity?

<v-click>

- If you wrote your code well to begin with (functions + `apply()`), steps 3–5 take minutes!
- Next time: model evaluation and cross-validation, where every fold is another embarrassingly parallel task

</v-click>
