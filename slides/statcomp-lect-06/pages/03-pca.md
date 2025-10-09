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

- **Key Idea:** We can represent our data in a matrix, $\mathbf{X}$, and then construct another matrix that projects our data into a lower dimensional space ($m < n$) that has nice properties derived from the structure of $\mathbf{X}$ so that it preserves a bunch of really important information in $\mathbf{X}$ and makes it easier to look at!
- What kind of structure can we find? How do we find it in a smart way?
- Today we'll introduce _Principal Component Analysis_ (PCA) as one way to find structure and then look at a way to do it
- The overarching goal of PCA:
  - We have data, comprised of $n$ $m$-dimensional vectors, $\mathbf{x}_1, \ldots, \mathbf{x}_n$ 
    - Here, $n$ is our number of observations and $m$ is our number of variables
  - We want to express this data matrix as linear combinations of $k$ $m$-dimensional vectors, $\mathbf{v}_1, \ldots, \mathbf{v}_k$, so that $\mathbf{x}_i \approx \sum_{j=1}^k a_{ij} \mathbf{v}_j$
  - We want $k < m$, so the collection of $k$ vectors is a good approximation of the information in our original $m$ variables

---
level: 3
---

# Principal Component Analysis

- The first _principal component_ (when $k=1$) is a special type of "best-fit line" that minimizes the average squared Euclidean distance (or _reconstruction error_) between each data point and the line:

$$ \operatorname*{argmin}_{\mathbf{v}:||\mathbf{v}||=1} \frac{1}{n} \sum_{i=1}^n (\text{distance between }\mathbf{x}_i\text{ and the line defined by }\mathbf{v})^2$$

- Note that $||\mathbf{v}|| = \sqrt{\mathbf{v}\cdot\mathbf{v}}$ and is the length of $\mathbf{v}$

---
level: 3
---

# Principal Component Analysis

- Finding that distance is kind of annoying, but we can wiggle this a bit using the Pythagorean theorem

$$ \big(\text{dist}(\mathbf{x}_i \rightarrow \text{line})\big)^2 + \big(\mathbf{x_i}\cdot\mathbf{v}\big)^2 = ||\mathbf{x}_i||^2$$

- Because the RHS is a constant, minimizing the first term is _maximizing_ the second term!

$$ \operatorname*{argmax}_{\mathbf{v}:||\mathbf{v}||=1} \frac{1}{n} \sum_{i=1}^n \big(\mathbf{x_i}\cdot\mathbf{v}\big)^2$$

- This means PCA is maximizing the average variance in $\mathbf{x_i}$ explained by the line defined by $\mathbf{v}$


---
level: 3
---

# More Components = More Good

- What about when $k>1$?
- The Top-$k$ Principal Components are the $k$ orthonormal vectors $\mathbf{v}_1, \ldots, \mathbf{v}_k$ that maximize:

$$ \frac{1}{n} \sum_{i=1}^n \sum_{j=1}^k \big(\mathbf{x_i}\cdot\mathbf{v}_j\big)^2 $$

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
    - Always relative to some favored outcome, $y_i$, and minimizes the vertical distance to the line
  - PCA has no outcome variable, and minimizes the _reconstruction error_
    - No favored outcome, so minimizes the orthogonal distance to the line
    
---
level: 3
layout: image
image: /pca-ols.png
backgroundSize: contain
---

# Contrasting OLS and PCA


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

$$ \operatorname*{argmax}_{\mathbf{v}:||\mathbf{v}||=1} \frac{1}{n} \sum_{i=1}^n \big(\mathbf{x_i}\cdot\mathbf{v}\big)^2$$

1. We construct a data matrix, $\mathbf{X}$, that has our observations $\mathbf{x}_1, \ldots, \mathbf{x}_n$ along the rows
2. For a unit vector, $\mathbf{v}$, we can write:

$$ \mathbf{Xv} = \begin{bmatrix}\mathbf{x}_1\cdot\mathbf{v} \\ \vdots \\ \mathbf{x}_n\cdot\mathbf{v} \end{bmatrix}$$

---
level: 3
---

# Rewriting the Optimization Problem of PCA

3. We want the sum of the squares of these, so we take the dot product of $\mathbf{Xv}$ with itself:

$$ (\mathbf{Xv})^\top (\mathbf{Xv}) =\mathbf{v}^\top \mathbf{X}^\top\mathbf{Xv} = \sum_{i=1}^n \big(\mathbf{x_i}\cdot\mathbf{v}\big)^2 $$

4. Now we define a matrix $\mathbf{A} = \mathbf{X}^\top\mathbf{X}$, which we call the covariance, correlation, or co-occurrence matrix (depending on if the columns of $\mathbf{X}$ were normalized and the specific application)
5. We use a result from linear algebra: Any symmetric square matrix like $\mathbf{A}$ can be rewritten as the product of an orthonormal matrix, $\mathbf{Q}$ and a diagonal matrix, $\mathbf{D}$ like so:

$$ \mathbf{A} = \mathbf{Q}^\top \mathbf{DQ} $$

---
level: 3
---

# Pause: Why do all this?

