---
level: 1
layout: section
---

# Evaluation Theory

---
level: 2
---

# Model Evaluation

<v-clicks depth="2">

- How do we know that we have a model that's any good?
- There exists a litany of retrospective fit statistics, metrics, and statistical tests
  - These are sometimes specific to certain types of models
  - These are often not comparable between model types or across datasets
  - These all have one killer flaw, however

</v-clicks>

---
level: 3
---

# Model Evaluation

<v-clicks depth="2">


- The fatal flaw of traditional model evaluation is that it only uses the data in hand and tells you nothing about if your model will generalize to new data or is overfitting to the data you used to fit it
- When fitting models, we typically only have the data in hand and the common wisdom is to use as much of it as humanly possible!
- Implementing one of these evaluation schemes requires splitting up the data you have, so you don't use all of it to fit models. We call these _sets_

</v-clicks>

---
level: 2
---

# Data Splitting

<v-clicks depth="2">


- The _training set_ is the set of data points used to fit the model. This should **always** be your largest subset of data
- The _testing set_ (or _test set_ or _holdout set_) is the set of data points used to make your final evaluation
  - The model fit on the training set makes new predictions for the OOS data in the testing set
  - Then you compute some fit metric (like MSE or accuracy)
  - The test set should be as small as possible while still giving you a sample of points to evaluate on
  - If you have model parameters to tune, like regularization parameters or decisions between which model to use, you can't make that selection based on test set performance, because then it becomes in sample data!
- The _validation set_ (or _eval set_, _development set_, or _dev set_) is not used to train the model, but used to pick the best values for user-tunable parameters
  - Things like learning rates in gradient descent, or amounts of regularization, or balance between LASSO and Ridge regularization
  - Should be the same size as your test set

</v-clicks>


---
level: 3
---

# In Practice

<v-clicks depth="2">

- The gold standard when you don't have any tunable model parameters is a train/test split, often 80\% of data in the training set and 20\% in the testing set (called an 80/20 split)
  - If you have a huge amount of data, you can push this to a 90/10 split or even smaller for the test set
- If you have tunable model parameters or modeling decisions, the gold standard is a train/dev/test split
  - Often this is 80/10/10
- The problem is that you want to have as much data as possible inside your model
  - This is especially true of more flexible machine learning models!
- There is another way...

</v-clicks>

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

<v-clicks depth="2">

- Big idea: What if, instead of holding out your dev set, you divide your train set into chunks, and use those chunks to make your modeling decisions?
- This is worse than holding out a dev set, but _much_ better than not using a dev set at all!
- Once you've made your modeling decision based upon the cross validated (CV) performance, you fit a final model using those parameters on your training set and then test
- If there are no modeling decisions, you can also use CV instead of a test set
  - This is worse than using a test set
  - Only provides an estimate of OOS performance
  - Might be your best bet in low data situations

</v-clicks>

---
level: 2
---

# $k$-Fold Cross Validation in Practice

<v-clicks depth="2">

1. Divide your training set into $k$ buckets, called _folds_ (5 or 10 are commonly used)
2. For each fold, $i \in \{1, \ldots, k\}$:
  - Fit the model to the data **not** in fold $i$
  - Use the model to predict outcomes for the data in fold $i$
3. Evaluate performance on these CV predictions
4. Fit a model to the entire training set
5. Test performance

</v-clicks>

---
level: 2
---

# Selecting $k$ and Tradeoffs

<v-clicks depth="2">


- Higher values of $k$ put fewer observations into each test fold, and more observations into each model
- This requires fitting $k+1$ models, however! If model fitting is slow, you want to balance that in your selection of $k$
- If you have $N$ observations, what happens if $k=N$?
  - This is called _Leave One Out Cross Validation (LOO-CV)_
  - Each model is fit on $N-1$ data points to predict an outcome for $1$ observation
  - Requires fitting $N$ models
- **In the final Problem Set, you'll implement parallelized LOO-CV!**

</v-clicks>

---
level: 2
---

# OOS Evaluation with GAMs

<v-clicks depth="3">

- What tunable model parameters do we have with GAMs?
  - What terms get smoothing
  - Do you use tensor smoothers
  - What kind of splines?
  - Values of hyperparameters like `k`
- What evaluation metrics might we want to use with GAMs?
  - Mean squared error (MSE)
    - $MSE(y, \hat{y}) = \frac{1}{N} \sum_i (y_i - \hat{y}_i)^2$
  - Classification accuracy
  - Log likelihood
  - Whatever you want, really!

</v-clicks>