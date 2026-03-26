---
level: 1
layout: section
---

# Model-Based Clustering

---
level: 2
---

# Finite Mixture Models

- If we have a random variable $X$ that is Gaussian, we can write down the PDF:

$$p(x) = \frac{1}{\sigma\sqrt{2\pi}} \exp\bigg[ - \frac{(x-\mu)^2}{2\sigma^2}\bigg] = \mathcal{N}(x;\mu, \sigma^2)$$

- Now let's say there $K$ different normal distributions that each observation could come from, and each observation also comes with a _latent_ assignment, $\theta_i$ that says which normal it came from
  - Remember we don't ever get to see these assignments!
- For each data point, we can write down the conditional PDF:

$$p(x|\theta=k) = \mathcal{N}(x;\mu_k, \sigma_k^2)$$

---
level: 3
---

# Finite Mixture Models

- Remember this is only actually useful, however, if we know $\theta$!
- Instead, we write down a _mixture_ of distributions:

$$p(x_i) = \sum_{k=1}^K \pi_{ki}\mathcal{N}(x_i;\mu_k, \sigma_k^2)$$
$$\sum_{k=1}^K \pi_{ki} = 1 $$

- Here, $\pi_{ki}$ is a _mixing parameter_ that is the estimated probability observation $i$ was drawn from Gaussian $k$
- In practice, we can do a mixture of any probability density function
  - Spoiler: We can make IRT models that are mixtures of different item response functions!


---
level: 2
---

# Gaussian Mixture Models (GMMs)

- We model the distribution of our data as a sum of multivariate Gaussian
- We estimate:
  - The mean of each Gaussian, $\mu_k$
  - A covariance matrix for each Gaussian, $\Sigma_k$
  - The probability each point belongs to each Gaussian, $\pi_{ki}$
- This gives us:
  - "Soft clustering" where we each observation comes with a probability it's assigned to each cluster
  - Means of each Gaussian that are interpretable as centers
  - The ability to have non-spherical clusters
- What's the downside?
  - If we don't restrict the covariance matrix, a solution with $N$ observations and $M$ variables and $G$ Gaussians has $G(M+M^2) + N(G-1) $ parameters
  - A comparable $k$-means solution only estimates $kM$ parameters!

---
level: 2
---

# GMM Structure

- The typical way to reduce the number of estimated parameters is to restrict the covariance matrix for each Gaussian.
- Models are abbreviated with a three letter code
  - The first letter is for volume, the second is for shape, the third is for orientation
  - 'E' means equal
  - 'V' means varying
  - 'I' is just a placeholder

---
level: 3
layout: center
---

![](/gmm.jpg)