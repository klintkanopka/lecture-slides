---
level: 2
transition: fade
---

# Table of Contents

<Toc text-sm minDepth="1" maxDepth="2"/>


---
level: 2
---

# Announcements

- PS4 is now late
  - Very spooky
  - How's it going?
- PS5 is up!
  - It's long
  - The code you write will take time to run



---
level: 3
---

# Check-In

- [PollEv.com/klintkanopka](https://PollEv.com/klintkanopka)


---
level: 2
layout: section
---

# A Very Important Problem

---
level: 3
---

# A Problem

## Klint now finds that he can make even more money by selling both hot dogs and actual dogs. He finds that his daily revenue for selling $x$ dozen hot dogs and $y$ dozen actual dogs is: 

$$R(x,y) = -5x^2 -8y^2-2xy+42x+102y$$

If he can only obtain 10 dozen of either item in a day, what should he prepare to maximize revenue?

<v-click>Four Potential Solutions:</v-click>

<v-clicks>

1. Find an analytic solution (calculus)
2. Reframe as an optimization problem and find a numeric solution (`optim()`)
3. Guess random numbers until you find the right answer (terrible idea)
4. A secret fourth thing!

</v-clicks>

---
level: 3
---

# A Solution We Know!

- We can write a function and maximize it to find the best values of $x,y$
- If you write this function carefully, you can just use `optim()` to spit out an answer


---
level: 3
---

# A variety of dogs with `optim()`

````md magic-move
```r
HotDogsDogs <- function(par){
}
```
```r
HotDogsDogs <- function(par){
  return(R)
}
```
```r
HotDogsDogs <- function(par){
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}
```
```r
HotDogsDogs <- function(par){
  x <- par[1]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}
```
```r
HotDogsDogs <- function(par){
  x <- par[1]
  y <- par[2]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}
```
```r
HotDogsDogs <- function(par){
  x <- par[1]
  y <- par[2]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}

hotdogs <- expand.grid(x=0:10, y=0:10, revenue=0)
```
```r
HotDogsDogs <- function(par){
  x <- par[1]
  y <- par[2]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}

hotdogs <- expand.grid(x=0:10, y=0:10, revenue=0)

for (i in 1:nrow(hotdogs)){

}

```
```r
HotDogsDogs <- function(par){
  x <- par[1]
  y <- par[2]
  R <- -5*x^2 -8*y^2 -2*x*y + 42*x + 102*y
  return(R)
}

hotdogs <- expand.grid(x=0:10, y=0:10, revenue=0)

for (i in 1:nrow(hotdogs)){
  hotdogs$revenue[i] <- HotDogsDogs(c(hotdogs$x[i], hotdogs$y[i]))
}

```
````


---
level: 3
layout: image-right
image: /optim.png
---

# A variety of dogs with `optim()`

```r
ggplot(hotdogs, 
       aes(x = x, 
           y = y, 
           fill = revenue)) +
  geom_tile() +
  scale_fill_viridis_c() +
  coord_equal() +
  theme_bw()

out <- optim(
  c(1, 1),
  HotDogsDogs,
  lower = c(0, 0),
  upper = c(10, 10),
  method = "L-BFGS-B",
  control = list(fnscale = -1)
)

out$par

# [1] 3 6

```