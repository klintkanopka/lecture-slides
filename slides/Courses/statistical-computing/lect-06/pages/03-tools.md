---
level: 1
layout: section
---

# Motivating Problem

---
level: 2
---

# Motivating Problem: High-Dimensional Data

## Someone gives you a dataset with over 500 variables in it. They ask you to build a predictive model, along with some visuals that communicate what's going on with the data and your model to stakeholders of unknown statistical experience. What do you do?

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
  - These are quantities that have a _magnitude_ ("length") and a _direction_
  - Either represented as a magnitude with a direction _or_ a single row/column matrix with each element representing the component along each dimension
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
  - Can be multiplied with each other or with vectors (under some conditions)
  - Can be multiplied with scalars (always)
  - Examples: $\begin{bmatrix}1 & 2 & 3 \\ 4 & 5 & 6 \end{bmatrix}$, $\begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix}$
- **Tensors**
  - These are generalizations of all these quantities!
  - Scalars are rank 0 tensors $(A)$, vectors are rank 1 tensors $(A_{i})$, matrices are rank 2 tensors $(A_{ij})$
  - The rank is the number of indices required to refer to the elements
  - A rank 3 tensor is a _cube_ of numbers $(A_{ijk})$
  - We won't use these today, but they show up a _lot_ in applied deep learning
- **Note:** _tensor_ rank (# of indices) is not _matrix_ rank (# of linearly independent columns)

---
level: 3
---

# Rethinking Addition: Graphically

- What do addition and multiplication _do_?
- This isn't really easy to think about in terms of scalars alone, so let's include vectors
- For two vectors, $\vec{u}, \vec{v}$, what does $\vec{u}+\vec{v}$ do?
- Addition is _translation_: it moves things around
- Graphically, place the tail of $\vec{v}$ at the tip of $\vec{u}$; the sum is the arrow from the tail of $\vec{u}$ to the tip of $\vec{v}$
- Mechanically, if $\vec{w} = \vec{u}+\vec{v}$:
  - $w_i = u_i+v_i$
  - To find $\vec{w}$, add $\vec{u}$ and $\vec{v}$ elementwise: $\begin{bmatrix} 1 \\ 2 \end{bmatrix} + \begin{bmatrix} 3 \\ 4 \end{bmatrix} = \begin{bmatrix} 4 \\ 6 \end{bmatrix}$
  - This is what happens when `R` adds vectors, but **this interpretation only holds without recycling**, i.e., adding vectors with the same number of elements

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

- Scalar multiplication is always a rescaling and never moves a vector off its line
  - $2\vec{u}$ is a vector in the same direction as $\vec{u}$ with twice the length
  - $\frac{1}{2} \begin{bmatrix} 1 \\ 2 \end{bmatrix} = \begin{bmatrix} 0.5 \\ 1 \end{bmatrix}$
  - Negative scalars flip the vector to point the opposite way: $-\vec{u}$
- Multiplying two vectors with the _dot_ product (or scalar product), $\vec{u}\cdot\vec{v}$, gives a scalar
  - Computed as $\vec{u}\cdot\vec{v} = \sum_i u_iv_i$
  - Geometrically, $\vec{u}\cdot\vec{v} = ||\vec{u}||\,||\vec{v}|| \cos\theta$, where $\theta$ is the angle between them
  - **If $\vec{v}$ is a unit vector** ($||\vec{v}|| = 1$), $\vec{u}\cdot\vec{v}$ is the length of $\vec{u}$ in the direction of $\vec{v}$ (its "shadow" on $\vec{v}$)
  - If $\vec{u}\cdot\vec{v} = 0$, the vectors are _orthogonal_ (perpendicular)
  - Computed in `R` using `sum(u * v)` or `t(u) %*% v`
- There's also a _cross_ product, $\vec{u}\times\vec{v}$, but it only exists in 3D and we won't need it

---
level: 3
layout: image-right
image: /dot-product.png
backgroundSize: contain
---

# The Dot Product: Graphically

- $\vec{v}$ is a unit vector, so $\vec{u}\cdot\vec{v}$ is the length of the shadow $\vec{u}$ casts on the line through $\vec{v}$
- The dashed line meets the line through $\vec{v}$ at a right angle
- **Keep this picture in mind:** PCA is going to be all about the shadows our data cast on a specifically chosen line

---
level: 3
---

# What About Matrices?

- We add a new operation---_transposition_
  - Switches the rows and columns
  - Done in `R` using `t()`
- Matrix addition is still translation and done element-wise
  - `R` does this correctly
- Matrix multiplication is weird
  - Requires that the number of columns in the left matrix is equal to the number of rows in the right matrix
  - The result is a matrix with the number of rows from the left matrix and the number of columns from the right matrix: $(n \times m)(m \times p) \rightarrow (n \times p)$
  - For the matrix multiplication $\mathbf{AB}=\mathbf{C}$:
    - $\mathbf{C}_{ij} = \mathbf{a}_i \cdot \mathbf{b}_j$, where $\mathbf{a}_i$ is the $i$th row vector in $\mathbf{A}$ and $\mathbf{b}_j$ is the $j$th column vector in $\mathbf{B}$
    - Computed in `R` using `%*%`
  - `crossprod(X)` computes $\mathbf{X}^\top\mathbf{X}$ faster than `t(X) %*% X`
    - Despite the name, it is _not_ the cross product!

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

# Another View: Matrix-Vector Multiplication

- Another way to think about $\mathbf{A}\vec{u}$: it's a **weighted sum of the columns of $\mathbf{A}$**, with the weights given by $\vec{u}$:

$$ \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}\begin{bmatrix} 5 \\ 6 \end{bmatrix} = 5\begin{bmatrix} 1 \\ 3 \end{bmatrix} + 6\begin{bmatrix} 2 \\ 4 \end{bmatrix} = \begin{bmatrix} 17 \\ 39 \end{bmatrix} $$

