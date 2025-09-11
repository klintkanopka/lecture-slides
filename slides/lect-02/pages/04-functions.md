---
layout: section
level: 1
---

# Functional and Object-Oriented Programming

---
level: 2
---

# Functions

- Functions are objects in R that package code
- Functions take named _arguments_
- Executing a function creates a new environment with the arguments assigned to their names
  - Then they execute their code
  - When a function is done running, its environment is destroyed/lost
- In general, we do not write functions that modify the global variables (this is super dangerous)!
- If you need information that's computed within a function, you need to return it
- This lets you maintain whatever object is returned for future use outside of the function's environment

---
level: 2
---

# Function Anatomy

```r {*|1,4|2|3|*}
RollDice <- function(n_sides = 6, n_dice = 1){
  results <- sample(1:n_sides, n_dice, replace=TRUE)
  return(result)
}
```

---
level: 2
---

# Vectorization

- We've already seen this, but let's be explicit!
- Some functions are _vectorized_, meaning they can operate independently on all elements of a vector
- Vectorized functions take in vectors, arrays, or matrices and return objects of the same size with consistent behavior across all elements

````md magic-move
```r
x <- 0:3
exp(x)
x^2
x == 2
```
```r
x <- 0:3
exp(x)

# [1] 1.000000 2.718282 7.389056 20.085537

x^2
x == 2
```

```r
x <- 0:3
exp(x)

# [1] 1.000000 2.718282 7.389056 20.085537

x^2

# [1] 0 1 4 9

x == 2
```

```r
x <- 0:3
exp(x)

# [1] 1.000000 2.718282 7.389056 20.085537

x^2

# [1] 0 1 4 9

x == 2

# [1] FALSE FALSE TRUE FALSE
```

````

---
level: 2
---

# Object Oriented Programming

- There are lots of different types of objects in `R`
- These different types of objects are identified internally with “classes”
  - You can use the `class()` function on an object to see what class it is
  - Things without classes are often called “base objects”
- We want objects that keep our data, code and results neatly organized
- We want functions that do predictable things to these objects
- Object Oriented Programming (OOP) is centered around _objects_
  - Objects contain data
  - Objects contain code (called _methods_)
  - Methods are specifically designed to operate on the data in the object
- `R` has a few ways to implement this (S3 and S4 being most common)

---
level: 2
---

# Generic Functions (aka Generics)

- Functions that are designed to operate on many different types of objects with a common call
  - `print()`, `summary()`, `coef()`, `plot()`, etc
- Generics look at the type of object they are called on and then use the _method_ associated with that type of object
- `print()` just prints an object out
  - What that means depends on what the object is! 
- `summary()` 
  - Prints out summary statistics for data frames and vectors
  - Prints out whole tables and descriptions for different types of model objects!
- In Part 3 of PS1, you'll start to construct your first model object!

---
level: 2
---

# Unit Testing

- Unit testing is an idea we'll introduce now, but it's a _practice_ we should always engage in when writing code!
- The basic idea is that we want to write our code in chunks (often in the form of functions)
  - If we write our code in chunks, we can also test our code in chunks
  - This makes it _much_ easier to pinpoint where things may be going wrong
  - This will be come much more important very soon once we start to include control flow and loops!
- How do you do this?
  - First, make sure your code gives the correct output under a variety of conditions!
  - Second, see what your code does in unexpected situations
    - How does it handle inputs of the wrong type?
    - How does it handle inputs of the wrong size?
    - How does it handle missing (or `NA`) inputs?
  - Third, once you validate each individual piece works, make sure they work _together_


