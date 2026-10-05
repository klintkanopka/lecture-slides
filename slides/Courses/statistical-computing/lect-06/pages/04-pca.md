---
level: 1
layout: section
---

# Principal Component Analysis

---
level: 2
layout: section
---

# Finding Structure in Matrices with PCA

---
level: 3
---

# Finding Structure in Matrices with PCA

- **Key Idea:** We can represent our data in a matrix, $\mathbf{X}$, and then project it into a lower-dimensional space ($k < m$). If we choose that space using the structure of $\mathbf{X}$, the projection preserves a bunch of really important information in $\mathbf{X}$ and makes it easier to look at!
- What kind of structure can we find? How do we find it in a smart way?
- Today we'll introduce _Principal Component Analysis_ (PCA) as one way to find structure and then look at a way to do it
- The overarching goal of PCA:
  - We have data consisting of $n$ vectors, $\mathbf{x}_1, \ldots, \mathbf{x}_n$, each $m$-dimensional
    - Here, $n$ is our number of observations and $m$ is our number of variables
  - We want to express each observation as a linear combination of $k$ vectors, $\mathbf{v}_1, \ldots, \mathbf{v}_k$, each $m$-dimensional, so that $\mathbf{x}_i \approx \sum_{j=1}^k a_{ij} \mathbf{v}_j$
  - We want $k < m$, so the collection of $k$ vectors is a good approximation of the information in our original $m$ variables

---
level: 3
---

# Notation: Keeping Track of Shapes

<div class="text-sm">

| Symbol | What it is | Shape |
| --- | --- | --- |
| $n$ | Number of observations (rows of $\mathbf{X}$) | scalar |
| $m$ | Number of variables (columns of $\mathbf{X}$) | scalar |
| $k$ | Number of PCs we keep, $k < m$ | scalar |
| $\mathbf{X}$ | Data matrix, one observation per row | $n \times m$ |
| $\mathbf{x}_i$ | Observation $i$ (row $i$ of $\mathbf{X}$, written as a column) | $m \times 1$ |
| $\mathbf{v}$ | A direction (unit vector) in variable space | $m \times 1$ |
| $\mathbf{Xv}$ | Every observation's "shadow" on $\mathbf{v}$ | $n \times 1$ |
| $\mathbf{A} = \mathbf{X}^\top\mathbf{X}$ | Covariance-type matrix | $m \times m$ |
| $\lambda_j, \mathbf{q}_j$ | Eigenvalues and eigenvectors of $\mathbf{A}$ | scalar, $m \times 1$ |

</div>

- **When you get lost, check the shapes:** $\mathbf{Xv}$ is $(n \times m)(m \times 1) \rightarrow (n \times 1)$, one number per observation

---
level: 3
---

# Step 0: Center Your Data

- Running example: simulated math and reading scores for 100 students ($n = 100$, $m = 2$)
- Center (or _de-mean_) your data by subtracting each column's mean: $x_{ij} \rightarrow x_{ij} - \bar{x}_j$
- Every line in PCA passes through the origin, so we move the middle of the data cloud to the origin
  - Centering makes the average squared projection measure _variance_ 
  - This makes $\mathbf{X}^\top\mathbf{X} / (n-1)$ the _covariance_ matrix
- If your variables are on very different scales, also divide each column by its standard deviation
  - In this case $\mathbf{X}^\top\mathbf{X}/(n-1)$ is the _correlation_ matrix
- In `R`: `scale(X, center = TRUE, scale = FALSE)` centers your data
  - Change `scale = TRUE` to also divide by the standard deviation of each column
  - Many PCA implementations center your data by default
- From here on, we assume $\mathbf{X}$ has been centered

---
level: 3
layout: image
image: /pca-centering.png
backgroundSize: contain
---

---
level: 3
---

# Principal Component Analysis

- The first _principal component_ (when $k=1$) is a special type of "best-fit line" that minimizes the average squared Euclidean distance (or _reconstruction error_) between each data point and the line:

$$ \operatorname*{argmin}_{\mathbf{v}:||\mathbf{v}||=1} \frac{1}{n} \sum_{i=1}^n (\text{distance between }\mathbf{x}_i\text{ and the line defined by }\mathbf{v})^2$$

