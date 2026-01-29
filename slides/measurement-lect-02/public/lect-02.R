library(tidyverse)
library(see)

setwd('~/projects/lecture-slides/slides/measurement-lect-02/public/')

set.seed(242424)

d <- readRDS('animalfights_clean.rds')


d_long <- d |>
  pivot_longer(
    cols = starts_with('d_'),
    names_to = 'item',
    values_to = 'resp'
  )

# sum score

sum_scores <- d_long |>
  group_by(id) |>
  summarize(sum_score = sum(resp))

ggplot(sum_scores, aes(x = sum_score)) +
  geom_histogram(
    bins = 10,
    color = 'black',
    fill = okabeito_colors(3)
  ) +
  theme_bw()

ggsave('animal_sum_scores.svg', height = 4.5, width = 4)

# difficulties

diff <- d_long |>
  group_by(item) |>
  summarize(p = mean(resp))

ggplot(diff, aes(x = p, y = reorder(item, p))) +
  geom_point(
    color = okabeito_colors(3)
  ) +
  labs(x = 'p-value', y = 'item') +
  theme_bw()

ggsave('animal_difficulty.svg', height = 4.5, width = 4)

# discrimination

disc <- left_join(d_long, sum_scores, by = 'id') |>
  mutate(adjusted_sum_score = sum_score - resp) |>
  group_by(item) |>
  summarize(a = cor(resp, adjusted_sum_score))

ggplot(disc, aes(x = a, y = reorder(item, a))) +
  geom_point(
    color = okabeito_colors(3)
  ) +
  labs(x = 'discrimination', y = 'item') +
  theme_bw()

ggsave('animal_discrimination.svg', height = 4.5, width = 4)

d_long |>
  left_join(sum_scores, by = 'id') |>
  mutate(adjusted_sum_score = sum_score - resp) |>
  filter(item == 'd_king_cobra') |>
  lm(resp ~ gender + adjusted_sum_score, data = _) |>
  summary()


## PCA

library(FactoMineR)
library(factoextra)
library(knitr)

resp <- select(d, starts_with('d_'))
pca <- PCA(resp, ncp = 3, graph = FALSE)

# extract eigenvalue information
pca_eig <- data.frame(pca$eig) |>
  rownames_to_column('dimension')

# extract dimensions
pca_dim <- data.frame(pca$var$coord) |>
  rownames_to_column(var = 'item')

# extract individuals
pca_resp <- data.frame(pca$ind$coord) |>
  rownames_to_column(var = 'person')

kable(pca_eig)


pca_eig |>
  head(7) |>
  ggplot(aes(
    x = dimension,
    y = percentage.of.variance
  )) +
  geom_col(fill = okabeito_colors(3)) +
  labs(x = 'PC') +
  theme_bw()

ggsave('elbow-plot.svg', height = 4.5, width = 4)


kable(pca_dim)

kable(head(pca_resp, 5))

ggplot(pca_dim, aes(x = Dim.1, y = reorder(item, Dim.1))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, color = okabeito_colors(3)) +
  labs(x = 'Loading', y = 'Item') +
  theme_bw()

ggsave('pca-dim-1.svg', height = 4.5, width = 4)


ggplot(pca_dim, aes(x = Dim.2, y = reorder(item, Dim.2))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, color = okabeito_colors(3)) +
  labs(x = 'Loading', y = 'Item') +
  theme_bw()

ggsave('pca-dim-2.svg', height = 4.5, width = 4)


ggplot(pca_dim, aes(x = Dim.3, y = reorder(item, Dim.3))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, color = okabeito_colors(3)) +
  labs(x = 'Loading', y = 'Item') +
  theme_bw()

ggsave('pca-dim-3.svg', height = 4.5, width = 4)

ggplot(pca_resp, aes(x = Dim.1, y = Dim.2)) +
  geom_point(alpha = 0.8, size = 1, color = okabeito_colors(2)) +
  theme_bw()

ggsave('pca-individuals.svg', height = 4.5, width = 4)


## Estimating Factor Analysis

library(psych)

# Check the documentation - it's intense!
?fa

efa_1 <- fa(resp, nfactors = 1, rotate = 'oblimin')
efa_2 <- fa(resp, nfactors = 2, rotate = 'oblimin')
efa_3 <- fa(resp, nfactors = 3, rotate = 'oblimin')

## One Factor Solution
efa_1$Vaccounted

## Two Factor Solution
efa_2$Vaccounted

## Three Factor Solution
efa_3$Vaccounted

## Selecting Number of Factors

fa_eigenvalues <- data.frame(factors = 1:6, eigenvalues = efa_3$e.values[1:6])

## Selecting Number of Factors

ggplot(fa_eigenvalues, aes(x = factors, y = eigenvalues)) +
  geom_col(fill = okabeito_colors(3)) +
  geom_point(size = 3) +
  geom_line() +
  geom_hline(aes(yintercept = 1), lty = 2) +
  theme_bw()

ggsave('fa-elbow-plot.svg', height = 4.5, width = 4)


## Looking at the Three Factor Solution

efa <- data.frame(efa_3$weights) |>
  rownames_to_column(var = 'item')

## Factor 1 Loadings

ggplot(efa, aes(x = MR1, y = reorder(item, MR1))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, color = okabeito_colors(3)) +
  labs(y = 'item', x = 'factor loading') +
  theme_bw()

ggsave('fa-factor-1.svg', height = 4.5, width = 4)


## Factor 2 Loadings

ggplot(efa, aes(x = MR2, y = reorder(item, MR2))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, color = okabeito_colors(3)) +
  labs(y = 'item') +
  theme_bw()

ggsave('fa-factor-2.svg', height = 4.5, width = 4)

## Factor 3 Loadings

ggplot(efa, aes(x = MR3, y = reorder(item, MR3))) +
  geom_vline(aes(xintercept = 0), lty = 2) +
  geom_point(size = 3, color = okabeito_colors(3)) +
  labs(y = 'item', x = 'factor loading') +
  theme_bw()

ggsave('fa-factor-3.svg', height = 4.5, width = 4)
