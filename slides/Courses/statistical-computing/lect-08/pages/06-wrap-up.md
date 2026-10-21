---
level: 1
layout: section
transition: fade
---

# Wrap Up

---
level: 2
---

# Recap

- Regularization puts a penalty on the likelihood proportional to the length of the parameter vector
    - This shrinks parameters toward zero, trading a little bias for a lot less variance
    - Ridge regression shrinks them toward zero, but not exactly to zero
    - LASSO regression tends to force parameters to be zero
- Resampling is a way to estimate things that are difficult to know analytically
    - The jackknife drops single observations to create new datasets of approximately the same size
    - The bootstrap resamples _with replacement_ to create new datasets the same size as your old data
    - There's more than one bootstrap CI: the quantile interval uses the bootstrap quantiles directly, while the empirical interval flips them around $\hat{\theta}$
- Regularization and the bootstrap are probably the two most generalizable applied techniques you'll learn here!

