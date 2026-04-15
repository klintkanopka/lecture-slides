---
level: 1
layout: section
---

# Process Data

---
level: 2
hideInToc: true
---

# Process Data

<v-clicks depth="2">

- Until now we have mostly focused on item responses, which are _product data_
- Computer-based assessment also gives us _process data_
- This is behavioral information about what respondents are doing while they respond
- Examples:
  - Response time
  - Eye tracking
  - Keystroke logs
  - Heart rate
  - EEG or fMRI
  - Clickstream data
- Process data can help us measure new constructs, flag low effort responses, detect cheating, and more

</v-clicks>

---
level: 2
---

# Response Time Data

<v-clicks depth="2">

- Response time (`rt`) is the time it takes a respondent to answer an item
- This is different from response accuracy, which only records whether the answer was correct
- Response times are usually heavily skewed, so we often analyze $\log(rt)$
- Extremely large response times can reflect disengagement and may need to be filtered
- Extremely short response times may reflect rapid guessing
- Response time can tell us about person-item interactions, low effort responding, or be incorporated into item response models

</v-clicks>

---
level: 2
---

# Dealing with Response Time

<v-clicks depth="2">

- We will use [`roar_lexical.csv`](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/lect-11/public/roar_lexical.csv)
- This comes from a lexical decision task for elementary school students
  - Respondents decide whether a string is a real English word or a pseudoword
- The file includes:
  - `id`
  - stimulus item
  - response accuracy
  - response time
- Use response time to learn something about the task structure or response behavior

</v-clicks>


---
level: 3
layout: image-right
image: /rt-score.svg
---

# Mean Score by RT Quantile

```r
d <- read_csv('roar_lexical.csv') |>
  filter(rt <= 5)

d |>
  group_by(item) |>
  mutate(stdz_lrt = scale(log(rt))[, 1]) |>
  ungroup() |>
  group_by(id) |>
  summarize(score = mean(resp),
            mean_slrt = mean(stdz_lrt)) |>
  ungroup() |>
  mutate(bins = ntile(mean_slrt, 100)) |>
  group_by(bins) |>
  summarize(mean_score = mean(score)) |>
  ggplot(aes(x = bins, y = mean_score)) +
  geom_point() +
  geom_smooth(color = okabeito_colors(3),
              se = FALSE) +
  labs(x = 'response time quantile',
       y = 'mean score') +
  theme_bw()
```


---
level: 3
layout: image-right
image: /rt-itc.svg
---

# Discrimination by RT Quantile

```r
d <- read_csv('roar_lexical.csv') |>
  filter(rt <= 5)

d |>
  group_by(id) |>
  mutate(sum_score = sum(resp)) |>
  ungroup() |>
  mutate(adj_score = sum_score - resp) |>
  group_by(item) |>
  mutate(stdz_lrt = scale(log(rt))[, 1]) |>
  mutate(bins = ntile(stdz_lrt, 100)) |>
  group_by(bins) |>
  summarize(itc = cor(resp, adj_score)) |>
  ggplot(aes(x = bins, y = itc)) +
  geom_point() +
  geom_smooth(color = okabeito_colors(3),
              se = FALSE) +
  labs(x = 'response time quantile',
       y = 'item-total correlation') +
  theme_bw()
```
