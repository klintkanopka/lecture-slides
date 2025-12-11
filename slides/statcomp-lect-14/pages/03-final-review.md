---
level: 1
layout: section
---

# Final Review

---
level: 2
---

# What to study

- Big ideas: `if`, `else`, `while`, `for`
- Indexing and how to do selection with indexing
- Recycling behavior
- Big ideas about:
  - Simulations
  - Optimization
  - Randomized algorithms

---
level: 2
---

# Conceptual Questions

1. Describe a task that you can easily parallelize. Describe a task that you cannot parallelize.
2. Given a dataframe, `d`, with columns `X1, X2, X3, X4`:
    1. Write code using a `for()` loop that computes the mean of each row and returns a vector of row means
    2. Write code using an `apply()` family function that computes the mean of each row and returns a vector of row means
    3. Write _vectorized_ code to compute the mean of each row using only basic arithmetic operations and returns a vector of row means
3. For a dataframe, `d`, what is the difference between `d[4]` and `d[[4]]`?
4. What is the purpose of regularization? How are the LASSO and ridge regularization similar/different? In what cases might you use each?
5. In what situation is Markov Chain Monte Carlo most useful for numeric optimization?
6. How could you apply parallelization to $k$-Means clustering to improve runtime?



---
level: 2
---

# Numerical Optimization

- We will construct our own version of `optim()` using ternary search, designed to find the maximum value of a _convex_ function of one variable, $f(x)$. Because we guarantee $f(x)$ is convex, it only has a single maximum (or minimum) value. Ternary search is useful for solving _bounded_ optimization problems on convex functions. Bounded specifically means that you are looking for $x^*$, where $x^* = \underset{x}{\operatorname{arg\,max}}  f(x)$, subject to the constraint that $x_{left} \leq x^* \leq x_{right}$. Ternary search accomplishes this task by dividing up the search space into three pieces by selecting two boundary guesses, $b_1, b_2$. Because $f(x)$ is convex, there are exactly three things that can happen:

  1. $f(b_1) < f(b_2)$: This means the function is _increasing_ on the interval $[b_1, b_2]$, so the maximum can't be on the interval $[x_{left}, b_1)$ and must be on the interval $[b_1, x_{right}]$
  2. $f(b_1) > f(b_2)$: This means the function is _decreasing_ on the interval $[b_1, b_2]$, so the maximum can't be on the interval $(b_2, x_{right}]$ and must be on the interval $[x_{left}, b_2]$
  3. $f(b_1) = f(b_2)$: The function has to move from _increasing_ to _decreasing_ on the interval $[b_1, b_2]$, so the maximum must be on the interval $[b_1, b_2]$

**Draw a diagram to prove these facts to yourself.**

---
level: 3
---

# Numerical Optimization


- To carry out ternary search, follow the algorithm:

  1. Select $x_{left} < b_1 < b_2 < x_{right}$
  2. Compute $f(b_1), f(b_2)$
  3. Reassign $x_{left}$ and/or $x_{right}$ based on the criteria above
  4. If $\frac{x_{left} + x_{right}}{2} - x^* \leq \varepsilon$, return $\frac{x_{left} + x_{right}}{2}$, otherwise repeat


- Your task is to write a single function that carries out ternary search. Your function should take as arguments:

  - `f`: the function to minimize
  - `left`: the starting left bound
  - `right`: the starting right bound
  - `eps`: $\varepsilon$, the error tolerance

- Your function must return a single value, $\hat{x}^*$, such that $|x^* - \hat{x}^* |\leq \varepsilon$. Select $b_1, b_2$ such that they divide the search space into three equal parts.

---
level: 3
---

# Numerical Optimization

- Questions:

  1. How do you guarantee that $|x^* - \hat{x}^* |\leq \varepsilon$?
  2. Does this algorithm appear efficient? Why or why not?
  3. Describe the worst possible case for the run time of this algorithm in terms of $k$, the number of iterations until convergence. Write an expression that would allow you to solve for the worst case number of iterations required for convergence in terms of $k, \varepsilon$ and the starting guesses of $x_{left}, x_{right}$

---
level: 2
---

# Model Evaluation

- One way that classification models can be evaluated is using the $F_1$ score, which is the harmonic mean of precision and recall, where precision is proportion of predictive positive cases that were actually positive and recall is the proportion of actually positive cases that were predicted positive. The $F_1$ score is constructed as:

$$F_1 = \frac{2}{\text{precision}^{-1} + \text{recall}^{-1}}$$

- Write a function that takes in a vector of binary labels $(y_i \in \{0,1\})$ and a vector of binary predictions $(\hat{y}_i \in \{0,1\})$ and computes the $F_1$ score.

---
level: 3
---

# Model Evaluation

- Now assume you have a function, `FancyModel(train_data, test_data, lambda)` that takes in training data and some tuning parameter $\lambda \in [0,1]$, fits a model, and outputs predicted labels applied to the test data. Don't worry about how it works, just know that if you want predictions for the data that created the model, you can supply the same argument for `train_data` and `test_data`. 
- Write code to:

  1. Create an 80/20 train/test split of your original data, `d`. There is a column in `d` called `label` that contains the true label for each observation. 
  2. Carry out ten-fold cross validation on the training set for ten potential values of $\lambda$, finding the $F_1$ score for each held out fold and $\lambda$ combination
  3. Select the value of $\lambda$ with the highest mean $F_1$ score across folds
  4. Generate predictions for the test set using your chosen value of $\lambda$ 
  5. Compute the out of sample $F_1$ score 
