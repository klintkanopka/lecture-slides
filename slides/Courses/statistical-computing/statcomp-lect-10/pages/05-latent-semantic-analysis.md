---
level: 1
---

# Latent Semantic Analysis

- How could we try to find themes in text using computational methods?
- **Setup:** I have a bunch of negative movie reviews, and I want to extract similar themes to understand why people hate movies

<v-clicks>

- First we need a plan to quantify the text
- Then what can we do to the text?
- **Latent Semantic Analysis** is the SVD of the document-term matrix
- Think of this as doing "PCA on word counts"

</v-clicks>  

---
level: 3
hideInToc: true
---

# Exploring our text

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
# 1 the   163174
# 2 a      79225
# 3 and    74347
# 4 of     68999
# 5 to     68969
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

imdb_neg <- imdb_neg |>
  anti_join(stop_words)

imdb_neg
count(imdb_neg, word, sort = TRUE)
```
```r
data(stop_words)
stop_words

imdb_neg <- imdb_neg |>
  anti_join(stop_words)

imdb_neg
count(imdb_neg, word, sort = TRUE)

#    word       n
#   <chr>  <int>
# 1 br     52636
# 2 movie  24698
# 3 film   18717
# 4 bad     7389
# 5 time    6200
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
  filter(!word %in% c('br', 'movie', 'film'))
```

```r
imdb_counts <- imdb_neg |>
  group_by(review, word) |>
  summarize(n = n(), .groups = 'drop')

imdb_counts <- imdb_counts |>
  filter(!word %in% c('br', 'movie', 'film'))

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
  arrange(tf_idf) |>
  head(25) |>
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
  filter(!stem %in% c('br', 'movi', 'film'))

tf_idf <- bind_tf_idf(imdb_counts, 
                      stem, 
                      review, 
                      n)

tf_idf |>
  filter(review == target) |>
  arrange(tf_idf) |>
  head(25) |>
  ggplot(aes(x = tf_idf, 
             y = reorder(stem, tf_idf))) +
  geom_col(fill = okabeito_colors(2)) +
  labs(y = NULL) +
  theme_bw()
```

---
level: 3
---

# Construct DTM, conduct LSA, describe topics

```r
dtm <- cast_dtm(imdb_counts, review, stem, n)

n_topics <- 9
imdb_lsa <- svds(as.matrix(dtm), n_topics)

imdb_topics <- as.data.frame(imdb_lsa$v)
colnames(imdb_topics) <- paste0('topic_', 1:n_topics)
imdb_topics$term <- colnames(dtm)

imdb_top_terms <- imdb_topics |>
  pivot_longer(-term, names_to = 'topic', values_to = 'beta') |>
  group_by(topic) |>
  slice_max(abs(beta), n = 15) |>
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

# Use cosine similarity between right singular vectors to find similar reviews

```r
U <- imdb_lsa$u
rownames(U) <- rownames(dtm)

norm <- sqrt(matrix(rowSums(U * U), byrow = F, nrow = nrow(U), ncol = nrow(U)))
cos_sim <- U %*% t(U) / (norm * t(norm))

cos_sim_df <- as.data.frame(cos_sim) |>
  rownames_to_column('review_1') |>
  pivot_longer(-review_1, names_to = 'review_2', values_to = 'cos_sim') |>
  filter(review_1 != review_2) |>
  filter(cos_sim < 0.98) |>
  arrange(-cos_sim)

head(cos_sim_df, 5)

#    review_1    review_2    cos_sim
#   <chr>       <chr>         <dbl>
# 1 10223_4.txt 11884_4.txt   0.980
# 2 11884_4.txt 10223_4.txt   0.980
# 3 2297_4.txt  8846_2.txt    0.980
# 4 8846_2.txt  2297_4.txt    0.980
# 5 2505_2.txt  8018_1.txt    0.980
```

---
level: 3
---

# Let's look at an example:

