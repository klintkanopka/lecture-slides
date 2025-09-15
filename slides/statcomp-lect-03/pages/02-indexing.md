---
level: 1
layout: section
---

# Tools

---
level: 2
layout: section
---

# Indexing

---
level: 3
---

# Indexing

- When we deal with vectors, arrays, matrices, and dataframes in `R`, we often only care about some subset of the data - maybe a single row, or a single element, or a few columns
  - We access them using _indexing_
  - `R`, as a language, is 1-indexed, meaning the first position is labeled `1`
  - Contrast this with Python, C, and other languages which are 0-indexed
- We index into one dimensional objects (vectors and lists) using `[ ]`
  - You can supply single integers to get a single elements, or a vector to get multiple elements
    - `A[3]` gets the third element of `A`
    - `A[1:3]` gets the first three elements of `A`
    - `A[c(2, 4, 6)]` gets the second, fourth, and sixth elements of `A`
    - `A[-2]` gets everything in `A` _except_ the second element
    - `A[-1:-3]` gets everything from `A` _except_ the first three elements
  - Always returns objects of the same type - so single bracket indexing into a list returns another list
    - To get out just the first thing inside of a list, `L`, use double brackets
    - `L[[1]]`
    
---
level: 3
---

# Indexing in Two Dimensions

- For matrices, we have slightly different behavior
  - `M <- matrix(1:9, ncol=3)`
  - `M[1]` returns just the first element
  - `M[3]` returns just the third element (which element is the third?)
- For better results, use two dimensional indexing!
  - `M[a,b]` returns the element in the `a`th row and the `b`th column $(m_{ab})$
  - `M[a,]` returns the entire `a`th row
  - `M[,b]` returns the entire `b`th column
  - The rules we use in one dimension also work here
    - `M[-1,]` will drop the first row of `M`
    - `M[1:2, 1:2]` will produce the $2\times 2$ matrix made up of the first two rows and columns.
- You can always pass variables into indexing arguments, too.

---
level: 3
---

# Indexing into Named Lists

- If the elements of a list are named, you can index into them using the names!
  - `L['first']` provides a list with only the element of `L` named `first`
  - `L[c('first', 'second')]` provides a list with the element of `L` named `first` and `second`
  - `L[['first']]` provides the contents of element named `first` in `L`
  - `L[[c('first', 'second')]]` throws an error 
  - `L$first` gets the element of `L` named `first`
  - Note that if the name of the element you want is stored in a variable `var`, you can't fish it out using `$`, but instead have to use `L[[var]]` or `L[var]`
- Remember that dataframes _are_ lists, so most of this behavior holds, but they also look kind of like matrices, so some of that behavior holds


---
level: 3
---

# Indexing into Dataframes

- For a dataframe named `d` with columns named `x`, `y`, and `z`:
  - `d['x']` provides a dataframe with only column `x`
  - `d[c('x', 'y')]` provides a dataframe with only columns `x` and `y`
  - `d[['x']]` provides column `x` as a vector
  - `d[[c('x', 'y')]]` throws an error 
  - `d$x` provides column `x` as a vector
  - Again: if the name of the element you want is stored in a variable `var`, you can't fish it out using `$`
    -`d$var` won't work
    - `d[[var]]` gives a vector
    - `d[var]` gives a dataframe
- Numbers also work
  - What do you think `d[2,]`, `d[,2]`, `d[2,2]`, and `d[2]` give you?
    - `d[2,]` gives you the second row (as a vector)
    - `d[,2]` gives you the second column (as a vector)
    - `d[2,2]` gives you the second element of the second row (as whatever data type it is)
    - `d[2]` gives you the second row (as a dataframe)