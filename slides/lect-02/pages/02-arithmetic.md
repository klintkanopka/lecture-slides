---
layout: section
level: 1
---

# Vector and Matrix Arithmetic in `R`

---
level: 2
---

# Adding Vectors

What do you think the results of each of these operations ought to be?

````md magic-move
```r
c(1, 2, 3) + c(4, 5, 6)
c(1, 2, 3) + c(4, 5, 6, 7)
c(1, 2, 3) + c(4, 5, 6, 7, 8, 9)
```

```r
c(1, 2, 3) + c(4, 5, 6)
# [1] 5 7 9
c(1, 2, 3) + c(4, 5, 6, 7)
c(1, 2, 3) + c(4, 5, 6, 7, 8, 9)
```

```r
c(1, 2, 3) + c(4, 5, 6)
# [1] 5 7 9
c(1, 2, 3) + c(4, 5, 6, 7)
# Warning message:
# In c(1, 2, 3) + c(4, 5, 6, 7) :
#   longer object length is not a multiple of shorter object length
# [1] 5 7 9 8
c(1, 2, 3) + c(4, 5, 6, 7, 8, 9)
```

```r
c(1, 2, 3) + c(4, 5, 6)
# [1] 5 7 9
c(1, 2, 3) + c(4, 5, 6, 7)
# Warning message:
# In c(1, 2, 3) + c(4, 5, 6, 7) :
#   longer object length is not a multiple of shorter object length
# [1] 5 7 9 8
c(1, 2, 3) + c(4, 5, 6, 7, 8, 9)
# [1] 5 7 9 8 10 12
```
````


---
level: 2
---

# Vector Arithmetic

- Generally happens _elementwise_
- The first elements from each input are combined
- Then the second elements
- And so on...
- When vectors are the same size, this produces a vector the same length as the inputs
- What if they're not the same length?


---
level: 2
---

# Recycling

- `R`'s general behavior when things aren't the same length is to _recycle_ the shorter object
- Behavior is the same regardless of order
- Length of the output is the _maximum_ of the lenghts of the inputs
- How does this work?
  - `R` will paste the shorter object to itself end-to-end until it matches the length of the longer object
  - If the longer object is an integer multiple of the length of the longer object, it does this silently
  - If the longer object is not, it throws a warning, **but still produces output according to the same rules!**

---
level: 2
---

# Vectors and Matrices

````md magic-move
```r

v1 <- c(1,2,3)
v2 <- c(1,2,3,4)
v3 <- c(1,2)
mat <- matrix(1:9, nrow=3)

mat

v1 * mat
v2 * mat
v3 * mat
```

```r

v1 <- c(1,2,3)
v2 <- c(1,2,3,4)
v3 <- c(1,2)
mat <- matrix(1:9, nrow=3)

mat

#      [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

v1 * mat
v2 * mat
v3 * mat
```
```r

v1 <- c(1,2,3)
v2 <- c(1,2,3,4)
v3 <- c(1,2)
mat <- matrix(1:9, nrow=3)

mat

#      [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

v1 * mat

#      [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    4   10   16
# [3,]    9   18   27

v2 * mat
v3 * mat
```
```r

v1 <- c(1,2,3)
v2 <- c(1,2,3,4)
v3 <- c(1,2)
mat <- matrix(1:9, nrow=3)

mat

#      [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

v1 * mat
v2 * mat

# Warning message:
# In v2 * mat :
#   longer object length is not a multiple of shorter object length
#      [,1] [,2] [,3]
# [1,]    1   16   21
# [2,]    4    5   32
# [3,]    9   12    9

v3 * mat
```
```r

v1 <- c(1,2,3)
v2 <- c(1,2,3,4)
v3 <- c(1,2)
mat <- matrix(1:9, nrow=3)

mat

#      [,1] [,2] [,3]
# [1,]    1    4    7
# [2,]    2    5    8
# [3,]    3    6    9

v1 * mat
v2 * mat
v3 * mat

# In v3 * mat :
#   longer object length is not a multiple of shorter object length
#      [,1] [,2] [,3]
# [1,]    1    8    7
# [2,]    4    5   16
# [3,]    3   12    9
```

````


---
level: 2
---

# Vectors and Matrices

- Here, recycling happens along the columns
  - For matrices in `R`, things are usually applied along columns first
- Under the hood:
  1. The matrix is unrolled into a vector of the form `c(col1, col2, ...)`
  2. Recycling happens as if two vectors were multiplied
  3. The output is reshaped back into the original dimensions of the matrix
  
---
level: 2
---

# Matrix and Matrix