- Note that $||\mathbf{v}|| = \sqrt{\mathbf{v}\cdot\mathbf{v}}$ and is the length of $\mathbf{v}$

---
level: 3
layout: image
image: /pca-lines.png
backgroundSize: contain
---

---
level: 3
layout: image-right
image: /pca-pythagoras.png
backgroundSize: contain
---

# Principal Component Analysis

- Finding that distance is kind of annoying, but we can wiggle this a bit using the Pythagorean theorem
- Each point makes a right triangle with the origin and the line:
  - The hypotenuse is $||\mathbf{x}_i||$
  - Because $||\mathbf{v}|| = 1$, one leg is the shadow, $\mathbf{x}_i\cdot\mathbf{v}$
  - The other leg is the distance we want to minimize

---
level: 3
---

# Principal Component Analysis

- From the Pythagorean theorem on each point's triangle:

$$ \big(\text{dist}(\mathbf{x}_i \rightarrow \text{line})\big)^2 + \big(\mathbf{x}_i\cdot\mathbf{v}\big)^2 = ||\mathbf{x}_i||^2$$

- The RHS doesn't depend on $\mathbf{v}$, so minimizing the first term is _maximizing_ the second term!

$$ \operatorname*{argmax}_{\mathbf{v}:||\mathbf{v}||=1} \frac{1}{n} \sum_{i=1}^n \big(\mathbf{x}_i\cdot\mathbf{v}\big)^2$$

- Because the data are centered, this is the _variance of the projections_ onto $\mathbf{v}$: PCA finds the direction where the data are most spread out


---
level: 3
---

# More Components = More Good

- What about when $k>1$?
- The top-$k$ principal components are the $k$ orthonormal vectors $\mathbf{v}_1, \ldots, \mathbf{v}_k$ that maximize:

$$ \frac{1}{n} \sum_{i=1}^n \sum_{j=1}^k \big(\mathbf{x}_i\cdot\mathbf{v}_j\big)^2 $$

- Orthonormal means the set of vectors we find are orthogonal and normalized so $||\mathbf{v}_j||=1$
  - If $\mathbf{u}, \mathbf{v}$ are orthogonal, $\mathbf{u} \cdot \mathbf{v} = 0$

---
level: 3
---

# A Big Warning

- You may have seen some things that make you think PCA is a lot like OLS regression---**do not be fooled!**
  - They have different uses
  - They minimize different objective functions
- What are the core differences?
  - OLS minimizes the _prediction error_, that is $\sum_i (y_i - \hat{y}_i)^2$
    - Always relative to some favored outcome, $y_i$, and minimizes the squared vertical distance to the line
  - PCA has no outcome variable, and minimizes the _reconstruction error_
    - No favored outcome, so minimizes the squared orthogonal distance to the line

---
level: 3
layout: image
image: /pca-vs-ols.png
backgroundSize: contain
---


---
level: 2
layout: section
---

# Algorithm: Power Iteration

---
level: 3
---

# Rewriting the Optimization Problem of PCA

Let's rewrite our objective function in terms of matrix operations, starting from the $k=1$ case:

$$ \operatorname*{argmax}_{\mathbf{v}:||\mathbf{v}||=1} \frac{1}{n} \sum_{i=1}^n \big(\mathbf{x}_i\cdot\mathbf{v}\big)^2$$

1. We construct a data matrix, $\mathbf{X}$, that has our (centered) observations $\mathbf{x}_1, \ldots, \mathbf{x}_n$ along the rows
2. For a unit vector, $\mathbf{v}$, we can write:

$$ \mathbf{Xv} = \begin{bmatrix}\mathbf{x}_1\cdot\mathbf{v} \\ \vdots \\ \mathbf{x}_n\cdot\mathbf{v} \end{bmatrix}$$

---
level: 3
---

# Rewriting the Optimization Problem of PCA

3. We want the sum of the squares of these, so we take the dot product of $\mathbf{Xv}$ with itself:

$$ (\mathbf{Xv})^\top (\mathbf{Xv}) =\mathbf{v}^\top \mathbf{X}^\top\mathbf{Xv} = \sum_{i=1}^n \big(\mathbf{x}_i\cdot\mathbf{v}\big)^2 $$

