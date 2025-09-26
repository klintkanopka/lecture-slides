---
level: 2
layout: section
---

# `while` Loops

---
level: 3
---

# `while` Loops

- Recall: loops allow us to specify a chunk of code to be executed repeatedly
  - `for` loops execute a pre-specified number of times
- What if you don't know how many times a loop will take, but you know when you want it to stop?
  - This is the job of the `while` loop
  - When possible, prefer `for` loops to `while` loops!

---
level: 3
---

# `while` Loops

- In `R`, a `while` loop has a few main components
  - The call: `while`
  - The condition, specified in `( )` after the call and contain:
    - A logical statement that returns a single value
  - The code, wrapped in `{ }`: 
    - At the beginning of the loop, the condition is checked
    - If it evaluates to `TRUE`, all of the code in the loop is executed
    - If it evaluates to `FALSE`, the code in the loop is skipped
    - After this is done, the condition is checked again to decide if the loop should be repeated
    - This continues until the condition evaluates to `FALSE`
    

---
level: 3
---

# Example `while` Loops 1 and 2 

- What will be the result of executing these loops?

---
level: 3
---

# Example `while` Loops 1 and 2 

- What will be the result of executing these loops?

````md magic-move
```r
i <- 0

while (i <= 5){
  print(i)
}

while (i < 5){
  print(i)
}

```

```r
i <- 0

while (i <= 5){
  print(i)
}

# [1] 0

while (i < 5){
  print(i)
}

```

```r
i <- 0

while (i <= 5){
  print(i)
}

# [1] 0
# [1] 0

while (i < 5){
  print(i)
}

```

```r
i <- 0

while (i <= 5){
  print(i)
}

# [1] 0
# [1] 0
# [1] 0

while (i < 5){
  print(i)
}

```

```r
i <- 0

while (i <= 5){
  print(i)
}

# [1] 0
# [1] 0
# [1] 0
# [1] 0

while (i < 5){
  print(i)
}

```

```r
i <- 0

while (i <= 5){
  print(i)
}

# [1] 0
# [1] 0
# [1] 0
# [1] 0
# [1] 0

while (i < 5){
  print(i)
}

```
```r
i <- 0

while (i <= 5){
  print(i)
}

# [1] 0
# [1] 0
# [1] 0
# [1] 0
# [1] 0

# this will not end...

while (i < 5){
  print(i)
}

```

````


---
level: 3
---

# Example `while` Loops 3 and 4

- What will be the result of executing these loops?

````md magic-move
```r
i <- 0

while (i <= 5){
  print(i)
  i <- i + 1
}


while (i < 5){
  print(i)
  i <- i + 1
}
```
```r
i <- 0

while (i <= 5){
  print(i)
  i <- i + 1
}

# [1] 0

while (i < 5){
  print(i)
  i <- i + 1
}
```
```r
i <- 0

while (i <= 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1

while (i < 5){
  print(i)
  i <- i + 1
}
```
```r
i <- 0

while (i <= 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1
# [1] 2

while (i < 5){
  print(i)
  i <- i + 1
}
```
```r
i <- 0

while (i <= 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1
# [1] 2
# [1] 3

while (i < 5){
  print(i)
  i <- i + 1
}
```

```r
i <- 0

while (i <= 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1
# [1] 2
# [1] 3
# [1] 4

while (i < 5){
  print(i)
  i <- i + 1
}
```
```r
i <- 0

while (i <= 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1
# [1] 2
# [1] 3
# [1] 4
# [1] 5

while (i < 5){
  print(i)
  i <- i + 1
}
```

```r
i <- 0

while (i <= 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1
# [1] 2
# [1] 3
# [1] 4
# [1] 5

while (i < 5){
  print(i)
  i <- i + 1
}

# nothing happens?
```
````

---
level: 3
---

# Example `while` Loop 4 (for real)

````md magic-move
```r
i <- 0

while (i < 5){
  print(i)
  i <- i + 1
}

```
```r
i <- 0

while (i < 5){
  print(i)
  i <- i + 1
}

# [1] 0

```
```r
i <- 0

while (i < 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1

```
```r
i <- 0

while (i < 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1
# [1] 2

```
```r
i <- 0

while (i < 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1
# [1] 2
# [1] 3

```
```r
i <- 0

while (i < 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1
# [1] 2
# [1] 3
# [1] 4

```
```r
i <- 0

while (i < 5){
  print(i)
  i <- i + 1
}

# [1] 0
# [1] 1
# [1] 2
# [1] 3
# [1] 4

# all done!

```
````

---
level: 3
---

# Example `while` Loop 5

- You can check for convergence 

````md magic-move
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521
# [1] 1.154782

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521
# [1] 1.154782
# [1] 1.074608

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521
# [1] 1.154782
# [1] 1.074608
# [1] 1.036633

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521
# [1] 1.154782
# [1] 1.074608
# [1] 1.036633
# [1] 1.018152

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521
# [1] 1.154782
# [1] 1.074608
# [1] 1.036633
# [1] 1.018152
# [1] 1.009035

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521
# [1] 1.154782
# [1] 1.074608
# [1] 1.036633
# [1] 1.018152
# [1] 1.009035
# [1] 1.004507

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521
# [1] 1.154782
# [1] 1.074608
# [1] 1.036633
# [1] 1.018152
# [1] 1.009035
# [1] 1.004507
# [1] 1.002251

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521
# [1] 1.154782
# [1] 1.074608
# [1] 1.036633
# [1] 1.018152
# [1] 1.009035
# [1] 1.004507
# [1] 1.002251
# [1] 1.001125

```
```r
last <- Inf
eps <- 1e-3
current <- 10

while (abs(last - current) > eps){
  last <- current
  current <- sqrt(current)
  print(current)
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521
# [1] 1.154782
# [1] 1.074608
# [1] 1.036633
# [1] 1.018152
# [1] 1.009035
# [1] 1.004507
# [1] 1.002251
# [1] 1.001125
# [1] 1.000562

```

````

---
level: 3
---


# Example `while` Loop 6

- You can combine both methods to set a maximum number of iterations while looking for convergence

````md magic-move
```r
last <- Inf
eps <- 1e-3
max_iter <- 3
current <- 10
i <- 0

while (abs(last - current) > eps && i < max_iter){
  last <- current
  current <- sqrt(current)
  print(current)
  i <- i + 1
}


```
```r
last <- Inf
eps <- 1e-3
max_iter <- 3
current <- 10
i <- 0

while (abs(last - current) > eps && i < max_iter){
  last <- current
  current <- sqrt(current)
  print(current)
  i <- i + 1
}

# [1] 3.162278

```
```r
last <- Inf
eps <- 1e-3
max_iter <- 3
current <- 10
i <- 0

while (abs(last - current) > eps && i < max_iter){
  last <- current
  current <- sqrt(current)
  print(current)
  i <- i + 1
}

# [1] 3.162278
# [1] 1.778279

```
```r
last <- Inf
eps <- 1e-3
max_iter <- 3
current <- 10
i <- 0

while (abs(last - current) > eps && i < max_iter){
  last <- current
  current <- sqrt(current)
  print(current)
  i <- i + 1
}

# [1] 3.162278
# [1] 1.778279
# [1] 1.333521

```
````