````md magic-move
```r
mat1 <- matrix(1:9, ncol=3)
mat2 <- matrix(1:4, ncol=2)

mat1 + mat1
mat2 * mat2
mat1 + mat2
```
```r
mat1 <- matrix(1:9, ncol=3)
mat2 <- matrix(1:4, ncol=2)

mat1 + mat1

#      [,1] [,2] [,3]
# [1,]    2    8   14
# [2,]    4   10   16
# [3,]    6   12   18

mat2 * mat2
mat1 + mat2
```
```r
mat1 <- matrix(1:9, ncol=3)
mat2 <- matrix(1:4, ncol=2)

mat1 + mat1

#      [,1] [,2] [,3]
# [1,]    2    8   14
# [2,]    4   10   16
# [3,]    6   12   18

mat2 * mat2

#      [,1] [,2]
# [1,]    1    9
# [2,]    4   16

mat1 + mat2
```
```r
mat1 <- matrix(1:9, ncol=3)
mat2 <- matrix(1:4, ncol=2)

mat1 + mat1

#      [,1] [,2] [,3]
# [1,]    2    8   14
# [2,]    4   10   16
# [3,]    6   12   18

mat2 * mat2

#      [,1] [,2]
# [1,]    1    9
# [2,]    4   16

mat1 + mat2

# Error in `mat1 + mat2`:
# ! non-conformable arrays
```

````


---
level: 2
---

# Matrix and Matrix

- For two matrix inputs, recycling does **not** happen!
- For standard arithmetic operators, everything is done elementwise
- If two matrices are not the same shape, `R` throws an error
  - `non-conformable arguments` or `non-conformable arrays`
  - No output is produced
  - Execution is halted
  
---
level: 2
---

# Matrix Multiplication

- There is a specific matrix multiplication operator, `%*%`
- Conducts matrix multiplication
  - Requires an $A \times B$ matrix and a $B \times C$ matrix
  - Produces $A \times C$ shaped output
- Works with vectors!
  - A vector of length $N$ is treated as either an $N \times 1$ or $1 \times N$ matrix, depending on what is needed
  - The output is **always** as a matrix

---
level: 2
---

# Matrix Multiplication

````md magic-move
```r
matrix(1:9, ncol=3) %*% matrix(1:9, ncol=3)
matrix(1:9, ncol=3) %*% c(1, 2, 3)
c(1, 2, 3) %*% matrix(1:9, ncol=3)
```

```r
matrix(1:9, ncol=3) %*% matrix(1:9, ncol=3)

#      [,1] [,2] [,3]
# [1,]   30   66  102
# [2,]   36   81  126
# [3,]   42   96  150

matrix(1:9, ncol=3) %*% c(1, 2, 3)
c(1, 2, 3) %*% matrix(1:9, ncol=3)
```

```r
matrix(1:9, ncol=3) %*% matrix(1:9, ncol=3)

#      [,1] [,2] [,3]
# [1,]   30   66  102
# [2,]   36   81  126
# [3,]   42   96  150

matrix(1:9, ncol=3) %*% c(1, 2, 3)

#      [,1]
# [1,]   30
# [2,]   36
# [3,]   42

c(1, 2, 3) %*% matrix(1:9, ncol=3)
```

```r
matrix(1:9, ncol=3) %*% matrix(1:9, ncol=3)

#      [,1] [,2] [,3]
# [1,]   30   66  102
# [2,]   36   81  126
# [3,]   42   96  150

matrix(1:9, ncol=3) %*% c(1, 2, 3)

#      [,1]
# [1,]   30
# [2,]   36
# [3,]   42

c(1, 2, 3) %*% matrix(1:9, ncol=3)

#      [,1] [,2] [,3]
# [1,]   14   32   50
```
````

---
level: 2
---

# Matrix Multiplication

- We want to multiply two matrices, $AB = C$ 
  - Where $a_{ij}$ is the element of matrix $A$ in the $i$th row and $j$th column
  - And matrices $A$ is and $N \times K$ matrix and $B$ is a $K \times M$ matrix
- To construct the $N \times M$ matrix, $C$:

$$c_{ij} = \sum_{k=1}^K a_{ik}b_{kj}$$

- Alternatively $C$ can be constructed through dot products:
  - Where $\vec{a}_i$ is the $i$th _row_ vector of $A$
  - And $\vec{b}_j$ is the $j$th _column_ vector of $B$

$$ c_{ij} = \vec{a}_i \cdot \vec{b}_j $$

- If this looks awful, a course in linear algebra could be useful (depending on your subplan and career goals)