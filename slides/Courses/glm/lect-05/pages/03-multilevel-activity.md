---
level: 1
layout: section
---

# Working with Multilevel Data

---
level: 2
---

# Exploring the Data

- Download [`lect-05-data.csv`](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/glm/lect-05/public/lect-05-data.csv)
- First:
  1. How many students are there?
  2. How many teachers are there?
  3. How many schools are there?
  4. Visualize the distribution of students per teacher
  5. Visualize the distribution of teachers per school
  6. Visualize the distribution of students per school
- For each variable (except the `_id` variables):
  1. Determine if it is measured at the student, teacher, or school level
  2. Visualize the distribution


---
level: 3
layout: image-right
image: /mlm-1.svg
---

# Students per Teacher

```r
d_sim |>
  count(teacher_id) |>
  ggplot(aes(x = n)) +
  geom_histogram(
    bins = 20,
    fill = okabeito_colors(3)) +
  theme_bw()
```


---
level: 3
layout: image-right
image: /mlm-2.svg
---

# Students per School

```r
d_sim |>
  count(school_id) |>
  ggplot(aes(x = n)) +
  geom_histogram(
    bins = 20,
    fill = okabeito_colors(3)) +
  theme_bw()
```


---
level: 3
layout: image-right
image: /mlm-3.svg
---

# Teachers per School

```r
d_sim |>
  select(teacher_id, school_id) |>
  distinct() |>
  count(school_id) |>
  ggplot(aes(x = n)) +
  geom_histogram(
    bins = 10,
    fill = okabeito_colors(3)) +
  theme_bw()
```


---
level: 3
layout: image-right
image: /mlm-4.svg
---

# Debate Team

```r
 ggplot(d_sim, aes(x = debate_team)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mlm-5.svg
---

# Basketball Team

```r
 ggplot(d_sim, aes(x = basketball_team)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mlm-6.svg
---

# Only Child

```r
 ggplot(d_sim, aes(x = only_child)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mlm-7.svg
---

# Years of Experience

```r
d_sim |>
  select(teacher_id, years_experience) |>
  distinct() |>
  ggplot(aes(x = years_experience)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mlm-8.svg
---

# Class Size

```r
d_sim |>
  select(teacher_id, class_size) |>
  distinct() |>
  ggplot(aes(x = class_size)) +
  geom_bar(fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mlm-9.svg
---

# Percent Free/Reduced Price Lunch

```r
d_sim |>
  select(school_id, pct_frl) |>
  distinct() |>
  ggplot(aes(x = pct_frl)) +
  geom_histogram(
    bins = 15,
    fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mlm-10.svg
---

# Percent English Language Learners

```r
d_sim |>
  select(school_id, pct_ell) |>
  distinct() |>
  ggplot(aes(x = pct_ell)) +
  geom_histogram(
    bins = 15,
    fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mlm-11.svg
---

# Pretest Score

```r
ggplot(d_sim, aes(x = pretest)) +
  geom_histogram(
    bins = 20,
    fill = okabeito_colors(3)) +
  theme_bw()
```

---
level: 3
layout: image-right
image: /mlm-12.svg
---

# Posttest Score

```r
ggplot(d_sim, aes(x = posttest)) +
  geom_histogram(
    bins = 20,
    fill = okabeito_colors(3)) +
  theme_bw()
```


---
level: 2
---

# Thinking about Modeling

- For each variable (except the `_id` variables and `posttest`):
  1. If we include that variable in a regression with `posttest` as the outcome, how do we interpret the estimated coefficient?
  2. Can you include a random slope on that variable by teacher? If so, what does that mean? If not, why?
  3. Can you include a random slope on that variable by school? If so, what does that mean? If not, why?
- What does a random intercept by teacher do? How do you interpret that?
- What does a random intercept by school do? How do you interpret that?


---
level: 3
---

# Developing, Fitting, and Interpreting Multilevel Models

<v-clicks>

- We build multilevel models one step at a time
- Typically, start from a linear regression
- Add random effects one at a time and check model fit
- Adding some random effects will cause the model to not converge!
- Adding some other random effects won't improve the model at all
- Sometimes you may need to recheck effects you tried earlier after adding some other effects to the model
- One way to check for model fit is using `anova()`
- **I'll post my code after class, but you should attempt to follow along and take notes!**

</v-clicks>