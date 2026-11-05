---
level: 1
layout: section
---

# Latent Semantic Analysis

---
level: 3
hideInToc: true
---

# Latent Semantic Analysis

- How could we try to find themes in text using computational methods?
- **Setup:** I have a bunch of negative movie reviews, and I want to extract similar themes to understand why people hate movies

<v-clicks>

- First, quantify the text: a document-term matrix, weighted with tf-idf
- Then, take the truncated SVD of that matrix
- **Latent Semantic Analysis** is the SVD of the document-term matrix
- Think of this as doing "PCA on word counts" (without centering)

</v-clicks>

---
level: 3
hideInToc: true
---

# Exploring our text

Data and code available [here](https://github.com/klintkanopka/lecture-slides/tree/main/slides/Courses/statistical-computing/lect-10/public)

```r
imdb_neg_raw <- read_csv('data/neg-imdb.csv') |>
  select(review = FileName, text = Content)

imdb_neg_raw$text[2]
```
An example review:
```
Well...tremors I, the original started off in 1990 and i found the movie quite
enjoyable to watch. however, they proceeded to make tremors II and III. Trust
me, those movies started going downhill right after they finished the first one,
i mean, ass blasters??? Now, only God himself is capable of answering the
question \"why in Gods name would they create another one of these dumpster
dives of a movie?\" Tremors IV cannot be considered a bad movie, in fact it
cannot be even considered an epitome of a bad movie, for it lives up to more
than that. As i attempted to sit though it, i noticed that my eyes started to
bleed, and i hoped profusely that the little girl from the ring would crawl
through the TV and kill me. did they really think that dressing the people who
had stared in the other movies up as though they we're from the wild west would
make the movie (with the exact same occurrences) any better? honestly, i would
never suggest buying this movie, i mean, there are cheaper ways to find things
that burn well.
```

---
level: 3
---

# Cleaning the text

````md magic-move
```r
sum(duplicated(imdb_neg_raw$text))
```
```r
sum(duplicated(imdb_neg_raw$text))

# [1] 68
```
```r
sum(duplicated(imdb_neg_raw$text))

# [1] 68

imdb_neg_raw <- imdb_neg_raw |>
  distinct(text, .keep_all = TRUE) |>
  mutate(
    text = str_replace_all(text, '<br\\s*/?>', ' '),
    text = str_replace_all(text, '([.!?,;:])(?=[A-Za-z])', '\\1 ')
  )
```
````

- 68 reviews were posted twice: left in, each one would be a "perfect match" for its twin
- The reviews contain HTML line breaks (`<br>`), which would become the most common word, `br`
- Missing spaces after punctuation glue words together: `predictable.I` would be one token

---
level: 3
---

# Transforming the data into word counts

````md magic-move
```r
imdb_neg <- imdb_neg_raw |>
  unnest_tokens(word, text)

imdb_neg
```
```r
imdb_neg <- imdb_neg_raw |>
  unnest_tokens(word, text)

imdb_neg

#   review     word
#   <chr>      <chr>
# 1 1821_4.txt working
# 2 1821_4.txt with
# 3 1821_4.txt one
# 4 1821_4.txt of
# 5 1821_4.txt the
```
```r
imdb_neg <- imdb_neg_raw |>
  unnest_tokens(word, text)

imdb_neg

#   review     word
#   <chr>      <chr>
# 1 1821_4.txt working
# 2 1821_4.txt with
# 3 1821_4.txt one
# 4 1821_4.txt of
# 5 1821_4.txt the

count(imdb_neg, word, sort = TRUE)
```
```r
imdb_neg <- imdb_neg_raw |>
  unnest_tokens(word, text)

imdb_neg

#   review     word
#   <chr>      <chr>
# 1 1821_4.txt working
# 2 1821_4.txt with
# 3 1821_4.txt one
# 4 1821_4.txt of
# 5 1821_4.txt the

count(imdb_neg, word, sort = TRUE)

#   word       n
#   <chr>  <int>
# 1 the   162640
# 2 a      79062
# 3 and    74070
# 4 to     68684
# 5 of     68656
```
````

---
level: 3
---

# Removing stop words

````md magic-move
```r
data(stop_words)
stop_words
```
```r
data(stop_words)
stop_words

# A tibble: 1,149 × 2
#   word        lexicon
#   <chr>       <chr>
# 1 a           SMART
# 2 a's         SMART
# 3 able        SMART
# 4 about       SMART
# 5 above       SMART
# 6 according   SMART
# 7 accordingly SMART
# 8 across      SMART
# 9 actually    SMART
#10 after       SMART

```

```r
data(stop_words)
stop_words

# A tibble: 1,149 × 2
#   word        lexicon
#   <chr>       <chr>
# 1 a           SMART
# 2 a's         SMART
# 3 able        SMART

imdb_neg <- imdb_neg |>
  anti_join(stop_words)
```

```r
data(stop_words)
stop_words

# A tibble: 1,149 × 2
#   word        lexicon
#   <chr>       <chr>
# 1 a           SMART
# 2 a's         SMART
# 3 able        SMART

imdb_neg <- imdb_neg |>
  anti_join(stop_words)

count(imdb_neg, word, sort = TRUE)
```

```r
data(stop_words)
stop_words

# A tibble: 1,149 × 2
#   word        lexicon
#   <chr>       <chr>
# 1 a           SMART
# 2 a's         SMART
# 3 able        SMART

imdb_neg <- imdb_neg |>
  anti_join(stop_words)

count(imdb_neg, word, sort = TRUE)

#    word       n
#   <chr>  <int>
# 1 movie  24631
# 2 film   18667
# 3 bad     7368
# 4 time    6155
# 5 story   5159
```
````

---
level: 3
layout: image-right
image: /lsa-01.png
---

# Visualizing most common words

```r
imdb_neg |>
  count(word, sort = TRUE) |>
  head(25) |>
  ggplot(aes(x = n, y = reorder(word, n))) +
  geom_col(fill = okabeito_colors(2)) +
  labs(y = NULL) +
  theme_bw()
```

---
level: 3
---

# Count by reviews and drop uninformative words

````md magic-move
```r
imdb_counts <- imdb_neg |>
  group_by(review, word) |>
  summarize(n = n(), .groups = 'drop')

imdb_counts <- imdb_counts |>
  filter(!word %in% c('movie', 'film'))
```

```r
imdb_counts <- imdb_neg |>
  group_by(review, word) |>
  summarize(n = n(), .groups = 'drop')

imdb_counts <- imdb_counts |>
  filter(!word %in% c('movie', 'film'))

imdb_counts

#    review  word               n
#   <chr>   <chr>          <int>
# 1 0_3.txt absurd             2
# 2 0_3.txt audience           1
# 3 0_3.txt briefly            1
# 4 0_3.txt chantings          1
# 5 0_3.txt cinematography     1
```
````

---
level: 3
layout: image-right
image: /lsa-02.png
---

# tf-idf weighting

```r
tf_idf <- bind_tf_idf(imdb_counts,
                      word,
                      review,
                      n)

target <- sample(unique(imdb_neg$review), 1)

tf_idf |>
  filter(review == target) |>
  slice_max(tf_idf, n = 25) |>
  ggplot(aes(x = tf_idf,
         y = reorder(word, tf_idf))) +
  geom_col(fill = okabeito_colors(2)) +
  labs(y = NULL) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /lsa-03.png
---

# Stemming

```r
imdb_neg <- imdb_neg |>
  mutate(stem = wordStem(word))

imdb_counts <- imdb_neg |>
  group_by(review, stem) |>
  summarize(n = n(), .groups = 'drop') |>
  filter(!stem %in% c('movi', 'film'))

tf_idf <- bind_tf_idf(imdb_counts,
                      stem,
                      review,
                      n)

tf_idf |>
  filter(review == target) |>
  slice_max(tf_idf, n = 25) |>
  ggplot(aes(x = tf_idf,
             y = reorder(stem, tf_idf))) +
  geom_col(fill = okabeito_colors(2)) +
  labs(y = NULL) +
  theme_bw()
```

---
level: 3
---

# Watch out for very short reviews

```r
review_length <- imdb_counts |>
  group_by(review) |>
  summarize(n_stems = sum(n))

sum(review_length$n_stems < 20)

# [1] 413

imdb_counts <- imdb_counts |>
  semi_join(filter(review_length, n_stems >= 20), by = 'review')

tf_idf <- bind_tf_idf(imdb_counts, stem, review, n)
```

- Term frequency is a _proportion_, so in a 3-word review every word gets a huge tf
- "This movie is terrible but it has some good effects." ends up at the extreme of several topics
- We drop the 413 reviews (3%) with fewer than 20 stems after removing stop words

---
level: 3
---

# Construct DTM, conduct LSA, describe topics

```r
dtm <- cast_sparse(tf_idf, review, stem, tf_idf)  # 12019 x 40527; ~3 GB if not sparse
n_topics <- 9
imdb_lsa <- svds(dtm, n_topics)

imdb_topics <- as.data.frame(imdb_lsa$v)
colnames(imdb_topics) <- paste0('topic_', 1:n_topics)
imdb_topics$term <- colnames(dtm)

imdb_top_terms <- imdb_topics |>
  pivot_longer(-term, names_to = 'topic', values_to = 'beta') |>
  group_by(topic) |>
  slice_max(abs(beta), n = 12) |>
  ungroup() |>
  arrange(topic, -beta)

imdb_top_terms |>
  mutate(term = reorder_within(term, beta, topic)) |>
  ggplot(aes(x = beta, y = term, fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_fill_okabeito() +
  scale_y_reordered() +
  theme_bw()
```

---
level: 3
layout: image
image: /lsa-04.png
---

---
level: 3
---

# Reading LSA topics

- Each topic is a direction in word space, defined by the terms with the largest $|\beta|$
- **The signs are arbitrary:** the SVD can flip $\mathbf{u}_i$ and $\mathbf{v}_i$ together without changing anything, so each topic has two _ends_ rather than a positive direction
  - Topic 4: _zombie, horror, vampire, gore_ at one end, _funny, comedy, joke, laugh_ at the other
  - Topic 6: _episode, series, Batman, Scooby-Doo, animated_ at one end, _comedy, zombie_ at the other
  - Topic 2: _book, read_ at one end, _zombie, horror, bad_ at the other
- **Topic 1 is all one sign:** we didn't center the DTM, so the first direction points at the "average review" (_bad, watch, story, acting_)
- What people hate: bad adaptations of books, horror, failed comedies, cartoon and TV series spin-offs

---
level: 3
---

# Most prominent reviews by topic

```r
imdb_reviews <- as.data.frame(imdb_lsa$u)
colnames(imdb_reviews) <- paste0('topic_', 1:n_topics)
imdb_reviews$document <- rownames(dtm)

imdb_top_reviews <- imdb_reviews |>
  pivot_longer(-document, names_to = 'topic', values_to = 'gamma') |>
  group_by(topic) |>
  slice_max(abs(gamma), n = 9) |>
  ungroup() |>
  arrange(topic, -gamma)

imdb_top_reviews |>
  mutate(document = reorder_within(document, gamma, topic)) |>
  ggplot(aes(x = gamma, y = document, fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_fill_okabeito() +
  scale_y_reordered() +
  theme_bw()
```

---
level: 3
layout: image
image: /lsa-05.png
---

---
level: 3
---

# What if we skipped tf-idf?

```r
raw_dtm <- cast_sparse(imdb_counts, review, stem, n)
raw_lsa <- svds(raw_dtm, n_topics)
```

- Same LSA, but on raw counts instead of tf-idf weights (same plotting code as before)
- Raw counts are dominated by words that almost every review uses: _character, time, scene, watch, story_
- The topics become contrasts between generic words instead of themes
- tf-idf downweights words that appear everywhere, which lets the themes (books, zombies, cartoons, comedy) show up

---
level: 3
layout: image
image: /lsa-06.png
---

---
level: 2
---

# Similarity Metrics

- How do you know that two things are similar?
- In some ways, "similarity" is the inverse of "distance"
- You can use distance formulas (Euclidean, Manhattan)
- Minkowski Distance generalizes the two ($p = 1$ is Manhattan, $p = 2$ is Euclidean):

$$ D(A,B) = \bigg( \sum_{i=1}^n |a_i - b_i|^p \bigg)^{\frac{1}{p}}$$

---
level: 3
hideInToc: true
---

# Cosine Similarity

- For vectors, we frequently use _cosine similarity_
  - Measures the cosine of the angle between two vectors
  - Cares about the _direction_ they point in, but not the _length_

$$ S_c(A,B) = \frac{\mathbf{A}\cdot\mathbf{B}}{||\mathbf{A}|| \, ||\mathbf{B}||} = \frac{\sum_{i=1}^n a_i b_i}{\sqrt{\sum_{i=1}^n a_i^2}\cdot \sqrt{\sum_{i=1}^n b_i^2}}  $$

---
level: 3
---

# Use cosine similarity to find similar reviews

```r
doc_coords <- imdb_lsa$u %*% diag(imdb_lsa$d)
rownames(doc_coords) <- rownames(dtm)
doc_coords <- doc_coords / sqrt(rowSums(doc_coords^2))

MostSimilar <- function(target, coords, n = 5) {
  sims <- drop(coords %*% coords[target, ])
  sims <- sims[names(sims) != target]
  head(sort(sims, decreasing = TRUE), n)
}

MostSimilar('8397_3.txt', doc_coords)

#  2982_1.txt  2977_1.txt  7796_4.txt  2980_4.txt 10103_1.txt
#   0.9981995   0.9978230   0.9960572   0.9954260   0.9952619
```

- Each review's position in topic space is a row of $\mathbf{U}\Sigma$, not $\mathbf{U}$: scaling by the singular values makes the important topics count more
- After scaling each row to length 1, a dot product _is_ the cosine similarity
- Comparing one review to all the others is 12,019 dot products, instead of a 12,019 $\times$ 12,019 matrix

---
level: 3
---

# Similar reviews: zombies

- The target, `8397_3.txt`:
```
"After reading the previous comments, I'm just glad that I wasn't the only person left confused, especially by
the last 20 minutes. John Carradine is shown twice walking down into a grave and pulling the lid shut after him...
naturally I assumed he had something to do with the evil goings-on at the house, but since he got killed off by
the first rising corpse (hereafter referred to as Zombie #1)..."
```

- Its two closest matches:
```
2982_1.txt: "Zombie Review #3  **Spoilers**  Few films are actually "so bad they're good", and Zombi 3 is not just
bad, it's wretchedly, unforgivably bad in so many ways that a whole new language may be needed..."

2977_1.txt: "Title: Zombie 3 (1988)   Directors: Mostly Lucio Fulci, but also Claudio Fragasso and Bruno Mattei
Cast: Ottaviano DellAcqua, Massimo Vani, Beatrice Ring, Deran Serafin   Review:   To review this flick..."
```

---
level: 3
---

# Similar reviews: books

```r
MostSimilar('10986_1.txt', doc_coords)

#  3916_3.txt  8953_1.txt 10297_3.txt  4540_2.txt  4907_3.txt
#   0.9962110   0.9945196   0.9864975   0.9853541   0.9851908
```

```
10986_1.txt: "When I saw that Mary Louise Parker was associated with this epic novel turned film, I was intrigued.
Being a fan of the book, I assumed she'd be playing Tony, Roz, or Charis..."

3916_3.txt: "We all know a movie never does complete justice to the book, but this is exceptional. Important
characters were cut out, Blanca and Alba were essentially mushed into the same character..."

8953_1.txt: "I saw this movie literally directly after finishing the book, and maybe that was a neutral idea or a
very stupid one. I think it was the latter. First of all, it was inaccurate in many small, yet important details..."
```

- With the raw-count LSA instead, this review's closest matches include a review complaining about Irish cinematic clichés and one about Cher
