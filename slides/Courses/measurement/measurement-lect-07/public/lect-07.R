library(tidyverse)
library(see)
library(tidytext)
library(tm)
library(topicmodels)
library(SnowballC)

set.seed(242424)

setwd(
  '~/projects/lecture-slides/slides/Courses/measurement/measurement-lect-07/public'
)

#food_text <- read_csv('food-reviews.csv')

#food_text_small <- food_text |>
#  slice_sample(n = 25000)

#write_csv(food_text_small, 'food-reviews-small.csv')

food_text <- read_csv('food-reviews-small.csv')

food_tokens <- food_text |>
  select(review = Id, text = Text) |>
  unnest_tokens('word', text)

count(food_tokens, word, sort = TRUE)

data(stop_words)
stop_words

food_tokens <- food_tokens |>
  anti_join(stop_words)

count(food_tokens, word, sort = TRUE)

food_tokens |>
  count(word, sort = TRUE) |>
  head(25) |>
  ggplot(aes(x = n, y = reorder(word, n))) +
  geom_col(fill = okabeito_colors(3)) +
  labs(y = NULL) +
  theme_bw()


food_counts <- food_tokens |>
  group_by(review, word) |>
  summarize(n = n(), .groups = 'drop') |>
  filter(!word %in% c('br'))

# tf-idf weighting

tf_idf <- bind_tf_idf(food_counts, word, review, n)

target <- sample(1:nrow(food_text), 1)

food_text$Text[target]

tf_idf |>
  filter(review == target) |>
  arrange(tf_idf) |>
  head(25) |>
  ggplot(aes(x = tf_idf, y = reorder(word, tf_idf))) +
  geom_col(fill = okabeito_colors(3)) +
  labs(y = NULL) +
  theme_bw()


# the document-term matrix and topic modeling

dtm <- cast_dtm(food_counts, review, word, n)

# pause: if we do SVD (which is the first step of a PCA) on this matrix,
# we have done "latent semantic analysis" or LSA
# we are going to do Latent Dirichlet Allocation, which is a Bayesian approach

food_lda <- LDA(dtm, k = 2)

food_topics <- tidy(food_lda, matrix = 'beta')

food_top_terms <- food_topics |>
  group_by(topic) |>
  slice_max(beta, n = 10) |>
  ungroup() |>
  arrange(topic, -beta)

food_top_terms |>
  mutate(term = reorder_within(term, beta, topic)) |>
  ggplot(aes(x = beta, y = term, fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_y_reordered() +
  scale_fill_okabeito() +
  theme_bw()


food_reviews <- tidy(food_lda, matrix = 'gamma')
food_reviews <- food_reviews |>
  pivot_wider(
    id_cols = document,
    names_from = topic,
    names_prefix = 'topic_',
    values_from = 'gamma'
  )


# one thing we can do is stem words, let's redo with stemming -

food_tokens <- food_tokens |>
  mutate(stem = wordStem(word))

food_counts <- food_tokens |>
  group_by(review, stem) |>
  summarize(n = n(), .groups = 'drop') |>
  filter(!stem %in% c('br'))


# tf-idf weighting

tf_idf <- bind_tf_idf(food_counts, stem, review, n)

food_text$Text[target]

tf_idf |>
  filter(review == target) |>
  arrange(tf_idf) |>
  head(25) |>
  ggplot(aes(x = tf_idf, y = reorder(stem, tf_idf))) +
  geom_col(fill = okabeito_colors(3)) +
  labs(y = NULL) +
  theme_bw()


# the document-term matrix and topic modeling

dtm <- cast_dtm(food_counts, review, stem, n)

food_lda <- LDA(dtm, k = 2)

food_topics <- tidy(food_lda, matrix = 'beta')

food_top_terms <- food_topics |>
  group_by(topic) |>
  slice_max(beta, n = 10) |>
  ungroup() |>
  arrange(topic, -beta)

food_top_terms |>
  mutate(term = reorder_within(term, beta, topic)) |>
  ggplot(aes(x = beta, y = term, fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_y_reordered() +
  scale_fill_okabeito() +
  theme_bw()


food_reviews <- tidy(food_lda, matrix = 'gamma')
food_reviews <- food_reviews |>
  pivot_wider(
    id_cols = document,
    names_from = topic,
    names_prefix = 'topic_',
    values_from = 'gamma'
  )


# let's try a 6 topic model

food_lda <- LDA(dtm, k = 6)

food_topics <- tidy(food_lda, matrix = 'beta')

food_top_terms <- food_topics |>
  group_by(topic) |>
  slice_max(beta, n = 10) |>
  ungroup() |>
  arrange(topic, -beta)

food_top_terms |>
  mutate(term = reorder_within(term, beta, topic)) |>
  ggplot(aes(x = beta, y = term, fill = as.character(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(. ~ topic, scales = 'free') +
  scale_y_reordered() +
  theme_bw()


food_reviews <- tidy(food_lda, matrix = 'gamma')
food_reviews <- food_reviews |>
  pivot_wider(
    id_cols = document,
    names_from = topic,
    names_prefix = 'topic_',
    values_from = 'gamma'
  )
