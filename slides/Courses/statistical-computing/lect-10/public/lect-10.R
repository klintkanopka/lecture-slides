library(tidyverse)
library(tidytext)
library(SnowballC)
library(RSpectra)
library(see)

setwd('~/projects/lecture-slides/slides/statcomp-lect-10/public/')

set.seed(242424)

imdb_neg_raw <- read_csv('neg-imdb.csv') |>
  select(review = FileName, text = Content)

imdb_neg_raw$text[2]

imdb_neg <- imdb_neg_raw |>
  #slice_sample(n=2500) |>
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
  filter(!word %in% c('br', 'movie', 'film'))

# tf-idf weighting

tf_idf <- bind_tf_idf(imdb_counts, word, review, n)

target <- sample(unique(imdb_neg$review), 1)

tf_idf |>
  filter(review == target) |>
  arrange(tf_idf) |>
  head(25) |>
  ggplot(aes(x = tf_idf, y = reorder(word, tf_idf))) +
  geom_col(fill = okabeito_colors(2)) +
  labs(y = NULL) +
  theme_bw()

ggsave('lsa-02.png', height = 9, width = 8)


# one thing we can do is stem words, let's redo with stemming -

imdb_neg <- imdb_neg |>
  mutate(stem = wordStem(word))

imdb_counts <- imdb_neg |>
  group_by(review, stem) |>
  summarize(n = n(), .groups = 'drop') |>
  filter(!stem %in% c('br', 'movi', 'film'))


# tf-idf weighting

tf_idf <- bind_tf_idf(imdb_counts, stem, review, n)

tf_idf |>
  filter(review == target) |>
  arrange(tf_idf) |>
  head(25) |>
  ggplot(aes(x = tf_idf, y = reorder(stem, tf_idf))) +
  geom_col(fill = okabeito_colors(2)) +
  labs(y = NULL) +
  theme_bw()

ggsave('lsa-03.png', height = 9, width = 8)


# the document-term matrix and latent semantic analysis

dtm <- cast_dtm(imdb_counts, review, stem, n)

n_topics <- 9

#imdb_lsa <- svd(dtm, nu=6, nv=6)
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


# we can also use the right singular vectors to find similar reviews using
# cosine similarity

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

imdb_neg_raw |>
  filter(review %in% c('10223_4.txt', '11884_4.txt')) |>
  pull(text)

# let's try removing words with the lowest inverse document frequency to filter
# out common words

filter_words <- tf_idf |>
  select(stem, idf) |>
  distinct() |>
  filter(idf < 2.5)

filtered_imdb_counts <- imdb_counts |>
  anti_join(filter_words, by = 'stem')


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

ggsave('lsa-06.png', height = 9, width = 16)


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

ggsave('lsa-07.png', height = 9, width = 16)

U <- f_imdb_lsa$u
rownames(U) <- rownames(filtered_dtm)

norm <- sqrt(matrix(rowSums(U * U), byrow = F, nrow = nrow(U), ncol = nrow(U)))
cos_sim <- U %*% t(U) / (norm * t(norm))

cos_sim_df <- as.data.frame(cos_sim) |>
  rownames_to_column('review_1') |>
  pivot_longer(-review_1, names_to = 'review_2', values_to = 'cos_sim') |>
  filter(review_1 != review_2) |>
  filter(cos_sim < 0.98) |>
  arrange(-cos_sim)

head(cos_sim_df, 5)

imdb_neg_raw |>
  filter(review %in% c('1512_2.txt', '3596_2.txt')) |>
  pull(text)

imdb_neg_raw |>
  filter(review %in% c('8397_3.txt', '10986_1.txt')) |>
  pull(text)
