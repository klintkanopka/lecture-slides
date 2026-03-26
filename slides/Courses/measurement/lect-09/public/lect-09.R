library(tidyverse)
library(see)
library(fpc)
library(mclust)
library(factoextra)
library(ggdendro)
library(GGally)
library(svglite)


setwd('~/projects/lecture-slides/slides/Courses/measurement/lect-09/public/')
d <- read_csv('country-data.csv')

d_std <- d |>
  select(-country) |>
  mutate(across(everything(), ~ scale(.x)[, 1]))

ks <- 1:10
wcss <- vector('numeric', length(ks))

for (k in ks) {
  wcss[k] <- kmeans(d_std, k, iter.max = 1e4, nstart = 1e4)$tot.withinss
}

data.frame(k = ks, wcss = wcss) |>
  ggplot(aes(x = k, y = wcss)) +
  geom_point(color = okabeito_colors(3)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()

ggsave('k-means-elbow.svg', width = 4, height = 4.5)

clust_sol <- kmeans(d_std, 4, iter.max = 1e4, nstart = 1e4)

clust_sol$centers

d$cluster <- clust_sol$cluster

d$country[d$cluster == 1]
d$country[d$cluster == 2]
d$country[d$cluster == 3]
d$country[d$cluster == 4]

# hclust version

d_euc <- dist(d_std)

hc_complete <- hclust(d_euc, method = 'complete')
hc_single <- hclust(d_euc, method = 'single')

ggdendrogram(hc_single) +
  theme_bw()

ggsave('single-dendro.svg', height = 4.5, width = 4)


single_linkage <- data.frame(
  k = 1:length(hc_single$height),
  height = rev(hc_single$height)
)

ggplot(single_linkage, aes(x = k, y = height)) +
  geom_point(color = okabeito_colors(3)) +
  geom_line(color = okabeito_colors(3)) +
  theme_bw()

ggsave('single-height.svg', height = 4.5, width = 4)


d$clust_single <- cutree(hc_single, k = 7)

d$country[d$clust_single == 1]
d$country[d$clust_single == 2]
d$country[d$clust_single == 3]
d$country[d$clust_single == 4]
d$country[d$clust_single == 5]
d$country[d$clust_single == 6]
d$country[d$clust_single == 7]

ggpairs(
  d,
  mapping = aes(
    color = as.character(cluster),
    fill = as.character(cluster),
    alpha = 0.3
  ),
  columns = 2:10
) +
  scale_color_okabeito() +
  scale_fill_okabeito() +
  theme_bw()

ggsave('pairs-plot.svg', height = 9, width = 8)


clust_dbscan <- dbscan(d_std, MinPts = 5, eps = 1)
clust_dbscan
d$cluster_dbscan <- clust_dbscan$cluster

table(d$cluster, d$cluster_dbscan)

d |>
  dplyr::count(cluster, cluster_dbscan) |>
  ggplot(aes(x = cluster, y = cluster_dbscan, size = n)) +
  geom_point(color = okabeito_colors(3)) +
  theme_bw()

ggsave('dbscan-count.svg', height = 4.5, width = 4)


# model based clustering

d_quant <- d[, 2:10]
gmm <- Mclust(d_quant)

gmm$classification


svglite("gmm-bic.svg", width = 4, height = 4.5)
plot(gmm, what = 'BIC')
dev.off()

svglite("gmm-class.svg", width = 4, height = 4.5)
plot(gmm, what = 'classification')
dev.off()

svglite("gmm-uncertainty.svg", width = 4, height = 4.5)
plot(gmm, what = 'uncertainty')
dev.off()

svglite("gmm-density.svg", width = 4, height = 4.5)
plot(gmm, what = 'density')
dev.off()
