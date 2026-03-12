---
level: 1
layout: section
---

# Measurement of Categorical Latent Variables


---
level: 2
hideInToc: true
---

# Categorical Latent Variables


- Until now, we've only discussed the measurement of continuous latent variables
  - Remember  _“All that exists, exists in some amount and can be measured” - E.L. Thorndike (1918)_
- There are things that are not continuous that we may care about
  - **Categorical** variables have discrete levels or categories, and individual membership in a category is all-or-nothing
    - Think: You can't be part dead
    - Membership to groups may or may not be exclusive 
  - **Ordinal** variables are a subset of categorical variables that have an ordering to them
    - Think grade level, likert scale responses, age groups, etc
    - _Some_ approaches that work for continuous variables work here
    - Continuous approaches to ordinal variables assume _interval_ spacing between categories
  - **Nominal** variables are categorical variables with no implied ordering
    - Think: Undergraduate major, US states

---
level: 3
---

# Categorical Measurement?

- The most common perception of measurement is that it only applies to continuous quantities
- I _vehemently_ disagree with this perception
- Classification is an incredibly important task, so is important that we extend the same care we apply to continuous measurement to classification tasks
  - Reliability: How stable are our classifications?
  - Validity: Do we have enough evidence to justify the classifications, their interpretations, and subsequent decisions made because of them?

---
level: 2
layout: section
---

# Clustering


---
level: 3
---

# Clustering

- Core idea: 
  - Observations in your dataset belong to latent groups
  - The nature and number of groups are unobserved
  - The assignment of each point to a group is unobserved
  - We have to figure this all out at once
- Conceptually, clustering takes observations that are close together and puts them into groups
- Typically three ways to do clustering:
  - **Iterative** - Pick a number of clusters and rearrange them until you get your “best fit” (mostly today)
  - **Hierarchical** - Build up clusters by sticking together nearby points (mostly homework)
  - **Model-based** - Make assumptions about the structure of the data and leverage that to find clusters (next week)
- Iterative and hierarchical methods are considered to be "model free"
- How do you know if things are close together?


---
level: 3
---

# Measuring Distances

- If you want to talk about how "close together" two things are, you need some notion of distance
- Distances are _dissimilarity_ metrics
  - Larger magnitudes mean less similar (or farther apart) objects
  - Assign a value of 0 to identical objects
- Contrast these with _similarity_ metrics
  - Larger magnitudes mean more similar (or closer together) objects
  - Assign maximal values (sometimes 1) to identical objects

---
level: 3
layout: image
image: /map.png
---

<img
  v-click
  style="position: absolute; top: 400px; left: 250px; width: 30px"
  src="/pin.png"
  alt=""
/>
<img
  v-click
  style="position: absolute; top: 140px; left: 600px; width: 30px"
  src="/pin.png"
  alt=""
/>
<arrow v-click x1="285" y1="410" x2="500" y2="70" width="4" color="#3772ff" />
<arrow v-click x1="510" y1="70" x2="610" y2="135" width="4" color="#3772ff" />
<arrow v-click x1="285" y1="410" x2="610" y2="140" width="4" color="#df2935" />


---
level: 3
---

# Measuring Distances

- Most generically, we often think about _Euclidean distance_
  - Sometimes called "as the crow flies"
  - It's straight line distance


$$d(x,y) = \sqrt{\sum_i (x_i - y_i)^2}$$


---
level: 3
---

# Measuring Distances

- Depending on the situation, something else might make more sense!
- Another spatial distance metric is _Manhattan distance_
- It's what you might expect from the name

$$ d(p,q) = \sum_i |p_i - q_i|$$


---
level: 3
---

# Other Distances

- **Minkowski Distance** (also called the $p$-norm) generalizes Euclidean and Manhattan Distance:

$$d(x,y) = \bigg(\sum_i |x_i - y_i|^p \bigg)^\frac{1}{p}$$

- **Hamming Distance** finds the distance between two strings using the minimum number of character level edits to turn one string into another
  - The distance between `dog` and `ogre` is three
  - The distance between `dump` and `dumb` is one

---
level: 3
---

# Similarities (and Dissimilarities)

- Turning a similarity metric into a dissimilarity metric is as easy as multiplying by $-1$! Some useful ones are:
- **Cosine Similarity** is the cosine of the angle between two vectors
  - Equals one when two vectors point in the same direction
  - Equals zero when they are orthogonal
  - Equals negative one when they point in opposite directions
- **Jaccard Similarity** is the ratio of the number of elements in both of two sets (the intersection) to the number of unique elements across both sets (the union)
  - Equals zero when two sets have no common elements
  - Equals one when two sets are identical