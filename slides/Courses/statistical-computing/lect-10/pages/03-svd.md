---
level: 1
layout: section
---

# Matrix Factorization

---
level: 3
hideInToc: true
---

# Matrix Factorization

- Less actual linear algebra than when we talked about PCA!

<v-clicks depth="2">

- Let's first think about factoring: Where have you used it in the past?
- Say we have an $m \times n$ real matrix, $\mathbf{M}$
- We can factor it into: $\mathbf{M} = \mathbf{U} \Sigma \mathbf{V}^\top$
  - $\mathbf{U}$ is an $m \times m$ real orthogonal matrix and the columns are called the _left singular vectors_
  - $\mathbf{V}$ is a $n\times n$ real orthogonal matrix and the columns are called the _right singular vectors_
  - $\Sigma$ is an $m \times n$ non-negative diagonal rectangular matrix (aka: $\sigma_i = \Sigma_{ii}$ and $\Sigma_{i\neq j} = 0$), and the diagonal entries (called _singular values_) are arranged in decreasing order
  - We can write the whole original matrix as $\mathbf{M} = \sum_{i=1}^r \sigma_i \mathbf{u}_i \mathbf{v}_i^\top$, where $r = \text{rank}(\mathbf{M})$ is the number of non-zero singular values
- This is the Singular Value Decomposition (SVD). Sometimes SVD refers to the _compact SVD_, where $\Sigma$ is an $r \times r$ matrix that only contains the $r$ non-zero singular values, and $\mathbf{U}$ is $m \times r$ and $\mathbf{V}$ is $n \times r$
  - The compact SVD just throws away a bunch of zeros

</v-clicks>

---
level: 3
---

# Singular Value Decomposition

- Does the SVD remind you of anything?

<v-clicks depth="2">


- As it turns out, the SVD of a (centered) data matrix is how PCA is usually computed
  - This is because of a relationship between the SVD and the eigenvalues of $\mathbf{M}^\top\mathbf{M}$
- Note that the SVD recovers our original matrix _exactly_! It is not an approximation!
- But, the SVD requires a lot of computational time for large matrices and sometimes we only want the first few (aka most important) singular vectors
- We introduce now the _truncated SVD_
  - The truncated SVD is the same setup as the compact SVD, with one modification:
  - We only keep the left and right singular vectors associated with the first $k$ singular values!
  - This means the truncated SVD **is** an approximation if $k < \text{rank}(\mathbf{M})$

</v-clicks>

---
level: 3
---

# Truncated SVD

- The truncated SVD is _much_ faster to compute than the full SVD

<v-clicks depth="2">

- Done in a method similar to power iteration
- The truncated SVD is written as: $\tilde{\mathbf{M}} = \mathbf{U}_k \Sigma_k \mathbf{V}_k^\top$
- Among all matrices of rank $k$, the truncated SVD minimizes the _Frobenius Norm_: $||\mathbf{M} - \tilde{\mathbf{M}}||_F$
- Guess what the Frobenius Norm is

</v-clicks>
<div v-click>

$$||A||_F = \sqrt{\sum_{i=1}^m \sum_{j=1}^n a_{ij}^2} $$

</div>

<div v-click>

- This means that the result of the truncated SVD, $\tilde{\mathbf{M}}$, is the best rank $k$ approximation of the original matrix, $\mathbf{M}$

</div>