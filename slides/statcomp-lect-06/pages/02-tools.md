---
level: 1
layout: section
---

# Tools

---
level: 2
layout: section
---

# Mathematical Objects in `R`

---
level: 3
---

# Scalars and Vectors

- **Scalars** are single real numbers
  - Can be added and multiplied with each other
  - These are the numbers you're used to working with basically all the time
  - Examples: 2, $\pi$, -0.7
- **Vectors** represent quantities that can't just be summarized in a single number
  - These are quantities that have a _magnitude_ ("length") and _direction_ (direction)
  - Either represented as a scalar with a direction _or_ a single row/column matrix with each element representing a distance projected along each dimension
  - Can be added or multiplied with each other _if they have the same number of elements_
  - Can also be multiplied by scalars
  - Examples: $9.8 \frac{\text{m}}{\text{s}^2}$ down, $\begin{bmatrix} 3 \\ 4\end{bmatrix}$, $\begin{bmatrix} 1 & 1 & 1 \end{bmatrix}$

---
level: 3
---

# Matrices and Tensors

- **Matrices**
  - A rectangular generalization of the vector that is an array of numbers arranged in rows and columns
  - Can be added to each other (if they have the same shape)
  - Can be multiplied with each other (under some conditions)
  - Can be multiplied with vectors (under some conditions)
  - Can be multiplied with scalars (always)
  - Examples: $\begin{bmatrix}1 & 2 & 3 \\ 4 & 5 & 6 \end{bmatrix}$, $\begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix}$
- **Tensors**
  - These are generalizations of all these quantities!
  - Scalars are rank 0 tensors $(A)$ , vectors are rank 1 tensors $(A_{i})$ , matrices are rank 2 tensors $(A_{ij})$ 
  - The rank is the number of indices required to refer to the elements
  - A rank 3 tensor is a _cube_ of numbers $(A_{ijk})$ 
  - We won't use these today, but they show up a _lot_ in applied deep learning

---
level: 3
---

# Rethinking Addition: Graphically

- What do addition and multiplication _do_?
- This isn't really easy to think about in terms of scalars alone, so let's include vectors
- For two vectors, $\vec{u}, \vec{v}$, what does $\vec{u}+\vec{v}$ do?
- Addition is _translation_, it moves things around
- Addition will move one vector to the end of the other and then draw a new vector from the tail of the first to the tip of the second
- Mechanically, if $\vec{w} = \vec{u}+\vec{v}$:
  - $w_i = u_i+v_i$
  - $\begin{bmatrix} 1 \\ 2 \end{bmatrix} + \begin{bmatrix} 3 \\ 4 \end{bmatrix} = \begin{bmatrix} 4 \\ 6 \end{bmatrix}$
  - This is how `R` adds vectors---but note that in a linear algebra sense, **recycling is not allowed** and you can only add vectors with the same number of elements

---
level: 3
---

# Rethinking Addition: Graphically

<arrow v-click x1="185" y1="410" x2="500" y2="130" width="4" color="#56B4E9" />
<arrow v-click x1="500" y1="130" x2="710" y2="240" width="4" color="#56B4E9" />
<arrow v-click x1="185" y1="410" x2="710" y2="240" width="4" color="#E69F00" />


---
level: 3
---

# Rethinking Multiplication

- Scalar multiplication is always a rescaling and never changes the direction of a vector
  - $2\vec{u}$ is a vector in the same direction as $\vec{u}$ with twice the length
  - $\frac{1}{2} \begin{bmatrix} 1 \\ 2 \end{bmatrix} = \begin{bmatrix} 0.5 \\ 1 \end{bmatrix}$
- Vector multiplication can go two different ways:
  - The _dot_ product (or scalar product) $\vec{u}\cdot\vec{v}$ is a projection of $\vec{u}$ onto $\vec{v}$
    - The result is the length of $\vec{u}$ in the direction of $\vec{v}$
    - Computed as $\vec{u}\cdot\vec{v} = \sum_i u_iv_i$
    - Computed in `R` using `%*%`
  - The _cross_ product (or vector product) $\vec{u}\times\vec{v}$ constructs a vector orthogonal to $\vec{u},\vec{v}$
    - The magnitude of the result is the _area_ of the parallelogram with sides $\vec{u},\vec{v}$
    - Computed in `R` using `crossprod()`
    