```r
imdb_neg_raw |>
  filter(review %in% c('10223_4.txt', '11884_4.txt')) |>
  pull(text)
```
```
[1] "The worlds largest inside joke. The world's largest, most exclusive inside joke.<br /><br />Emulating the 
brash and 'everyman' humor of office space, this film drives the appeal of this film into the ground by making
the humor such that it would only be properly appreciated by legal secretaries writing books. The audience is
asked to assume the unfamiliar role of a legal secretary, and then empathize with the excruciatingly dumb..." 

[2] "I remembered the title so well. To me, it was a Flora Robson movie with Olivier and Vivien Leigh in 
supporting roles. And it had Vincent Massey's voice from behind whiskers. Well Flora Robson was great. Her next 
signature, for me, would be \"55 Days at Peking\". The same role but with different sumptuous gowns. And the 
same voice. As for the Armada, it was a subtext. I like black-and-white films. Was everything done in..."    
```

---
level: 3
---

# Let's filter out the common words:

```r {all|1-4|5|all}
filter_words <- tf_idf |>
  select(stem, idf) |>
  distinct() |>
  filter(idf < 2.5)
filtered_imdb_counts <- anti_join(imdb_counts, filter_words, by = 'stem')
filtered_dtm <- cast_dtm(filtered_imdb_counts, review, stem, n)
f_imdb_lsa <- svds(as.matrix(filtered_dtm), n_topics)
f_imdb_topics <- as.data.frame(f_imdb_lsa$v)
colnames(f_imdb_topics) <- paste0('topic_', 1:n_topics)
f_imdb_topics$term <- colnames(filtered_dtm)
f_imdb_top_terms <- f_imdb_topics |>
  pivot_longer(-term, names_to = 'topic', values_to = 'beta') |>
  group_by(topic) |>
  slice_max(abs(beta), n = 10) |>
  ungroup() |>
  arrange(topic, -beta)
f_imdb_top_terms |>
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
image: /lsa-06.png
---

---
level: 3
---

# Top reviews by topic

```r
f_imdb_reviews <- as.data.frame(f_imdb_lsa$u)
colnames(f_imdb_reviews) <- paste0('topic_', 1:n_topics)
f_imdb_reviews$document <- rownames(filtered_dtm)

f_imdb_top_reviews <- f_imdb_reviews |>
  pivot_longer(-document, names_to = 'topic', values_to = 'gamma') |>
  group_by(topic) |>
  slice_max(abs(gamma), n = 9) |>
  ungroup() |>
  arrange(topic, -gamma)

f_imdb_top_reviews |>
  mutate(document = reorder_within(document, gamma, topic)) |>
  ggplot(aes(x = gamma, y = document, fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_y_reordered() +
  theme_bw()
```

---
level: 3
layout: image
image: /lsa-07.png
---

---
level: 3
---

# Example texts

- Zombie topic: 
```r
imdb_neg_raw |>
  filter(review %in% c('8397_3.txt')) |>
  pull(text)
```

```
[1] "After reading the previous comments, I'm just glad that I wasn't the only person left confused, especially 
by the last 20 minutes. John Carradine is shown twice walking down into a grave and pulling the lid shut after 
him. I anxiously awaited some kind of explanation for this odd behavior...naturally I assumed he had something 
to do with the evil goings-on at the house, but since he got killed off by the first rising corpse (hereafter 
referred to as Zombie #1)...
```

- Book topic:

```r
imdb_neg_raw |>
  filter(review %in% c('10986_1.txt')) |>
  pull(text)
```

```
[1] "When I saw that Mary Louise Parker was associated with this epic novel turned film, I was intrigued. Being
a fan of the book, I assumed she'd be playing Tony, Roz, or Charis, but more so, I was intrigued to see how they
would turn this very head-y, almost psychological (but not psychological thriller) novel in to a movie that 
would be accessible to those who hadn't read the novel, and that would be at least mildly satisfying for those 
who had. The book is a complex reflection of society, women, and modern life..."    
```