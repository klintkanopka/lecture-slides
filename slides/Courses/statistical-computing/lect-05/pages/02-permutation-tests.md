---
level: 1
layout: section
---

# Tools

---
level: 2
layout: section
---

# Randomization

---
level: 3
---

# Randomization

- Some problems are hard to solve in a straightforward way
  - The function to optimize could be really tricky
  - The search space could be really huge
  - There might be an easier solution, but you don’t know what it is
  - No clean closed form solution may exist!
- For these cases, we can leverage randomization to get _approximate_ solutions
  - If we are willing to invest more time, we can get more precise solutions
- Are there downsides?
  - Can be slooooooooooooooooooooooooooooooooooooow
  - It can be guaranteed that you will eventually find the right answer, but sometimes there is no guarantee on _when_
  - Sometimes having a nice closed form solution is what you actually need
- If you have a better choice, typically you want to use that!

---
level: 2
layout: section
---

# Lady Tasting Tea Experiment

<div v-click>

## Content warning: This is the most British experiment ever

</div>


---
level: 3
layout: image-right
image: /bristol.jpg
---

#  Muriel Bristol (1888-1950)
  
- British phycologist <v-click>(studied algae)</v-click>
<div v-click> 

- Claimed she can tell _by taste alone_ if a cup of tea was made by pouring milk into tea or tea into milk 

</div>

---
level: 3
layout: image-right
image: /fisher.jpg
---

# Ronald Fisher (1890-1962)

- British statistician, biologist, and geneticist

<v-clicks>

- Called the "greatest statistician of all time"
- Noted eugenicist
- Thought Bristol's claim was nuts, so devised an experiment to test her tea-tasting ability

</v-clicks>

---
level: 3
---

# The Lady Tasting Tea Experiment

<div v-click>

## Step 1: Pour eight cups of tea, with four having milk added first and four having tea added first

</div><div v-click>

## Step 2: Cups are presented in a random order, and Muriel has to identify them

</div>
<div v-click>

## Question: Assuming she does not have any special ability and randomly guessed, what is the probability she would get all eight correct?

</div>



---
level: 3
---

# Quick Aside: Combinatorics

- *Combinatorics* is concerned with (among other things) counting
- Today, we need to think about counting _combinations_ of items from a set

<div v-click>

For a set of $n$ items, the number of ways to select $k$ elements is:
  
$$\binom{n}{k} = \frac{n!}{k!(n-k)!}$$

</div>

---
level: 3
--- 

# Lady Tasting Tea Experiment

- How many possible ways can you select four "tea before milk" cups from eight?

$$\binom{8}{4} = \frac{8!}{4!(8-4)!} = \frac{1 \cdot 2\cdot 3 \cdot 4 \cdot 5 \cdot 6 \cdot 7 \cdot 8}{(1 \cdot 2\cdot 3 \cdot 4)(1 \cdot 2\cdot 3 \cdot 4)} = 70$$

- There's only one way to get them all right, so we can find the probability assuming she's randomly guessing (the null hypothesis of no ability)

$$P(\text{All correct}) = \frac{1}{70} \approx 1.43\%$$

- _Fisher's Exact Test_ is a method to build the exact distribution of possible outcomes, so we get an exact $p$-value for any outcome

---
level: 3
---

# Fisher's Exact Test

- Enumerate all possible outcomes
- Compute the probability of each number of successes
- Look at the distribution and compute $p$-values

<div v-click>

| Successes | Combinations | $p$-value |
|:---------:|--------------|-----------|
|0| $\binom{4}{0} \times \binom{4}{4} = 1$  | 1.0000 |
|1| $\binom{4}{1} \times \binom{4}{3} = 16$ | 0.9857 |
|2| $\binom{4}{2} \times \binom{4}{2} = 36$ | 0.4286 |
|3| $\binom{4}{3} \times \binom{4}{1} = 16$ | 0.2429 |
|4| $\binom{4}{4} \times \binom{4}{0} = 1$  | 0.0143 |

