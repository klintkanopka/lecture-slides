---
level: 1
layout: section
---

# Simulating Multilevel Data

---
level: 2
hideInToc: true
---

# The Setup

<v-clicks depth="2">

- We have 9 classrooms, each with a different teacher
- Each teacher has 30 students
- Students were given a math test
- We got their scores!
- We also got how many hours each student reported studying for the test!
- Let's take a look...

</v-clicks>


---
level: 3
layout: image-right
image: /sim-1.svg
---

# Looking at the data

```r
ggplot(d, aes(x = study_time, y = score)) +
  geom_point() +
  guides(color = 'none') +
  theme_bw()
```
<v-clicks>

- What do you see happening?
- Is studying associated with better scores?

</v-clicks>

---
level: 3
layout: image-right
image: /sim-2.svg
---

# Looking at the data

```r
ggplot(d, aes(x = study_time, y = score)) +
  geom_point() +
  geom_smooth(method = 'lm', se = F) +
  guides(color = 'none') +
  theme_bw()
```
<v-clicks>

- On average, studying helps!

</v-clicks>

---
level: 3
layout: image-right
image: /sim-3.svg
---

# Does classroom assignment matter?

```r
ggplot(d, aes(x = study_time, y = score,
       color = as.character(classroom))) +
  geom_point() +
  scale_color_okabeito() +
  guides(color = 'none') +
  theme_bw()
```
<v-clicks>

- What about variation between classrooms?
- Does the grouping make a difference?

</v-clicks>

---
level: 3
layout: image-right
image: /sim-4.svg
---

# Does classroom assignment matter?

```r
ggplot(d, aes(x=study_time, y=score,
       color=as.character(classroom))) +
  geom_point() +
  geom_smooth(method='lm', se=F) +
  scale_color_okabeito() +
  guides(color='none') +
  theme_bw()
```
<v-clicks depth="2">

- It seems that classroom matters a lot!
- How can you model this?
  - Consider a version that uses only _fixed effects_
  - Consider a version that uses _random effects_
  - How many parameters does each estimate?

</v-clicks>


---
level: 3
---

# Simulating Multilevel Data

- What does a data generating process look like for something like this?



````md magic-move
```r
set.seed(242424)
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
d$study_time <- sample(0:5, 9*30, replace=T)
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
d$study_time <- sample(0:5, 9*30, replace=T)

# make a dataframe for group characteristics
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
d$study_time <- sample(0:5, 9*30, replace=T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
d$study_time <- sample(0:5, 9*30, replace=T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
d_classroom$teacher_effect <- rnorm(9, mean = 30, sd = 20)
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
d$study_time <- sample(0:5, 9*30, replace=T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
d_classroom$teacher_effect <- rnorm(9, mean = 30, sd = 20)
d_classroom$teacher_factor <- rnorm(9, 1, 2)
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
d$study_time <- sample(0:5, 9*30, replace=T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
d_classroom$teacher_effect <- rnorm(9, mean = 30, sd = 20)
d_classroom$teacher_factor <- rnorm(9, 1, 2)

# join them together - left join group to individuals
```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
d$study_time <- sample(0:5, 9*30, replace=T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
d_classroom$teacher_effect <- rnorm(9, mean = 30, sd = 20)
d_classroom$teacher_factor <- rnorm(9, 1, 2)

# join them together - left join group to individuals
d <- left_join(d, d_classroom, by = 'classroom')

```
```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
d$study_time <- sample(0:5, 9*30, replace=T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
d_classroom$teacher_effect <- rnorm(9, mean = 30, sd = 20)
d_classroom$teacher_factor <- rnorm(9, 1, 2)

# join them together - left join group to individuals
d <- left_join(d, d_classroom, by = 'classroom')

# generate your outcome variable, don't forget to add noise!
```

```r
set.seed(242424)

# simulate data for individuals, assign to groups
d <- data.frame(student_id = 1:(9*30))
d$classroom <- rep(1:9, each=30)
d$study_time <- sample(0:5, 9*30, replace=T)

# make a dataframe for group characteristics
d_classroom <- data.frame(classroom = 1:9)
d_classroom$teacher_effect <- rnorm(9, mean = 30, sd = 20)
d_classroom$teacher_factor <- rnorm(9, 1, 2)

# join them together - left join group to individuals
d <- left_join(d, d_classroom, by = 'classroom')

# generate your outcome variable, don't forget to add noise!
d$score <- d$teacher_effect + 10*d$teacher_factor*d$study_time + rnorm(nrow(d), mean = 0, sd = 10)
```
````

---
level: 3
---

# Estimating MLMs

For each of the following models:

1. What is it estimating?
2. Fit the model in `R`
3. Look at the `summary()`
4. How do you interpret the parameters?

```r
lm(score ~ study_time, data = d)

lm(score ~ study_time + as.character(classroom), data = d)

lmer(score ~ study_time + (1|classroom) + study_time, data = d)

lm(score ~ as.character(classroom)*study_time, data=d)

lmer(score ~ study_time + (1 + study_time | classroom), data = d)
```