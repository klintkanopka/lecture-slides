---
level: 1
layout: section
---

# Applied Text Analysis and Topic Models


---
level: 2
hideInToc: true
---

# Getting started (and taking a break)

- Start by downloading [this corpus](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/measurement-lect-07/public/food-reviews-small.csv)
  - A sample of 25,000 reviews for "fine foods" on Amazon from [this Kaggle dataset](https://www.kaggle.com/datasets/snap/amazon-fine-food-reviews)
- Take the data, remove stop words, stem the tokens, and then explore what's left
  - Find (1) the most common words in the dataset, (2) the distribution of the lengths of the reviews, and (3) something else interesting

```r
food_text <- read_csv('food-reviews-small.csv')

food_tokens <- food_text |>
  select(review = Id, text = Text) |>
  unnest_tokens('word', text)

data(stop_words)

food_tokens <- food_tokens |>
  anti_join(stop_words)

food_counts <- food_tokens |>
  group_by(review, word) |>
  summarize(n = n(), .groups = 'drop')|>
  mutate(stem = wordStem(word))
```

---
level: 3
layout: image-right
image: /common-terms.svg
---

# Most common terms

```r
food_counts |>
  group_by(stem) |>
  summarize(n = sum(n)) |>
  arrange(-n) |>
  head(20) |>
  ggplot(aes(x = n, y = reorder(stem, n))) +
  geom_col(fill = okabeito_colors(3)) +
  labs(y = NULL) +
  theme_bw()
```


---
level: 3
layout: image-right
image: /review-length.svg
---

# Review length

```r
food_counts |>
  group_by(review) |>
  summarize(n = sum(n)) |>
  ggplot(aes(x = n)) +
  geom_histogram(fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /review-length-zoom.svg
---

# Review length

```r
food_counts |>
  group_by(review) |>
  summarize(n = sum(n)) |>
  filter(n <= 200) |>
  ggplot(aes(x = n)) +
  geom_histogram(fill = okabeito_colors(3)) +
  theme_bw()
```


---
level: 3
layout: image-right
image: /tf-idf.svg
---

# tf-idf

```r
tf_idf <- bind_tf_idf(food_counts, 
  stem, review, n)
target <- 212418
food_text$Text[food_text$Id == target]
```
```
"Very bad buy on my side. first of all i had misstaken these for the candy bubble gum 
cigarrets. When i got my package i was quite happy with the shipping time, 3 days but 
when i opened the package it was just the candybox inside of an amazon box. The candy 
box was not sealed and it was all dusty on the outside, and when you opened it the 
ciggarete individual boxes were all dusty. I opened one of the individual cases and 
there were like 5 or 6. I opened another box and there was 5. I tried one of the candy 
sticks and it tasted horrible! not a good buy at all. WARNING THESE ARE JUST STICKS OF 
CHALK PRETTY MUCH, DO NOT MISTAKE FOR BUBBLE GUM CIGS."
```

```r
tf_idf |>
  filter(review == target) |>
  arrange(tf_idf) |>
  head(25) |>
  ggplot(aes(x = tf_idf, 
             y = reorder(stem, tf_idf))) +
  geom_col(fill = okabeito_colors(3)) +
  labs(y = NULL) +
  theme_bw()

```


---
level: 3
---

# Building the document-term matrix

```r
dtm <- food_counts |>
  filter(!stem %in% c('br')) |>
  cast_dtm(review, stem, n)

as.matrix(dtm[1:10, 1:10])
```
```
     Terms
Docs  arriv error intend jumbo label peanut product repres salt size unsalt vendor brand bui flavor
  2       1     1      1     2     1      2       2      1    1    1      1      1     0   0      0
  46      0     0      0     0     0      0       0      0    0    0      0      0     1   1      1
  52      0     0      0     0     0      0       0      0    0    0      0      0     0   1      0
  71      0     0      0     0     0      0       0      0    0    0      0      0     0   0      0
  87      0     0      0     0     0      0       0      0    0    0      0      0     1   0      0
  94      0     0      0     0     0      0       0      0    0    0      0      0     0   1      2
  157     0     0      0     0     0      0       0      0    3    0      0      0     0   0      0
  196     0     0      0     0     0      0       0      0    0    0      0      0     0   0      0
  202     0     0      0     0     0      0       0      0    0    1      0      0     0   0      0
  239     0     0      0     0     0      0       0      0    0    0      0      0     0   0      0
  255     0     0      0     0     0      0       0      0    0    0      0      0     0   0      0
  295     0     0      0     0     0      0       0      0    0    0      0      0     0   0      0
  296     0     0      0     0     0      0       0      0    0    0      0      0     0   0      0
  302     0     0      0     0     0      0       0      0    0    0      0      0     0   0      0
  325     0     0      0     0     0      0       0      0    0    0      0      0     0   0      0
```

---
level: 3
layout: image-right
image: /lda-2-topics.svg
---

# Fitting an LDA

```r
food_lda <- LDA(dtm, k = 2)

food_topics <- tidy(food_lda, matrix = 'beta')

food_top_terms <- food_topics |>
  group_by(topic) |>
  slice_max(beta, n = 10) |>
  ungroup() |>
  arrange(topic, -beta)

food_top_terms |>
  mutate(
    term = reorder_within(term, beta, topic)
    ) |>
  ggplot(aes(x = beta, 
             y = term, 
             fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_y_reordered() +
  scale_fill_okabeito() +
  labs(y = NULL) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /lda-4-topics.svg
---

# Fitting another LDA

```r
food_lda <- LDA(dtm, k = 4)

food_topics <- tidy(food_lda, matrix = 'beta')

food_top_terms <- food_topics |>
  group_by(topic) |>
  slice_max(beta, n = 10) |>
  ungroup() |>
  arrange(topic, -beta)

food_top_terms |>
  mutate(
    term = reorder_within(term, beta, topic)
    ) |>
  ggplot(aes(x = beta, 
             y = term, 
             fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_y_reordered() +
  scale_fill_okabeito() +
  labs(y = NULL) +
  theme_bw()
```



---
level: 3
layout: image-right
image: /lda-6-topics.svg
---

# Fitting yet another LDA

```r
food_lda <- LDA(dtm, k = 6)

food_topics <- tidy(food_lda, matrix = 'beta')

food_top_terms <- food_topics |>
  group_by(topic) |>
  slice_max(beta, n = 10) |>
  ungroup() |>
  arrange(topic, -beta)

food_top_terms |>
  mutate(
    term = reorder_within(term, beta, topic)
    ) |>
  ggplot(aes(x = beta, 
             y = term, 
             fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_y_reordered() +
  scale_fill_okabeito() +
  labs(y = NULL) +
  theme_bw()
```

---
level: 3
---

# Projecting reviews onto a scale


```r
food_reviews <- tidy(food_lda, matrix = 'gamma')
food_reviews <- food_reviews |>
  pivot_wider(
    id_cols = document,
    names_from = topic,
    names_prefix = 'topic_',
    values_from = 'gamma'
  )
```

```
# A tibble: 24,999 × 7
   document topic_1 topic_2 topic_3 topic_4 topic_5 topic_6
   <chr>      <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
 1 2          0.169   0.167   0.165   0.167   0.166   0.166
 2 46         0.166   0.166   0.166   0.167   0.169   0.167
 3 52         0.167   0.172   0.164   0.165   0.166   0.165
 4 71         0.165   0.165   0.166   0.173   0.163   0.167
 5 87         0.166   0.161   0.168   0.184   0.160   0.162
 6 94         0.161   0.164   0.174   0.187   0.154   0.159
 7 157        0.171   0.164   0.165   0.166   0.165   0.169
 8 196        0.171   0.165   0.161   0.164   0.178   0.160
 9 202        0.168   0.163   0.168   0.171   0.163   0.167
10 239        0.166   0.160   0.166   0.160   0.171   0.177
# ℹ 24,989 more rows

```