</div>

---
level: 2
layout: section
---

# Permutation Tests

---
level: 3
---

# Permutation Tests

- Permutation tests are a form of exact test used when comparing two separate samples
- Often you want to know if two samples came from two different distributions (they have different means, or different variances, or something else)
- Permutation tests are similar to Fisher’s exact test, but we look at the value we want to test against a distribution constructed from _every possible permutation of group assignments_

---
level: 3
---

# Permutation Tests

- Say I have test scores from two groups of ten students, and group one has a higher mean score
- I want to say if I really think group one is higher ability than group two
- I divide the pool of 20 students into two even groups in every possible way 
  - 184,756 possible group assignments
- I compute the difference in mean score between the two groups
- I see if the original difference is extreme relative to the distribution of possible differences!

---
level: 3
---

# Permutation Tests

1. Figure out every possible group assignment in your data
2. Compute the summary statistic of interest for each possible group assignment
3. Find the probability of the statistic being that value (or more extreme) from this distribution


---
level: 3
---

# Permutation Tests

- *Upside*: The answer is correct!
- *Downside*: If you have 40 objects evenly divided into two groups, there are well over 2 billion possible group assignments, so this usually doesn’t work well at all
- So, what if we just... didn't?
- Big idea: Permutation test and other types of exact tests are just way too much work for datasets of any reasonable size
- The numbers of permutations are often too large for computers to deal with
- So, what if we started doing a permutation test, and then just stopped part way through?
- We can instead _sample_ from possible permutations
- Randomly sampling from our data will eventually converge to the true answer
- Note that _eventually_ is doing some work here

---
level: 2
layout: section
---

# Monte Carlo Methods

---
level: 3
layout: image
image: /monte-carlo.jpeg
---

---
level: 3
---

# Monte Carlo Methods

- Leverages the fact that randomly sampling from your data will converge to the true answer
- Works in _tons_ of situations
- General task:
  1. Specify the possible inputs
  2. Randomly sample from the possible inputs
  3. Perform some calculation on each sample
  4. Repeat a bunch of times 
  5. Aggregate the results
  
---
level: 3
---

# Monte Carlo Permutation Test


Remember the test scores from two groups of students, where group one had a higher mean score?

1. Randomly sample from the possible group assignments
2. Compute mean differences
3. Repeat a bunch of times
4. Look at the distribution

---
level: 3
---

# Monte Carlo Permutation Test

````md magic-move
```r
set.seed(215)
test_data <- data.frame(group = rep(c('A', 'B'), each=10),
                        score = c(round(rnorm(10, mean=90, sd=5)),
                                  round(rnorm(10, mean=75, sd=15))))
true_diff <- mean(test_data$score[test_data$group=='A']) - mean(test_data$score[test_data$group=='B'])

true_diff
```

```r
set.seed(215)
test_data <- data.frame(group = rep(c('A', 'B'), each=10),
                        score = c(round(rnorm(10, mean=90, sd=5)),
                                  round(rnorm(10, mean=75, sd=15))))
true_diff <- mean(test_data$score[test_data$group=='A']) - mean(test_data$score[test_data$group=='B'])

true_diff

# [1] 9
```
````

---
level: 3
layout: image-right
image: /test-01.png
---

# Monte Carlo Permutation Test

```r
ggplot(test_data, 
       aes(x = score, fill = group)) +
  geom_histogram() +
  facet_grid(group ~ .) +
  scale_fill_okabeito() +
  theme_bw()
```

---
level: 3
---

# Monte Carlo Permutation Test


````md magic-move
```r
ReassignScores <- function(data){
  # TODO: Reassign groups
  # TODO: Compute means
  # TODO: Return difference in means
  mean_diff <- NA
  return(mean_diff)
}

```

```r
ReassignScores <- function(data){
  # TODO: Reassign groups
  new_groups <- sample(data[['group']])
  # TODO: Compute means
  # TODO: Return difference in means
  mean_diff <- NA
  return(mean_diff)
}

```