- Remember that matrices define linear transformations---projections into spaces of different dimensions.
- What happens when you multiply a diagonal matrix? Well, it just scales each individual column or row (depending on how the multiplication is set up) by the diagonal elements of the matrix
- Think of this as a diagonal matrix, $\mathbf{D}$, stretching the dimensions of a matrix that you multiply it by
- For PCA, we are trying to find the dimensions that are stretched the most by the covariance matrix, $\mathbf{A} = \mathbf{X}^\top\mathbf{X}$
- As such, the top-$k$ PCs of $\mathbf{A}$ are the columns of $\mathbf{Q}$ that correspond with the largest $k$ diagonal elements of $\mathbf{D}$
- The columns of the orthonormal matrix $\mathbf{Q}$ are the _eigenvectors_ of $\mathbf{A}$ and the associated diagonal elements of $\mathbf{D}$ are their _eigenvalues_
- We will return to eigenvalues and eigenvectors in a few weeks when we learn the Singular Value Decomposition---another way to solve this problem!

---
level: 3
---

# Power Iteration for Computing Eigenvectors

- This is an iterative method for computing eigenvectors
- The idea is that if multiplication by $\mathbf{A}$ is going to stretch a vector the most in the direction of the largest variance, if we apply multiplication by $\mathbf{A}$ repeatedly, we will eventually end up with a vector that points in the direction of the largest variance
  - This finds the eigenvector associated with the largest eigenvalue of matrix $\mathbf{A}$
  - If $\mathbf{A}$ is a covariance matrix, this means we also get the first PC!
- Algorithm:
  1. Select a random unit vector, $\mathbf{u}_0$
  2. for $i = 1,2,\ldots$, set $\mathbf{u}_i = \mathbf{A}^i\mathbf{u}_0$. If $\mathbf{u}_i / ||\mathbf{u}_i|| \approx \mathbf{u}_{i-1} / ||\mathbf{u}_{i-1}||$, stop
  3. Return $\mathbf{u}_i / ||\mathbf{u}_i||$
- $\mathbf{v}_1 = \mathbf{u}_i / ||\mathbf{u}_i||$ is the largest eigenvector (and first PC) of $A$

---
level: 3
---

# Finding Additional PCs

- After the first instance of power iteration, we have the top-1 PC
- To find the next PC:
  1. Project the data matrix orthogonally onto $\mathbf{v}_1$: $\mathbf{x}_i \rightarrow \mathbf{x}_i - (\mathbf{x}_i \cdot \mathbf{v}_1)\mathbf{v}_1$
  2. Carry out power iteration on the projected data to find the next PC
  3. Repeat steps 1&2 until you want to stop finding PCs
- This makes power iteration a _greedy_ algorithm (we'll come back to this idea, too)
- Typically, you can plot the eigenvalues and treat it like the "elbow plots" from $k$-Means. Sometimes people stop when the eigenvalues get below one. Sometimes people only keep the first 2-3 if they're just making plots.
  - Freak what you feel
- PS4 has you implementing Power Iteration to do PCA!

---
level: 3
---

# A Neat Power Iteration Application: PageRank

- The original Google PageRank Algorithm is just power iteration to find the first eigenvector of the web transition matrix!
- The idea was that "important pages link to important pages"
- They simulated web browsing as a random walk around the web graph
- They began by putting together a web-adjacency matrix, $\mathbf{A}$, where $\mathbf{A}_{ij} = 1$ if page $i$ is linked to by $j$ and $\mathbf{A}_{ij} = 0$ otherwise
- Then they simulated random web browsing behavior by defining a transition probability, $\beta=0.05$, that you move to a random webpage that isn't linked from your current spot
- $\mathbf{A}$ got column normalized, so the entries summed to 1, so $\mathbf{A}_{ij}$ represents the probability of navigating to page $i$ from page $j$

---
level: 3
---

# A Neat Power Iteration Application: PageRank

- How do you solve this problem, then?
- You find the first eigenvector of $\mathbf{A}$ through power iteration! 
- This eigenvector represents the probability that a random web browser will be on any individual website, providing a measure of importance!
- Power iteration will show up again when we discuss Markov Chain Monte Carlo
- You'll apply it to measuring individual importance in a political network in a later pset
- But, generally, power iteration can be a powerful way to understand importance in directed and undirected networks through a modified application of PageRank


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
  - Look at what variables are the largest positive and largest negative weights---do they have things in common?
  - When you project your original data into the lower dimensional PC space, do observations that score high/low on some dimensions have things in common?
- Really commonly used to visualize data
- Also commonly used to "cluster" variables that may measure similar things
- Also can be used to "cluster" observations along the PCs
- PS4 will have you not only implementing PCA from scratch, but also exploring some of its properties!


---
level: 3
---

# A Neat PCA Application: Genes

- A genetics paper in 2008 published in Nature did something _very_ cool with PCA!
- They took 3000 genotyped Europeans and performed PCA on their genomes. Then they plotted the individuals' projections onto the top 2 components
  - What do you think the top two PCs captured?
  - What do you think they saw?
- John Novembre, Toby Johnson, Katarzyna Bryc, Zolt´an Kutalik, Adam R. Boyko, Adam Auton, Amit Indap, Karen S. King, Sven Bergmann, Matthew R. Nelson, Matthew Stephens, and Carlos D. Bustamante. (2008) Genes mirror geography within Europe. _Nature_, 456:98–101.

  
---
level: 3
layout: image
image: /pca-genes.png
backgroundSize: contain
---