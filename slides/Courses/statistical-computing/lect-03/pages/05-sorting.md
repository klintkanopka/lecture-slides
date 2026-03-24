---
level: 1
layout: section
---

# Sorting

---
level: 3
---

# Our First Sorting Algorithm

- First, what even is an _algorithm?_
  - For us: _a precise set of steps to solve some problem_
- So, okay, let's come up with a sorting algorithm!
  - In a group of $3 \pm 1$, describe (in words) an algorithm that takes, as input, some vector of numbers `A` and then returns a new vector with the elements of `A` sorted in ascending order
  - Ascending is smallest to largest
  - Do this now

---
level: 2
layout: section
---

# Selection Sort

---
level: 3
---

# Selection Sort

- This is kind of the most obvious to implement (to me, at least)
- Here's the plan:
  1. Find the smallest element in the vector
  2. Move it to the front
  3. Repeat 1-2 among the elements that are left until you're done
- Where do we need the tools we've developed so far in this class?
  - Last week: Logical statements, functions, and unit testing
  - This week: Indexing, conditionals, loops
  
---
level: 3
---

# Selection Sort

````md magic-move

```r
SelectionSort <- function(A){
  # 1. find the smallest element
  # 2. move it to the front
  # 3. repeat 1-2 among the elements that are left
  # 4. return the sorted list
}
```
```r
SelectionSort <- function(A){
  # 1. find the smallest element
  for (){

  }
  # 2. move it to the front
  # 3. repeat 1-2 among the elements that are left
  # 4. return the sorted list
}
```
```r
SelectionSort <- function(A){
  # 1. find the smallest element
  for (i in 1:length(A)){

  }
  # 2. move it to the front
  # 3. repeat 1-2 among the elements that are left
  # 4. return the sorted list
}
```
```r
SelectionSort <- function(A){
  # 1. find the smallest element
  for (i in 1:length(A)){
    if (){

    }
  }
  # 2. move it to the front
  # 3. repeat 1-2 among the elements that are left
  # 4. return the sorted list
}
```
```r
SelectionSort <- function(A){
  # 1. find the smallest element
  for (i in 1:length(A)){
    if (A[i] < A[min]){

    }
  }
  # 2. move it to the front
  # 3. repeat 1-2 among the elements that are left
  # 4. return the sorted list
}
```
```r
SelectionSort <- function(A){
  # 1. find the smallest element
  for (i in 1:length(A)){
    if (A[i] < A[min]){
      min <- i
    }
  }
  # 2. move it to the front
  # 3. repeat 1-2 among the elements that are left
  # 4. return the sorted list
}
```
```r
SelectionSort <- function(A){
  # 1. find the smallest element
  min <- 1
  for (i in 1:length(A)){
    if (A[i] < A[min]){
      min <- i
    }
  }
  # 2. move it to the front
  # 3. repeat 1-2 among the elements that are left
  # 4. return the sorted list
}
```

```r
SelectionSort <- function(A){
  # 1. find the smallest element
  min <- 1
  for (i in 1:length(A)){
    if (A[i] < A[min]){
      min <- i
    }
  }
  # 2. move it to the front
  A[c(1, min)] <- A[c(min, 1)]
  # 3. repeat 1-2 among the elements that are left
  # 4. return the sorted list
}
```

```r
SelectionSort <- function(A){
  # 3. repeat 1-2 among the elements that are left
  for (){
    # 1. find the smallest element
    min <- 1
    for (i in 1:length(A)){
      if (A[i] < A[min]){
        min <- i
      }
    }
    # 2. move it to the front
    A[c(1, min)] <- A[c(min, 1)]
  }
  # 4. return the sorted list
}
```
```r
SelectionSort <- function(A){
  # 3. repeat 1-2 among the elements that are left
  for (j in 1:length(A)){
    # 1. find the smallest element
    min <- 1
    for (i in 1:length(A)){
      if (A[i] < A[min]){
        min <- i
      }
    }
    # 2. move it to the front
    A[c(1, min)] <- A[c(min, 1)]
  }
  # 4. return the sorted list
}
```

```r
SelectionSort <- function(A){
  # 3. repeat 1-2 among the elements that are left
  for (j in 1:length(A)){
    # 1. find the smallest element
    min <- j
    for (i in j:length(A)){
      if (A[i] < A[min]){
        min <- i
      }
    }
    # 2. move it to the front
    A[c(j, min)] <- A[c(min, j)]
  }
  # 4. return the sorted list
}
```

```r
SelectionSort <- function(A){
  # 3. repeat 1-2 among the elements that are left
  for (j in 1:length(A)){
    # 1. find the smallest element
    min <- j
    for (i in j:length(A)){
      if (A[i] < A[min]){
        min <- i
      }
    }
    # 2. move it to the front
    A[c(j, min)] <- A[c(min, j)]
  }
  # 4. return the sorted list
  return(A)
}
```

````

---
level: 3
---

# Selection Sort

- We care about two things with any algorithm:
  1. Is it correct?
  2. Is it efficient?
- Correctness is usually validated through proofs
- Efficiency is validated through runtime analysis
- Is `SelectionSort()` correct?
  - Does it always return a sorted version of the input?
  - Yes, but we won't prove it in this course
  - Instead, test your function until you're convinced it works

---
level: 3
---

# Selection Sort

- If `A` contains $n$ elements, how many instructions (in terms of $n$) are run when you execute `SelectionSort(A)`?
  - The code in the outer loop executes $n$ times
  - The code in the inner loop runs $n$, then $n-1$, then $n-2$, ..., 1 times
  - We then say that this runs _on the order of_ $n^2$ instructions
  - Often this is written in "big-$O$ notation" as $O(n^2)$
  - There's some technical stuff here that we'll get to later
- Each line of code takes time to run, and as we use larger datasets, efficiency starts to matter a lot!