---
level: 1
layout: section
---

# Person and Item Properties

---
level: 3
---

# Some Item Response Data

The dataset `frac20_noq.csv` contains a selection of responses to math items about fractions. These data are stored in _long form_, with three columns:

- `id` contains a `numeric` code that uniquely identifies each respondent. 
- `item` contains a `string` that identifies each individual item
- `resp` contains a `numeric` code for each respondent-item pair, containing `1` if that respondent answered correctly and `0` if they answered incorrectly

---
level: 3
---

# Converting Between Long and Wide Form

````md magic-move
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')
```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider()

```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(data =, id_cols =, names_from =, values_from =)

```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = , 
  id_cols = , 
  names_from = , 
  values_from = 
)

```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = , 
  names_from = , 
  values_from = 
)

```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = , 
  values_from = 
)

```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = item, 
  values_from = 
)

```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = item, 
  values_from = resp
)
```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = item, 
  values_from = resp
)

d_long <- pivot_longer()
```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = item, 
  values_from = resp
)

d_long <- pivot_longer(data =, cols =, names_to =, values_to =)
```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = item, 
  values_from = resp
)

d_long <- pivot_longer(
  data = , 
  cols = , 
  names_to = , 
  values_to =   
)
```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = item, 
  values_from = resp
)

d_long <- pivot_longer(
  data = d_wide, 
  cols = , 
  names_to = , 
  values_to =   
)
```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = item, 
  values_from = resp
)

d_long <- pivot_longer(
  data = d_wide, 
  cols = -id, 
  names_to = , 
  values_to =  
)
```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = item, 
  values_from = resp
)

d_long <- pivot_longer(
  data = d_wide, 
  cols = -id, 
  names_to = 'item', 
  values_to =  
)
```
```r
library(tidyverse)

d <- read_csv('frac20_noq.csv')

d_wide <- pivot_wider(
  data = d, 
  id_cols = id, 
  names_from = item, 
  values_from = resp
)

d_long <- pivot_longer(
  data = d_wide, 
  cols = -id, 
  names_to = 'item', 
  values_to = 'resp'  
)
```
````


---
level: 3
---

# Describing People and Items

- Using the `frac20_noq.csv` dataset, take 15 minutes and answer the following questions in a group of $3 \pm 1$:
  1. How would you quantify individual math ability? Come up with a procedure and find the top and bottom three respondents according to it.
  2. How would you quantify item difficulty? Come up with a procedure and find the three easiest and three hardest items according to it.
  3. How would you quantify how good an item is at distinguishing between high and low ability respondents? What are the best and worst three items for this?
  4. Some items may exhibit between group biases (for example, by age or gender). How might you detect items with this property?


---
level: 3
layout: section
---

# Classical Test Theory

---
level: 3
---

# Classical Test Theory

- Classical Test Theory is a theory of _measurement error_
- In CTT, the object of measurement is the _true score_, $T$
- We can never observe $T$, we only ever get the observed score, $S$
- The problem is that the observed score is the sum of the true score and measurement error:
- $S = T + M$
- Measurement error can be due to a ton of different factors:
  - Bad items
  - Environmental factors
  - Test is too short
  - Cheating

---
level: 3
---

# Describing People and Items

- **Ability** - (person level) a numerical description of the latent trait of interest
- **Difficulty** - (item level) a numerical description of the item-side driver of response probability
- **Discrimination** - (item level) a numerical description of how well an item differentiates (_discriminates_) between individuals of high and low ability
- **Differential Item Functioning (DIF)** - (item level) occurs when the probability of response depends on group membership

---
level: 3
---

# Ability

- In CTT, ability is operationalized as the _true score_, $T$
- Recall the true score is unobservable, as the observed score, $S$, is confounded with measurement error, $M$
- Again: $S = T + M$
- Conceptually, this is kind of strange!
  - Observed scores are _samples_ from the error-confounded distribution
  - Individual tests are samples from a _universe_ of possible tests
  - We will return to this sampling idea with tests!

---
level: 3
layout: image-right
image: /sum_scores.svg
---

# Ability

Sum Score

```r
sum_scores <- d |> 
  group_by(id) |> 
  summarize(sum_score = sum(resp))

ggplot(sum_scores, aes(x = sum_score)) +
  geom_histogram(
    bins = 10, 
    color='black', 
    fill = okabeito_colors(3)
  ) +
  theme_bw()
```

---
level: 3
---

# Difficulty

- Difficulty is an observed property of items
- In CTT, we describe this as the $p$-value
- This is the proportion of respondents giving a particular (usually correct or affirmative) response
- Low $p$-values mean items are less likely to be correct or affirmed, meaning they are "harder"

---
level: 3
layout: image-right
image: /difficulty.svg
---

# Difficulty 

$p$-value

```r
diff <- d |> 
  group_by(item) |> 
  summarize(p = mean(resp))

ggplot(diff, aes(x = p, y=reorder(item,p))) +
  geom_point(color = okabeito_colors(3)) +
  labs(x = 'p-value', y = 'item') +
  theme_bw()
```

---
level: 3
---

# Discrimination 

- How well an item differentiates between individuals of high and low ability
- In CTT, this is the item-total correlation
  - Correlation between the response to an item and the sum score
  - For dichotomous items, this is called the _point-biserial_ correlation
  - Cheat code: if you mark incorrect/correct responses as 0/1, this is exactly the Pearson correlation
- High discrimination means that you can more clearly divide between high and low ability respondents based upon only the response to that item
  - The item provides higher information about the individual respondent's latent trait
  - Low discrimination items provide less information about the respondent

---
level: 3
layout: image-right
image: /discrimination.svg
---

# Discrimination 

Item-Total Correlation

```r
disc <- left_join(d, sum_scores, by='id') |> 
  group_by(item) |> 
  summarize(a = cor(resp, sum_score))

ggplot(disc, aes(x = a, y = reorder(item, a))) +
  geom_point(
    color = okabeito_colors(3)
  ) +
  labs(x = 'discrimination', y = 'item') +
  theme_bw()
```
---
level: 3
---

# Differential Item Functioning

- Some items may function differently for respondents in different groups
- Typically we look to see if probability of correct response, conditioned on ability, differs by group membership
  - Often done by regressing the item response on the sum score (minus the item in question) and a group membership variable
  - A significant coefficient on the group membership variable indicates the presence of DIF
- This has two key assumptions:
  1. Some items (called _anchor items_) do not exhibit DIF and allow for comparable ability estimates
  2. Underlying ability distributions are the same for both groups
- DIF can be caused by linguistic bias, cultural bias, or some other item malfunction and is a source of construct-irrelevant variance