4. Now we define a matrix $\mathbf{A} = \mathbf{X}^\top\mathbf{X}$. 
    - Because $\mathbf{X}$ is centered, $\mathbf{A}/(n-1)$ is the covariance matrix (up to a factor of $n-1$
    - $\mathbf{A}$ is the correlation matrix if we also standardized the columns
    - In some applications with uncentered count data, it's called a co-occurrence matrix
5. We use a result from linear algebra: Any symmetric matrix like $\mathbf{A}$ can be rewritten as the product of an orthogonal matrix, $\mathbf{Q}$ (its columns are orthonormal, so $\mathbf{Q}^\top\mathbf{Q} = \mathbf{I}$), a diagonal matrix, $\mathbf{D}$, and $\mathbf{Q}^\top$ like so:

$$ \mathbf{A} = \mathbf{QDQ}^\top $$

---
level: 3
---

# Eigenvectors: Directions That Only Stretch

- An _eigenvector_ $\mathbf{q}$ of a square matrix $\mathbf{A}$ is a direction that $\mathbf{A}$ only stretches (or shrinks) and never turns:

$$ \mathbf{Aq} = \lambda\mathbf{q} $$

- The scalar $\lambda$ is the matching _eigenvalue_: how much stretching happens
- Example:

$$ \begin{bmatrix} 2 & 1 \\ 1 & 2 \end{bmatrix}\begin{bmatrix} 1 \\ 1 \end{bmatrix} = \begin{bmatrix} 3 \\ 3 \end{bmatrix} = 3\begin{bmatrix} 1 \\ 1 \end{bmatrix} \qquad \begin{bmatrix} 2 & 1 \\ 1 & 2 \end{bmatrix}\begin{bmatrix} 1 \\ -1 \end{bmatrix} = 1\begin{bmatrix} 1 \\ -1 \end{bmatrix} \qquad \begin{bmatrix} 2 & 1 \\ 1 & 2 \end{bmatrix}\begin{bmatrix} 1 \\ 0 \end{bmatrix} = \begin{bmatrix} 2 \\ 1 \end{bmatrix} $$

- $(1, 1)$ and $(1, -1)$ are eigenvectors with eigenvalues 3 and 1; $(1, 0)$ got turned, so it isn't one
- Any rescaling of an eigenvector (including flipping its sign) is still an eigenvector, so we usually report the unit-length version
- In $\mathbf{A} = \mathbf{QDQ}^\top$, the columns of $\mathbf{Q}$ are the eigenvectors of $\mathbf{A}$ and the diagonal elements of $\mathbf{D}$ are their eigenvalues

---
level: 3
---

# Pause: Why Do All This?

- Remember that matrices define linear transformations
- What happens when you multiply by a diagonal matrix? 
  - Well, it just scales each individual row ($\mathbf{DM}$) or column ($\mathbf{MD}$) by the diagonal elements of the matrix
- Think of a diagonal matrix, $\mathbf{D}$, as stretching each coordinate axis by a different amount
- Read $\mathbf{A}\mathbf{v} = \mathbf{QDQ}^\top\mathbf{v}$ from right to left:
  1. $\mathbf{Q}^\top$ rotates $\mathbf{v}$ so the eigenvectors line up with the coordinate axes
  2. $\mathbf{D}$ stretches each axis by its eigenvalue
  3. $\mathbf{Q}$ rotates back
- For PCA, we are trying to find the direction that is stretched the most by the covariance matrix, $\mathbf{A} = \mathbf{X}^\top\mathbf{X}$
- We will return to eigenvalues and eigenvectors in a few weeks when we learn the Singular Value Decomposition (SVD), another way to solve this problem!

---
level: 3
---

# The Largest Eigenvector Goes with the Top Principal Component

- Order the eigenvalues $\lambda_1 \ge \lambda_2 \ge \cdots \ge \lambda_m$, with eigenvectors $\mathbf{q}_1, \ldots, \mathbf{q}_m$
- Plug $\mathbf{A} = \mathbf{QDQ}^\top$ into our objective and let $\mathbf{w} = \mathbf{Q}^\top\mathbf{v}$:

$$ \mathbf{v}^\top\mathbf{A}\mathbf{v} = \mathbf{v}^\top\mathbf{QDQ}^\top\mathbf{v} = \mathbf{w}^\top\mathbf{D}\mathbf{w} = \sum_{j=1}^m \lambda_j w_j^2 $$

- $\mathbf{Q}^\top$ only rotates, so $\mathbf{w}$ is still a unit vector: $\sum_j w_j^2 = 1$
- So $\mathbf{v}^\top\mathbf{A}\mathbf{v}$ is a **weighted average of the eigenvalues**, with weights $w_j^2$
- A weighted average is biggest when all the weight is on the biggest number: $\mathbf{w} = (1, 0, \ldots, 0)$, which means $\mathbf{v} = \mathbf{Qw} = \mathbf{q}_1$
- **The first PC is the eigenvector with the largest eigenvalue**, and $\lambda_1/(n-1)$ is the variance of the data along it
- The same argument shows the top-$k$ PCs are the eigenvectors with the $k$ largest eigenvalues

---
level: 3
---

# Power Iteration for Computing Eigenvectors

- This is an iterative method for computing eigenvectors
- The idea: each multiplication by $\mathbf{A}$ multiplies a vector's component along $\mathbf{q}_j$ by $\lambda_j$. The component along $\mathbf{q}_1$ grows fastest, so after many multiplications the vector points (almost) along $\mathbf{q}_1$
  - This finds the eigenvector associated with the largest eigenvalue of matrix $\mathbf{A}$
  - If $\mathbf{A}$ is a covariance matrix, this means we also get the first PC!
- Algorithm:
  1. Select a random unit vector, $\mathbf{u}_0$
  2. For $i = 1,2,\ldots$, set $\mathbf{u}_i = \mathbf{A}\mathbf{u}_{i-1} / ||\mathbf{A}\mathbf{u}_{i-1}||$. If $\mathbf{u}_i \approx \mathbf{u}_{i-1}$, stop
  3. Return $\mathbf{v}_1 = \mathbf{u}_i$, the leading eigenvector (and first PC) of $\mathbf{A}$
- Renormalizing every step keeps the numbers from overflowing (or underflowing), and it's much cheaper than computing $\mathbf{A}^i$

---
level: 3
---

# Power Iteration by Hand

Using $\mathbf{A} = \begin{bmatrix} 2 & 1 \\ 1 & 2 \end{bmatrix}$ ($\lambda_1 = 3$, $\lambda_2 = 1$) and starting from $\mathbf{u}_0 = (1, 0)$:

<div class="text-sm">

| Step $i$ | 1 | 2 | 3 | 4 | $\cdots$ |
| --- | --- | --- | --- | --- | --- |
| $\mathbf{A}^i\mathbf{u}_0$ (unnormalized) | $(2, 1)$ | $(5, 4)$ | $(14, 13)$ | $(41, 40)$ | |
| $\mathbf{u}_i$ (normalized) | $(0.894, 0.447)$ | $(0.781, 0.625)$ | $(0.733, 0.680)$ | $(0.716, 0.698)$ | $\rightarrow (0.707, 0.707) = \mathbf{q}_1$ |

</div>

- The leftover piece along $\mathbf{q}_2$ shrinks by a factor of about $\lambda_2 / \lambda_1 = 1/3$ every step
  - Fast when $\lambda_1 \gg \lambda_2$, slow when they're close, and it fails if $\lambda_1 = \lambda_2$
- It also fails if $\mathbf{u}_0$ is exactly orthogonal to $\mathbf{q}_1$, which a random start makes essentially impossible

---
level: 3
---

# Checking Your Work in `R`

<div class="grid grid-cols-2 gap-6">
<div>

```r
X <- scale(scores, center = TRUE,
                   scale = FALSE)
A <- crossprod(X) # t(X) %*% X

eigen(A)
# $values
# [1] 13062.957  1942.355
# $vectors
#            [,1]       [,2]
# [1,] -0.7949893  0.6066234
# [2,] -0.6066234 -0.7949893

prcomp(scores)$rotation
#               PC1        PC2
# math    0.7949893 -0.6066234
# reading 0.6066234  0.7949893
```

</div>
<div>

- Same PCs, up to sign: $\mathbf{v}$ and $-\mathbf{v}$ describe the same line
- `eigen(A)$values / (n - 1)` matches `prcomp(scores)$sdev^2`: the variance along each PC (131.9 and 19.6)
- The first PC puts positive weight on both math and reading: it's roughly "overall achievement"
- On PS4, your power iteration should match these, up to sign!

</div>
</div>

---
level: 3
---

# Finding Additional PCs

- After the first instance of power iteration, we have the top-1 PC
- To find the next PC:
  1. Remove each observation's component along $\mathbf{v}_1$ (project it onto the space orthogonal to $\mathbf{v}_1$): $\mathbf{x}_i \rightarrow \mathbf{x}_i - (\mathbf{x}_i \cdot \mathbf{v}_1)\mathbf{v}_1$
  2. Recompute $\mathbf{A}$ from the projected data and carry out power iteration again to find the next PC
  3. Repeat steps 1&2 until you want to stop finding PCs
- Finding PCs one at a time like this is a _greedy_ strategy (we'll come back to this idea, too). For PCA, greedy happens to give exactly the best top-$k$ solution
- Typically, you can plot the eigenvalues in a _scree plot_ and treat it like the "elbow plots" from $k$-Means. If you standardized your variables, some people keep the PCs whose correlation-matrix eigenvalues are above one (the average). Sometimes people only keep the first 2-3 if they're just making plots.
  - Freak what you feel
- PS4 has you implementing Power Iteration to do PCA!

---
level: 3
---

# A Neat Power Iteration Application: PageRank

- Google PageRank is just power iteration to find the first eigenvector of a web transition matrix!
- The idea was that "important pages are linked to by important pages"
- They simulated web browsing as a random walk around the web graph
- They began by putting together a web-adjacency matrix, $\mathbf{A}$, where $\mathbf{A}_{ij} = 1$ if page $j$ links to page $i$ and $\mathbf{A}_{ij} = 0$ otherwise
- $\mathbf{A}$ got column normalized, so each column sums to 1 and $\mathbf{A}_{ij}$ represents the probability of navigating to page $i$ from page $j$
  - Pages with no outgoing links get a column of $1/N$, so every column still sums to 1
- To simulate a bored web surfer, with probability $\beta = 0.15$ you jump to a page chosen uniformly at random from all $N$ pages (the original paper's "damping factor" is $1 - \beta = 0.85$):

$$ \mathbf{G} = (1-\beta)\mathbf{A} + \frac{\beta}{N}\begin{bmatrix} 1 & \cdots & 1 \\ \vdots & \ddots & \vdots \\ 1 & \cdots & 1 \end{bmatrix} $$

---
level: 3
---

# A Neat Power Iteration Application: PageRank

- How do you solve this problem, then?
- You find the first eigenvector of $\mathbf{G}$ through power iteration! (Its eigenvalue is exactly 1)
- Rescale it so its entries sum to 1 (instead of having unit length), and it gives the long-run probability that a random web surfer is on each page, providing a measure of importance!
- Power iteration will show up again when we discuss Markov Chain Monte Carlo
- You'll apply it to measuring individual importance in a political network in a later pset
- More generally, modified versions of PageRank are a great way to measure importance in both directed and undirected networks


---
level: 2
layout: section
---

# Back to PCA

---
level: 3
---

# Using PCA

- PCs are often really interpretable
  - Look at which variables have the largest positive and largest negative weights (_loadings_)---do they have things in common?
  - When you project your original data into the lower-dimensional PC space, do observations that score high/low on some dimensions have things in common?
- Really commonly used to visualize data
- Also commonly used to "cluster" variables that may measure similar things
- Also can be used to "cluster" observations along the PCs
- PS4 will have you not only implementing PCA from scratch, but also exploring some of its properties!


---
level: 3
---

# A Neat PCA Application: Genes

- A 2008 genetics paper published in _Nature_ did something _very_ cool with PCA!
- They took 3000 genotyped Europeans and performed PCA on their genomes. Then they plotted the individuals' projections onto the top 2 components.
  - What do you think the top two PCs captured?
  - What do you think they saw?
- John Novembre, Toby Johnson, Katarzyna Bryc, Zoltán Kutalik, Adam R. Boyko, Adam Auton, Amit Indap, Karen S. King, Sven Bergmann, Matthew R. Nelson, Matthew Stephens, and Carlos D. Bustamante. (2008) Genes mirror geography within Europe. _Nature_, 456:98–101.


---
level: 3
layout: image
image: /pca-genes.png
backgroundSize: contain
---
