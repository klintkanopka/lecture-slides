---
level: 1
layout: section
---

# Cross Validation

---
level: 3
hideInToc: true
---

# Cross Validation

- Big idea: What if, instead of holding out your dev set, you divide your train set into chunks, and use those chunks to make your modeling decisions?
- This is worse than holding out a dev set, but _much_ better than not using a dev set at all!
- Once you've made your modeling decision based upon the cross validated (CV) performance, you fit a final model using those parameters on your training set and then test
- If there are no modeling decisions, you can also use CV instead of a test set
  - This is worse than using a test set
  - Only provides an estimate of OOS performance
  - Might be your best bet in low data situations

---
level: 2
---

# $k$-Fold Cross Validation in Practice

1. Divide your training set into $k$ buckets, called _folds_ (5 or 10 are commonly used)
2. For each fold, $i \in \{1, \ldots, k\}$:
  - Fit the model to the data **not** in fold $i$
  - Use the model to predict outcomes for the data in fold $i$
3. Evaluate performance on these CV predictions
4. Fit a model to the entire training set
5. Test performance

---
level: 2
---

# Selecting $k$ and Tradeoffs

- Higher values of $k$ put fewer observations into each test fold, and more observations into each model
- This requires fitting $k+1$ models, however! If model fitting is slow, you want to balance that in your selection of $k$
- If you have $N$ observations, what happens if $k=N$?
  - This is called _Leave One Out Cross Validation (LOO-CV)_
  - Each model is fit on $N-1$ data points to predict an outcome for $1$ observation
  - Requires fitting $N$ models
- **In the final Problem Set, you'll implement parallelized LOO-CV!**

---
level: 2
layout: section
---

# Implementing Cross Validation

## Data and code available [here](https://github.com/klintkanopka/lecture-slides/tree/main/slides/statcomp-lect-13/public)