---
level: 3
---

# Rethinking Multiplication: Graphically

<arrow v-click x1="185" y1="410" x2="500" y2="130" width="4" color="#56B4E9" />
<arrow v-click x1="500" y1="130" x2="710" y2="240" width="4" color="#56B4E9" />
<arrow v-click x1="185" y1="410" x2="395" y2="520" width="4" color="#E69F00" />
<arrow v-click x1="395" y1="520" x2="710" y2="240" width="4" color="#E69F00" />
<div v-click x=500, y=500>Magnitude: Area of the paralellogram</div>
<div v-click x=500, y=500>Direction: Orthogonal to the screen</div>


---
level: 3
---

# What About Matrices?

- We add a new operation - _transposition_
  - Switches the rows and columns
  - Done in `R` using `t()`
- Matrix addition is still translation and done element-wise
  - `R` does this correctly
- Matrix multiplication is weird
  - Requires that the number of columns on the left matrix is equal to the number of rows on the right matrix
  - Result produces a matrix with the number of rows from the left matrix and the number of columns from the right matrix
  - For the matrix multiplication $\mathbf{AB}=\mathbf{C}$:
    - $\mathbf{C}_{ij} = a_i \cdot b_j$, where $a_i$ is the $i$th row vector in $\mathbf{A}$ and $b_j$ is the $j$th column vector in $\mathbf{B}$
    - Computed in `R` using `%*%`
    

---
level: 3
---

# Multiplying Matrices

What are the results?

1. $\begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}\begin{bmatrix} 1 & 1 \\ 1 & 1 \end{bmatrix} =$ <v-click>$\begin{bmatrix} 3 & 3 \\ 7 & 7 \end{bmatrix}$</v-click>

2. $\begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}\begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix} =$ <v-click>$\begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}$</v-click>

3. $\begin{bmatrix} 1 & 2 \\ 3 & 4 \\ 5 & 6\end{bmatrix}\begin{bmatrix} 1 & 1 \\ 2 & 2 \\ 3 & 3 \end{bmatrix} =$ <v-click>$\text{NOPE}$</v-click>

4. $\begin{bmatrix} 1 & 2 \\ 3 & 4\\ 5 & 6 \end{bmatrix}\begin{bmatrix} 1 & 2 & 3 \\ 1 & 2 & 3 \end{bmatrix} =$ <v-click>$\begin{bmatrix} 3 & 6 & 9 \\ 7 & 14 & 21 \\
11 & 22 & 33\end{bmatrix}$</v-click>

---
level: 3
---

# But what is Matrix Multiplication?

- Multiplying a vector $\vec{u}$ by the $n \times m$ matrix $\mathbf{A}$ does something _really_ weird
  - It provides a linear transformation from $\mathbb{R}^n \rightarrow \mathbb{R}^m$
  - So: $\vec{u}\mathbf{A} = \vec{u}^\prime$, where $\vec{u}$ is $n$-dimensional and $\vec{u}^\prime$ is $m$-dimensional
  - The transformations encoded in $A$ can scale, squeeze, shear, reflect, and rotate the vectors they are applied to!
- If I construct a matrix $\mathbf{U}$ where the columns are a bunch of vectors, the multiplication $\mathbf{UA}$ transforms all of the column vectors of $U$ simultaneously
  - This is how internally three-dimensional representations of spaces in video games are quickly projected to two dimensions for display on a screen
  - The camera's position and orientation describes a linear transformation encoded in a matrix, and this multiplication decides what is shown
  - It's why GPUs/graphics cards are just optimized to do lots of matrix multiplication really really fast
  - Deep learning is also just a ton of matrix multiplication, which is why it's done on GPUs not CPUs

