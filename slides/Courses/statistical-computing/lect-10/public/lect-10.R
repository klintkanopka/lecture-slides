library(tidyverse)
library(tidytext)
library(SnowballC)
library(RSpectra)
library(see)

setwd(
  '~/projects/lecture-slides/slides/Courses/statistical-computing/lect-10/public/'
)

set.seed(242424)

imdb_neg_raw <- read_csv('neg-imdb.csv') |>
  select(review = FileName, text = Content)

imdb_neg_raw$text[2]

# cleaning: drop duplicate reviews, html line breaks, and add missing spaces
# after punctuation (otherwise 'predictable.i' becomes one token)

sum(duplicated(imdb_neg_raw$text))

imdb_neg_raw <- imdb_neg_raw |>
  distinct(text, .keep_all = TRUE) |>
  mutate(
    text = str_replace_all(text, '<br\\s*/?>', ' '),
    text = str_replace_all(text, '([.!?,;:])(?=[A-Za-z])', '\\1 ')
  )

imdb_neg <- imdb_neg_raw |>
  unnest_tokens(word, text)

imdb_neg
count(imdb_neg, word, sort = TRUE)

data(stop_words)
stop_words

imdb_neg <- imdb_neg |>
  anti_join(stop_words)

imdb_neg
count(imdb_neg, word, sort = TRUE)

imdb_neg |>
  count(word, sort = TRUE) |>
  head(25) |>
  ggplot(aes(x = n, y = reorder(word, n))) +
  geom_col(fill = okabeito_colors(2)) +
  labs(y = NULL) +
  theme_bw()

ggsave('lsa-01.png', height = 9, width = 8)


imdb_counts <- imdb_neg |>
  group_by(review, word) |>
  summarize(n = n(), .groups = 'drop')

imdb_counts <- imdb_counts |>
  filter(!word %in% c('movie', 'film'))

# tf-idf weighting

tf_idf <- bind_tf_idf(imdb_counts, word, review, n)

target <- sample(unique(imdb_neg$review), 1)

tf_idf |>
  filter(review == target) |>
  slice_max(tf_idf, n = 25) |>
  ggplot(aes(x = tf_idf, y = reorder(word, tf_idf))) +
  geom_col(fill = okabeito_colors(2)) +
  labs(y = NULL) +
  theme_bw()

ggsave('lsa-02.png', height = 9, width = 8)


# one thing we can do is stem words, let's redo with stemming

imdb_neg <- imdb_neg |>
  mutate(stem = wordStem(word))

imdb_counts <- imdb_neg |>
  group_by(review, stem) |>
  summarize(n = n(), .groups = 'drop') |>
  filter(!stem %in% c('movi', 'film'))

tf_idf <- bind_tf_idf(imdb_counts, stem, review, n)

tf_idf |>
  filter(review == target) |>
  slice_max(tf_idf, n = 25) |>
  ggplot(aes(x = tf_idf, y = reorder(stem, tf_idf))) +
  geom_col(fill = okabeito_colors(2)) +
  labs(y = NULL) +
  theme_bw()

ggsave('lsa-03.png', height = 9, width = 8)


# very short reviews dominate tf-idf (tf is a proportion), so drop reviews
# with fewer than 20 stems and recompute

review_length <- imdb_counts |>
  group_by(review) |>
  summarize(n_stems = sum(n))

sum(review_length$n_stems < 20)

imdb_counts <- imdb_counts |>
  semi_join(filter(review_length, n_stems >= 20), by = 'review')

tf_idf <- bind_tf_idf(imdb_counts, stem, review, n)


# the document-term matrix and latent semantic analysis, on tf-idf weights
# cast_sparse() keeps the DTM sparse: as a dense matrix it would be ~3 GB

dtm <- cast_sparse(tf_idf, review, stem, tf_idf)
dim(dtm)

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

ggsave('lsa-04.png', height = 9, width = 16)


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

ggsave('lsa-05.png', height = 9, width = 16)


# for comparison: the same LSA on raw counts instead of tf-idf

raw_dtm <- cast_sparse(imdb_counts, review, stem, n)
raw_lsa <- svds(raw_dtm, n_topics)

raw_topics <- as.data.frame(raw_lsa$v)
colnames(raw_topics) <- paste0('topic_', 1:n_topics)
raw_topics$term <- colnames(raw_dtm)

raw_topics |>
  pivot_longer(-term, names_to = 'topic', values_to = 'beta') |>
  group_by(topic) |>
  slice_max(abs(beta), n = 12) |>
  ungroup() |>
  mutate(term = reorder_within(term, beta, topic)) |>
  ggplot(aes(x = beta, y = term, fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_fill_okabeito() +
  scale_y_reordered() +
  theme_bw()

ggsave('lsa-06.png', height = 9, width = 16)


# we can also use the left singular vectors to find similar reviews using
# cosine similarity: each review's position in topic space is a row of U %*% Sigma

doc_coords <- imdb_lsa$u %*% diag(imdb_lsa$d)
rownames(doc_coords) <- rownames(dtm)

# scale each row to length 1, so a dot product is a cosine similarity
doc_coords <- doc_coords / sqrt(rowSums(doc_coords^2))

MostSimilar <- function(target, coords, n = 5) {
  sims <- drop(coords %*% coords[target, ])
  sims <- sims[names(sims) != target]
  head(sort(sims, decreasing = TRUE), n)
}

MostSimilar('8397_3.txt', doc_coords)
MostSimilar('10986_1.txt', doc_coords)

imdb_neg_raw |>
  filter(review %in% c('8397_3.txt', '2977_1.txt', '2982_1.txt')) |>
  pull(text)

imdb_neg_raw |>
  filter(review %in% c('10986_1.txt', '8953_1.txt', '3916_3.txt')) |>
  pull(text)

# the same search with raw counts

raw_coords <- raw_lsa$u %*% diag(raw_lsa$d)
rownames(raw_coords) <- rownames(raw_dtm)
raw_coords <- raw_coords / sqrt(rowSums(raw_coords^2))

MostSimilar('8397_3.txt', raw_coords)
MostSimilar('10986_1.txt', raw_coords)
