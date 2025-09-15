---
level: 2
layout: section
---

# `for` Loops

---
level: 3
---

# `for` Loops

- Loops allow us to specify a chunk of code to be executed repeatedly
- The first type we'll look at is the `for` loop
  - This executes a pre-specified number of times
  - Contrast this with the `while` loop, which continues to execute _while_ a condition is true
    - `while` loops can fall into conditions where they never terminate!
    - This means `for` loops are often considered "safer," but both are super useful

---
level: 3
---

# `for` Loops

- In `R`, a `for` loop has a few main components
  - The call: `for`
  - The conditions, specified in `( )` after the call and contain:
    - A variable name for the index: Common choices are $i,j,k$
    - The word `in`
    - A range: A vector of values you want the index to take on
  - The code, wrapped in `{ }`: 
    - For each value in the range, the index variable is set to that value and all of the code within the loop is executed one time (called an _iteration_)
    - After this is done, the value of the index is updated to the next value in the range and the code is executed again
    - This continues for each value in the range
    - Reference the index and use its changing value to have each iteration do something slightly different

---
level: 3
--- 

# Example `for` Loop 1

What will be the result of executing this loop?
````md magic-move
```r
for (i in 1:5){
  print(i^2)
}
```

```r
for (i in 1:5){
  print(i^2)
}

# [1] 1
```

```r
for (i in 1:5){
  print(i^2)
}

# [1] 1
# [1] 4
```

```r
for (i in 1:5){
  print(i^2)
}

# [1] 1
# [1] 4
# [1] 9
```

```r
for (i in 1:5){
  print(i^2)
}

# [1] 1
# [1] 4
# [1] 9
# [1] 16
```

```r
for (i in 1:5){
  print(i^2)
}

# [1] 1
# [1] 4
# [1] 9
# [1] 16
# [1] 25
```
````


---
level: 3
---

# Example `for` Loop 2

What will be the result of executing this loop?

````md magic-move
```r
for (i in 5:1){
  tmp <- i^2
  if (i%%2 != 0){
    print(tmp)
  }
}
```

```r
for (i in 5:1){
  tmp <- i^2
  if (i%%2 != 0){
    print(tmp)
  }
}

# [1] 25
```

```r
for (i in 5:1){
  tmp <- i^2
  if (i%%2 != 0){
    print(tmp)
  }
}

# [1] 25
# [1] 9
```

```r
for (i in 5:1){
  tmp <- i^2
  if (i%%2 != 0){
    print(tmp)
  }
}

# [1] 25
# [1] 9
# [1] 1
```
````

Note: `%%` is the _modulo_ operator. `A%%B` outputs the remainder of `A/B`


---
level: 3
---

# Example `for` Loop 3

What will be stored in `output` at the end of this loop?

````md magic-move
```r
input <- 1:10
output <- vector(mode='numeric', length=length(input))

for (i in 1:length(input)){
  output[i] <- sum(input[1:i])
}

output
```

```r
input <- 1:10
output <- vector(mode='numeric', length=length(input))

for (i in 1:length(input)){
  output[i] <- sum(input[1:i])
}

output

# [1]  1  3  6 10 15 21 28 36 45 55
```
````


---
level: 3
---

# Loop Tricks

- Like `if`, you can skip the `{ }` if there's only a single line to execute:

```r
for (i in 1:10){
  print(i^2)
}

for (i in 1:10) print(i^2)
```

- The range can also be a named vector:

```r
A <- 1:10
for (i in A) print(i^2)
```

- The elements of the range don't have to be sequential (or even integers):
```r
for (i in rnorm(10)) print(i^2)
```

---
level: 3
---

# Loop Tricks

- You can use `seq_along()` to generate an integer sequence the same length as some other object you care about using
  - The output of `seq_along(A)` is the same as `1:length(A)`

````md magic-move
```r
A <- rnorm(5)
A

for (i in seq_along(A)){
  print(paste0(i, " : ", A[i]))
}
```

```r
A <- rnorm(5)
A

# [1]  1.14133758 -1.79670720 -0.01528379 -0.70880602  0.71905939

for (i in seq_along(A)){
  print(paste0(i, " : ", A[i]))
}
```


```r
A <- rnorm(5)
A

# [1]  1.14133758 -1.79670720 -0.01528379 -0.70880602  0.71905939

for (i in seq_along(A)){
  print(paste0(i, " : ", A[i]))
}

# [1] "1 : 1.14133758088966"
# [1] "2 : -1.79670719779003"
# [1] "3 : -0.0152837872326052"
# [1] "4 : -0.708806019727051"
# [1] "5 : 0.71905938753312"
```
````