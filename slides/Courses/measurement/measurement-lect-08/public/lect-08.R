library(tidyverse)
library(see)
library(fpc)
library(cluster)
library(dbscan)
library(factoextra)

set.seed(242424)

setwd(
  '~/projects/lecture-slides/slides/Courses/measurement/measurement-lect-08/public'
)

#kmeans
#hclust
#diana
#dbscan

#### Applied clustering with real data!

d <- read_csv('drug_use_personality.csv')

d_clust <- select(d, neuroticism:sensation_seeking) |>
  mutate(across(everything(), ~ scale(.x)[, 1]))

d_clust |>
  pivot_longer(everything(), names_to = 'var', values_to = 'value') |>
  ggplot(aes(x = value, fill = var)) +
  geom_density(show.legend = FALSE) +
  facet_grid(var ~ .) +
  scale_fill_okabeito() +
  theme_bw()

ggsave('personality-dist.svg', height = 4.5, width = 4)

fviz_nbclust(d_clust, kmeans, 'wss')

ggsave('clust-wss.svg', height = 4.5, width = 4)

fviz_nbclust(d_clust, kmeans, 'silhouette')

ggsave('clust-silhouette.svg', height = 4.5, width = 4)

fviz_nbclust(d_clust, kmeans, 'gap')

ggsave('clust-gap.svg', height = 4.5, width = 4)


c <- kmeans(d_clust, 3, nstart = 100)

c$centers

data.frame(c$centers) |>
  rownames_to_column('cluster') |>
  pivot_longer(-cluster, names_to = 'trait', values_to = 'mean') |>
  ggplot(aes(x = mean, y = trait, fill = cluster)) +
  geom_col(show.legend = FALSE) +
  facet_grid(cluster ~ .) +
  scale_fill_okabeito() +
  labs(y = NULL) +
  theme_bw()

ggsave('clust-centroids.svg', height = 4.5, width = 4)


d$cluster <- c$cluster
d$cluster


ggplot(d, aes(x = age, fill = as.character(cluster))) +
  geom_bar(show.legend = FALSE) +
  facet_wrap(cluster ~ ., nrow = 3, ncol = 1) +
  scale_fill_okabeito() +
  theme_bw()

ggsave('clust-age.svg', height = 4.5, width = 4)


d |>
  select(cluster, ends_with('ever'), ends_with('year'), ends_with('week')) |>
  group_by(cluster) |>
  summarize(across(everything(), mean)) |>
  pivot_longer(-cluster, names_to = 'drug', values_to = 'p') |>
  ggplot(aes(y = drug, x = p, fill = as.character(cluster))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(cluster ~ ., ncol = 1) +
  scale_fill_okabeito() +
  labs(y = NULL) +
  theme_bw()

ggsave('clust-drugs.svg', height = 4.5, width = 4)


d_dist <- dist(d_clust, method = 'euclidean')

c_complete <- hclust(d_dist, method = 'complete')
c_single <- hclust(d_dist, method = 'single')

plot(c_complete)
plot(c_single)

fviz_dend(c_complete)
ggsave('hclust-complete.svg', height = 4.5, width = 4)


fviz_dend(c_single)
ggsave('hclust-single.svg', height = 4.5, width = 4)
