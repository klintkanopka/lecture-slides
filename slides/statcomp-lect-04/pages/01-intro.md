---
level: 2
---

# Table of Contents

<Toc text-sm minDepth="1" maxDepth="2"/>


---
level: 2
---

# Announcements

- PS1 Grades released
  - Correlation between PS0 and PS1 grades was low $(r \approx 0.28)$
  - Mean score was 7.7pts higher on PS1 than PS0
  - Seems fine to me
- Answer keys for both PS0 and PS1 are posted in the Week 1 materials
- PS2 is due next week before class

---
level: 2
---

# Total PS Points Needed by Desired Grade

|Grade | PS Points|
|:----:|:--------:|
|A     | 752      |
|A-    | 707      |
|B+    | 680      |
|B     | 645      |

_Note: this does not account for the final exam!_

---
level: 2
---

# Check-In

- [PollEv.com/klintkanopka](https://PollEv.com/klintkanopka)

---
level: 1
layout: section
---

# Motivating Problem

---
level: 2
---

# Making Groups from Data

- Often called "clustering"
- Big idea:
  - Observations in your dataset belong to _latent_ groups
    - _Latent_ means unobservable
  - The nature and number of groups is unobservable
  - The assignment of each point to a group is unobservable
  - We also need to figure all of this out at once
- Conceptually, the clustering task takes observations that are "close together" and puts them into groups
- Typically there are three ways to do clustering:
  - _Iterative_: Pick a number of clusters and rearrange them until you get your "best fit"
  - _Agglomerative_: Build up clusters by sticking nearby points together
  - _Divisive_: Start with one big group and repeatedly cut it into pieces

---
level: 2
---

# Making Groups from Data

- This is different from building a model to predict known group membership and classifying new observations
  - This type of problem is called "supervised learning"
  - You can train a model to predict a known outcome and check how well it does
- Clustering is, on the other hand, an "unsupervised learning" problem
  - You don't know that there really are groups
  - If there are groups, you don't know how many groups there should be
  - You don't even know that the groups you find are the "right" groups
- This makes clustering really tricky task; you can't check your work!
