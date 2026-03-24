---
level: 1
layout: section
---

# Evaluation Theory

---
level: 2
---

# Model Evaluation

- How do we know that we have a model that's any good?
- There exists a litany of retrospective fit statistics, metrics, and statistical tests
  - These are sometimes specific to certain types of models
  - These are often not comparable between model types or across datasets
  - These all have one killer flaw, however
  
---
level: 3
---

# An Analogy: Course Grading

- This course used to be graded exclusively on problem set performance
  - What are the advantages/disadvantages?
- Some courses have final exams and problem sets
  - What are the advantages/disadvantages?
- What if you distribute practice final exams?
  - What are the advantages/disadvantages?
  
---
level: 3
---

# An Analogy: Course Grading

<v-click>

- Problem set only grading is working with already observed data
  - Upside: Easier for everyone!
  - Upside: Students get time to work through problem sets, find resources, and do their best
  - Downside: You don't have a good estimate of how students will do on new tasks that you didn't design for them (you've evaluated the outcome of a course on the process of learning)
  - Think of this as _in-sample evaluation_

</v-click>
<v-click>

- Adding a final exam adds a new test challenge to the end!
  - Upside: You now have a new, novel task that students have to complete using only what they've learned
  - Downside: Students could prepare for the wrong things and totally bomb it (overfitting)
  - You're evaluating course learning on new, novel observations. This is _out-of-sample (OOS) evaluation_

</v-click>
<v-click>

- How do practice finals change this?
  - They give students a chance to adjust to what the new task might be like (reducing overfitting)
  - They have to devote time spent studying to time spent taking practice tests (less training)
  - Focusing too hard on the practice final may divert study time toward topics on the practice final but not the real final (increasing overfitting)

</v-click>
<v-click>

- What do you think is _best_?

</v-click>


---
level: 3
---

# Back to Models

- The fatal flaw of traditional model evaluation is that it only uses the data in hand and tells you nothing about if your model will generalize to new data or is overfitting to the data you used to fit it
- When fitting models, we typically only have the data in hand and the common wisdom is to use as much of it as humanly possible!
- Implementing one of these evaluation schemes requires splitting up the data you have, so you don't use all of it to fit models. We call these _sets_

---
level: 2
---

# Data Splitting 

<v-click>

- The _training set_ is the set of data points used to fit the model. This should **always** be your largest subset of data

</v-click>
<v-click>

- The _testing set_ (or _test set_ or _holdout set_) is the set of data points used to make your final evaluation
  - The model fit on the training set makes new predictions for the OOS data in the testing set
  - Then you compute some fit metric (like MSE or accuracy)
  - The test set should be as small as possible while still giving you a sample of points to evaluate on
  - If you have model parameters to tune, like regularization parameters or decisions between which model to use, you can't make that selection based on test set performance, because then it becomes in sample data!

</v-click>
<v-click>

- The _validation set_ (or _eval set_, _development set_, or _dev set_) is not used to train the model, but used to pick the best values for user-tunable parameters 
  - Things like learning rates in gradient descent, or amounts of regularization, or balance between LASSO and Ridge regularization
  - Should be the same size as your test set

</v-click>


---
level: 3
---

# In Practice

- The gold standard when you don't have any tunable model parameters is a train/test split, often 80\% of data in the training set and 20\% in the testing set (called an 80/20 split)
  - If you have a huge amount of data, you can push this to a 90/10 split or even smaller for the test set
- If you have tunable model parameters or modeling decisions, the gold standard is a train/dev/test split
  - Often this is 80/10/10
- The problem is that you want to have as much data as possible inside your model
  - This is especially true of more flexible machine learning models!
- There is another way...