- Yet another way is each entry is a row of $\mathbf{A}$ dotted with $\vec{u}$:

$$ \begin{bmatrix} 1 & 2 \\ 3 & 4 \end{bmatrix}\begin{bmatrix} 5 \\ 6 \end{bmatrix} = \begin{bmatrix} \begin{bmatrix} 1 & 2 \end{bmatrix} \cdot \begin{bmatrix} 5 & 6 \end{bmatrix} \\ \begin{bmatrix} 3 & 4 \end{bmatrix} \cdot \begin{bmatrix} 5 & 6 \end{bmatrix} \end{bmatrix} = \begin{bmatrix} 1 \cdot 5 + 2 \cdot 6 \\ 3 \cdot 5 + 4 \cdot 6 \end{bmatrix} = \begin{bmatrix} 17 \\ 39 \end{bmatrix} $$

- We care because PCA is going to try to write each observation as a weighted sum of a few special vectors:

$$ \mathbf{x}_i \approx a_{i1}\mathbf{v}_1 + a_{i2}\mathbf{v}_2 + \cdots + a_{ik}\mathbf{v}_k $$

- That's exactly a matrix (with columns $\mathbf{v}_1, \ldots, \mathbf{v}_k$) times a vector of weights $(a_{i1}, \ldots, a_{ik})$

---
level: 3
---

# But What Is Matrix Multiplication?

- Multiplying a vector $\vec{u}$ by the $m \times n$ matrix $\mathbf{A}$ does something _really_ weird
  - From here on, vectors are _columns_, so $\vec{u}$ is $n \times 1$
  - It provides a linear transformation from $\mathbb{R}^n \rightarrow \mathbb{R}^m$
  - So: $\mathbf{A}\vec{u} = \vec{u}^\prime$, where $\vec{u}$ is $n$-dimensional and $\vec{u}^\prime$ is $m$-dimensional
  - The transformations encoded in $\mathbf{A}$ can scale, squeeze, shear, reflect, rotate, and project the vectors they are applied to!
- If I construct a matrix $\mathbf{U}$ where the columns are a bunch of vectors, the multiplication $\mathbf{AU}$ transforms all of the column vectors of $\mathbf{U}$ simultaneously
  - This is how video games quickly project three-dimensional scenes onto a two-dimensional screen
  - The camera's position and orientation describe a transformation encoded in a matrix, and this multiplication decides what is shown
  - It's why GPUs are optimized to do lots of matrix multiplication really, really fast
  - Deep learning is also just a ton of matrix multiplication, which is why it's done on GPUs rather than CPUs
