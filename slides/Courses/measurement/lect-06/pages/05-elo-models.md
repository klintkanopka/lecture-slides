---
level: 2
---

# Elo Models

- Used in chess and other competitive sports

<v-click>

- We think the probability of winning is related to the difference in two players' abilities

$$P(A \text{ defeats }B|\theta_A,\theta_B) = \frac{1}{1+\exp\big(-k(\theta_A - \theta_B)\big)}$$

</v-click>
<v-click>

- Here, $k$ is just a scaling factor that is preselected to work with the desired $\theta$ scale

</v-click>
<v-click>

- This functional form allows for making updates to individual abilities after each competition like this:

$$ \theta_A^{i+1} = \theta_A^i + k\big(X_{AB} - P(x_{AB}=1)\big) $$

</v-click>
<v-click>

- Note that $k$ sets the scale and adjustments to abilities are small if the win was a "sure thing" and huge if the win was an upset!

</v-click>

---
level: 3
---

# Back to Squash

- Turns out, `mirt` doesn't have an item type for Elo models
- We can, however, estimate this ourselves!
- The plan:
    - Write out a log likelihood function
    - Use `optim()` to find the solutions
    - Feel free to download my code [here](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/measurement-lect-06/public/lect-06.R)

````md magic-move
```r
```
```r
LogLikMatch <- function() {
}
```
```r
LogLikMatch <- function() {
  return(ll)
}
```
```r
LogLikMatch <- function(data, theta) {
  return(ll)
}
```
```r
LogLikMatch <- function(data, theta) {
  p <- plogis(theta[data$player_1] - theta[data$player_2])
  return(ll)
}
```
```r
LogLikMatch <- function(data, theta) {
  p <- plogis(theta[data$player_1] - theta[data$player_2])
  ll <- sum(data$result * log(p) + (1 - data$result) * log(1 - p))
  return(ll)
}
```
```r
LogLikMatch <- function(data, theta) {
  p <- plogis(theta[data$player_1] - theta[data$player_2])
  ll <- sum(data$result * log(p) + (1 - data$result) * log(1 - p))
  return(ll)
}
```
````

---
level: 3
---

# Estimating the Model


- Using a single call to `optim()`, we can estimate all of our model parameters:

```r
sol <- optim(
  starting_theta,
  LogLikMatch,
  data = d,
  method = 'L-BFGS-B',
  lower = -3,
  upper = 3,
  control = list(fnscale = -1, maxit = 1e6)
)
```
---
level: 3
---

# Build an Output Object

````md magic-move
```r

```
```r
tmp <- d |>
  mutate(win = if_else(result == 1, player_1, player_2)) |>
  mutate(loss = if_else(result == 0, player_1, player_2))

```
```r
tmp <- d |>
  mutate(win = if_else(result == 1, player_1, player_2)) |>
  mutate(loss = if_else(result == 0, player_1, player_2))

wins <- tmp |>
  count(win) |>
  select(player = win, wins = n)

```
```r
tmp <- d |>
  mutate(win = if_else(result == 1, player_1, player_2)) |>
  mutate(loss = if_else(result == 0, player_1, player_2))

wins <- tmp |>
  count(win) |>
  select(player = win, wins = n)

losses <- tmp |>
  count(loss) |>
  select(player = loss, losses = n)

```
```r
tmp <- d |>
  mutate(win = if_else(result == 1, player_1, player_2)) |>
  mutate(loss = if_else(result == 0, player_1, player_2))

wins <- tmp |>
  count(win) |>
  select(player = win, wins = n)

losses <- tmp |>
  count(loss) |>
  select(player = loss, losses = n)

tot <- full_join(wins, losses, by = 'player') |>
  arrange(player)

```
```r
tmp <- d |>
  mutate(win = if_else(result == 1, player_1, player_2)) |>
  mutate(loss = if_else(result == 0, player_1, player_2))

wins <- tmp |>
  count(win) |>
  select(player = win, wins = n)

losses <- tmp |>
  count(loss) |>
  select(player = loss, losses = n)

tot <- full_join(wins, losses, by = 'player') |>
  arrange(player)

tot[is.na(tot)] <- 0

```
```r
tmp <- d |>
  mutate(win = if_else(result == 1, player_1, player_2)) |>
  mutate(loss = if_else(result == 0, player_1, player_2))

wins <- tmp |>
  count(win) |>
  select(player = win, wins = n)

losses <- tmp |>
  count(loss) |>
  select(player = loss, losses = n)

tot <- full_join(wins, losses, by = 'player') |>
  arrange(player)

tot[is.na(tot)] <- 0

tot <- tot |>
  mutate(p = wins / (wins + losses), 
         theta = sol$par, 
         n = wins + losses)

```
````

---
level: 3
layout: image-right
image: /elo-output.svg
---

# Visualizing the Solution

```r
ggplot(tot, aes(x = p, y = theta, color = n)) +
  scale_color_viridis_c() +
  geom_point() +
  theme_bw()

cor(tot$p, tot$theta)
```

```
[1] 0.9686027
```
