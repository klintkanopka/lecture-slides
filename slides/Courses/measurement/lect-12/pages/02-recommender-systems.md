---
level: 1
layout: section
---

# Recommendations


---
level: 2
hideInToc: true
---

# Recommendations

<v-clicks depth="2">

- How do you learn about new stuff?
  - Recommendations!
  - Broadly we can think about two types of recommendations:
    - Generic
    - Personalized
- Generic recommendations don't care about who you are
  - Wirecutter articles
  - Curated lists from influencers
  - Best selling
  - Most popular
  - Trending
  - Recent uploads

</v-clicks>

---
level: 3
---

# Recommendation


<v-clicks depth="2">

- Personalized recommendations are, well, _personalized_
  - Suggestions from friends
  - Algorithmic recommendations

</v-clicks>


---
level: 2
---

# Formulating the Problem

<v-clicks depth="4">

- Recommendations require three parts:
  - $X$ is the set of _users_ (customers, viewers, etc.)
  - $S$ is the set of _items_ (products, posts, videos, songs, etc.)
  - The _utility function_ $u: X \times S \rightarrow R$
    - $R$ is a set of ratings
    - $R$ is _totally ordered_, meaning any two elements can be compared
      - During comparisons, one item is either rated higher than the other or they are equally rated
      - Stars, thumbs up/down, swiping left/right, etc.

</v-clicks>

---
level: 2
---

# The Utility Matrix

- Ratings are stored in an object called the _utility matrix_

<v-clicks depth="2">

- The problem is that every user doesn't rate every item
  - The utility matrix is _sparse_

</v-clicks>

|       | Taylor Swift                | Bad Bunny                   | Turnstile                   | Pantera                     | Crowbar                     |
|-------|-----------------------------|-----------------------------|-----------------------------|-----------------------------|-----------------------------|
| Alice | 5                           | 3                           | 3                           | <div v-click.hide> 1 </div> | <div v-after.hide> 1 </div> |
| Bob   | 1                           | <div v-after.hide> 1 </div> | <div v-after.hide> 1 </div> | 5                           | <div v-after.hide> 4 </div> |
| Carol | 4                           | <div v-after.hide> 4 </div> | 5                           | <div v-after.hide> 3 </div> | <div v-after.hide> 2 </div> |
| David | <div v-after.hide> 3 </div> | <div v-after.hide> 2 </div> | 4                           | 4                           | 5                           |

<v-click>

- Does this remind you of anything we've dealt with before?

</v-click>

---
level: 3
---

# The Two Core Problems of Recommendation


<v-clicks depth="4">

- Problem One: Gathering observed ratings
  - This is the data collection problem
  - Where might this information come from?
    - Explicit ratings
      - Ask people to rate items
      - Pay people to rate items
    - Implicit ratings
      - Learn ratings from user behavior
- Problem Two: Predicting unobserved ratings
  - Upside is that you only really care about predicting high unknown ratings!
  - Downside is that this is a tricky problem and measuring success isn't always straightforward
  - Any early ideas on how this can be done?

</v-clicks>


---
level: 2
---

# Movie Recommendation

- With a group of $3 \pm 1$:

1. Download the [MovieLens 100K Dataset](https://grouplens.org/datasets/movielens/100k/)
2. Unzip the files, check out the `README` to get a sense of what's in there and how the data are organized
3. The full dataset is in `u.data`. Using whatever you like from the files provided, come up with a plan for recommending new movies to users
4. Try to code up a couple of test cases or mild proof-of-concepts
5. Start with something _very_ simple and then add complexity!


```r
d <- read_delim('u.data', col_names=c('user', 'movie', 'rating', 'timestamp'))
```


---
level: 2
---

# Approach One: Content-based Recommendations

<v-clicks depth="3">

- **Core idea:** Items have features and you recommend new items to a user that have features similar to items they've already rated highly
  - Restaurants that have the same owner or head chef
    - If you like Thai Diner, you should try Mommy Pai's
  - Bands that share members
    - If you like Pantera and Crowbar, you should listen to Down
  - Movies by the same director
    - If you like Raiders of the Lost Ark and Hook, you should watch Schindler's List
- How do you decide on the features?
  - Hand pick them
- How do you decide on similarity?
  - Use a distance metric!

</v-clicks>


---
level: 3
---

# Approach One: Content-based Recommendations

<v-clicks depth="3">

- Pros:
  - Independent of other users
  - You can handle users with niche tastes
  - You can recommend new and unpopular items
  - Recommendations are explainable

- Cons:
  - Feature engineering is hard
  - Recommending to new users doesn't really work
  - Limits the diversity of things you show to a user

</v-clicks>

---
level: 2
---

# Approach Two: Collaborative Filtering

<v-clicks depth="2">

- **Core idea:** We find users who have rated things similarly to you and then recommend to you things they've liked
  - We use the observed ratings of an item as its feature set
  - We use the observed ratings of a user as its feature set
  - Recommendations are made based on matching similar users (user-user collaborative filtering) or matching similar items (item-item collaborative filtering)
- How might this work in practice?

</v-clicks>

---
level: 3
---

# User-User Collaborative Filtering

<v-clicks depth="2">

- For a user $x \in X$:
  - Find the set of $K$ other users who have ratings most similar to $x$
  - Estimate $x$'s ratings on unseen items using the ratings of those $K$ users
- How might you determine similarity of ratings?
  - Cosine similarity, Jaccard similarity, correlations, lots of options!
- How would you then estimate $x$'s rating on a new item?
  - You can take the average of other users' ratings
  - You can take a weighted average using their similarity to $x$

</v-clicks>

---
level: 3
---

# Item-Item Collaborative Filtering

<v-clicks depth="2">

- For a user $x$ and item $s \in S$:
  - Find the set of $K$ other items who have ratings most similar to $x$
  - Estimate $x$'s rating of $s$ using the ratings of those $K$ items
- This generally boils down to $k$-Nearest Neighbors (kNN) followed by a weighted average
- Which version do you think works better? Why?
  - Item-item usually works better, as items are simpler

</v-clicks>


---
level: 3
---

# Approach Two: Collaborative Filtering

<v-clicks depth="3">

- Pros:
  - Works for any kinds of items
  - Does not require feature selection

- Cons:
  - Cold start problems
    - You need a critical mass of users and ratings
  - Sparsity problem
    - Might be hard to find users who have rated similar items
    - Unable to recommend items that have never been rated
  - Popularity bias
    - Users with unique tastes don't get good recommendations
    - Tends to over recommend popular items

</v-clicks>