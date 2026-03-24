---
level: 2
layout: section
transition: fade
---

# Conditional Statements

---
level: 3
---

# Conditional Statements

- Often we want to check if something is true, and then change the behavior of the code we write based upon that
- We call these _conditional statements_, and they're the key way we handle choice in control flow
- Three main conditional statements in `R`
  - `if` checks a condition and then executes some code if it evaluates to `TRUE`
  - `else` provides some code to execute if the previous `if` statement evaluates to `FALSE`
  - `else if` provides a secondary condition. Note that if you use `else if`, a final `else` statement will only execute if _all_ of the previous `if` conditions evaluate to `FALSE`
- There are two ways to write these, single line and multiline
  - I prefer multiline in basically all situations (for readability)
  
---
level: 3
---

# Example Conditional 1

````md magic-move
```r 

x <- 3

if (x > 0){
  print('positive')
}

x <- -3

if (x > 0) print('positive')
```
```r 

x <- 3

if (x > 0){
  print('positive')
}

# [1] "positive"

x <- -3

if (x > 0) print('positive')
```
```r 

x <- 3

if (x > 0){
  print('positive')
}

# [1] "positive"

x <- -3

if (x > 0) print('positive')

# 
```
````

---
level: 3
---

# Example Conditional 2

````md magic-move
```r 

x <- 3

if (x > 0){
  print('positive')
} else {
  print('not positive')
}

x <- -3

if (x > 0) print('positive') else print('not positive')
```
```r 

x <- 3

if (x > 0){
  print('positive')
} else {
  print('not positive')
}

# [1] "positive"

x <- -3

if (x > 0) print('positive') else print('not positive')
```
```r 

x <- 3

if (x > 0){
  print('positive')
} else {
  print('not positive')
}

# [1] "positive"

x <- -3

if (x > 0) print('positive') else print('not positive')

# [1] "not positive"

```
````


---
level: 3
---

# Example Conditional 3

````md magic-move
```r
x <- 'beans'

if (x > 0){
  print('positive')
} else if (x < 0){
  print('negative')
} else {
  print('neither positive nor negative')
}
```
```r
x <- 'beans'

if (x > 0){
  print('positive')
} else if (x < 0){
  print('negative')
} else {
  print('neither positive nor negative')
}

# [1] "positive"
```
````


---
level: 3
---

# Conditional Tricks

- Conditional statements are not vectorized! 
  - They check one value
  - Remember `&&` and `||` from last week?
  - What if you need to do vectorized if/else-ing?
- `R` has a vectorized conditional function, `ifelse()`
  - It takes three arguments:
    1. The condition
    2. The output if the condition is `TRUE`
    3. The output if the condition is `FALSE`
  - You can supply vectors to the condition, which is checked elementwise, and then replaced with the appropriate outputs
- `dplyr` has two related functions that are quite nice:
  - `if_else()` is like `ifelse()`, with better handling of missing data
  - `case_when()` is like a vectorized multi-case `if_else()`
  - Use these in your life, but not in this course!

---
level: 3
---

# `ifelse()` Example

````md magic-move
```r
set.seed(8675309)
A <- rnorm(4)
A

ifelse(A>0, 'positive', 'not positive')
```

```r
set.seed(8675309)
A <- rnorm(4)
A

# [1] -0.9965824  0.7218241 -0.6172088  2.0293916

ifelse(A>0, 'positive', 'not positive')
```

```r
set.seed(8675309)
A <- rnorm(4)
A

# [1] -0.9965824  0.7218241 -0.6172088  2.0293916

ifelse(A>0, 'positive', 'not positive')

# [1] "not positive" "positive"     "not positive" "positive"    
```
````