```r
ReassignScores <- function(data){
  
  # TODO: Reassign groups
  new_groups <- sample(data[['group']])
  
  # TODO: Compute means
  mean_A <- mean(data[['score']][new_groups == 'A'])
  mean_B <- mean(data[['score']][new_groups == 'B'])

  # TODO: Return difference in means
  mean_diff <- NA
  return(mean_diff)
}

```
```r
ReassignScores <- function(data){
  
  # TODO: Reassign groups
  new_groups <- sample(data[['group']])
  
  # TODO: Compute means
  mean_A <- mean(data[['score']][new_groups == 'A'])
  mean_B <- mean(data[['score']][new_groups == 'B'])

  # TODO: Return difference in means
  mean_diff <- mean_A - mean_B
  return(mean_diff)
}
```
```r
ReassignScores <- function(data){
  
  # TODO: Reassign groups
  new_groups <- sample(data[['group']])
  
  # TODO: Compute means
  mean_A <- mean(data[['score']][new_groups == 'A'])
  mean_B <- mean(data[['score']][new_groups == 'B'])

  # TODO: Return difference in means
  mean_diff <- mean_A - mean_B
  return(mean_diff)
}

ReassignScores(test_data)
```
```r
ReassignScores <- function(data){
  
  # TODO: Reassign groups
  new_groups <- sample(data[['group']])
  
  # TODO: Compute means
  mean_A <- mean(data[['score']][new_groups == 'A'])
  mean_B <- mean(data[['score']][new_groups == 'B'])

  # TODO: Return difference in means
  mean_diff <- mean_A - mean_B
  return(mean_diff)
}

ReassignScores(test_data)

# [1] -0.2
```
````


---
level: 3
layout: image-right
image: /test-02.png
---

# Monte Carlo Permutation Test

```r
mean_diff <- 
  replicate(1e4, ReassignScores(test_data))

mean(mean_diff >= true_diff)

# [1] 0.1015

data.frame(mean_diff=mean_diff) |> 
  ggplot(aes(x=mean_diff)) +
  geom_histogram(alpha = 0.7, 
                 color = 'black', 
                 bins = 20) +
  geom_vline(aes(xintercept=true_diff), 
                 linewidth = 2,
                 color='deepskyblue') +
  theme_bw()
```


---
level: 3
---

# Monte Carlo Permutation Test

````md magic-move
```r
test_data <- data.frame(group = rep(c('A', 'B'), each=1e4),
                        score = c(round(rnorm(1e4, mean=90, sd=5)),
                                  round(rnorm(1e4, mean=75, sd=15))))
true_diff <- mean(test_data$score[test_data=='A']) - mean(test_data$score[test_data=='B'])

true_diff
```
```r
test_data <- data.frame(group = rep(c('A', 'B'), each=1e4),
                        score = c(round(rnorm(1e4, mean=90, sd=5)),
                                  round(rnorm(1e4, mean=75, sd=15))))
true_diff <- mean(test_data$score[test_data$group=='A']) - mean(test_data$score[test_data$group=='B'])

true_diff

# [1] 15.1591
```
````

---
level: 3
layout: image-right
image: /test-03.png
---

# Monte Carlo Permutation Test

```r
ggplot(test_data, 
       aes(x = score, fill = group)) +
  geom_histogram(bins = 40) +
  facet_grid(group ~ .) +
  scale_fill_okabeito() +
  theme_bw()
```


---
level: 3
layout: image-right
image: /test-04.png
---

# Monte Carlo Permutation Test

```r
mean_diff <- 
  replicate(1e4, ReassignScores(test_data))

mean(mean_diff >= true_diff)

# [1] 0

data.frame(mean_diff=mean_diff) |> 
  ggplot(aes(x=mean_diff)) +
  geom_histogram(alpha = 0.7, 
                 color = 'black', 
                 bins = 20) +
  geom_vline(aes(xintercept=true_diff), 
                 linewidth = 2,
                 color='deepskyblue') +
  theme_bw()
```
