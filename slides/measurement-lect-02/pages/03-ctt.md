---
level: 1
layout: section
---

# Classical Test Theory Practice

---
level: 2
hideInToc: true
---

# More Item Response Data

- The dataset `animalfights_clean.rds` (downloadable [here](https://raw.githubusercontent.com/klintkanopka/lecture-slides/refs/heads/main/slides/measurement-lect-01/public/frac20_noq.csv)) is a pre-cleaned version of the data from PS0. 
- In a group of $3 \pm 1$ take ten minutes to:
  1. Compute the ability (sum score) for each respondent and plot a distribution
  2. Compute the difficulty ($p$-value) for each item and plot them in order of difficulty
  3. Compute the discrimination (item-total correlation) for each item and plot them in order
  4. Check the item `d_king_cobra` for DIF by gender


---
level: 3
layout: image-right
image: /animal_sum_scores.svg
---

# Sum Score

```r
d <- readRDS('animalfights_clean.rds')

d_long <- d |>  
  pivot_longer(
    cols = starts_with('d_'),
    names_to = 'item',
    values_to = 'resp'
  )

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
```


---
level: 3
layout: image-right
image: /animal_difficulty.svg
---

# $p$-value

```r
diff <- d_long |>
  group_by(item) |>
  summarize(p = mean(resp))

ggplot(diff, aes(x = p, y = reorder(item, p))) +
  geom_point(
    color = okabeito_colors(3)
  ) +
  labs(x = 'p-value', y = 'item') +
  theme_bw()
```

---
level: 3
layout: image-right
image: /animal_discrimination.svg
---

# Item-Total Correlation

```r
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
```
---
level: 2
---

# Differential Item Functioning

- Regression:

```r
d_long |> 
  left_join(sum_scores, by = 'id') |>
  mutate(adjusted_sum_score = sum_score - resp) |> 
  filter(item == 'd_king_cobra') |> 
  lm(resp ~ gender + adjusted_sum_score, data= _) |> 
  summary()
```

- Output:

```
Residuals:
     Min       1Q   Median       3Q      Max 
-0.66917 -0.20893 -0.09386  0.05007  0.99254 

Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)        -0.107599   0.017667  -6.091 1.51e-09 ***
genderM             0.086401   0.018991   4.550 5.91e-06 ***
adjusted_sum_score  0.057531   0.003625  15.870  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```

---
level: 1
layout: section
---

# Break