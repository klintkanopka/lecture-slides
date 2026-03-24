---
level: 1
layout: section
---

# Estimation Methods

---
level: 3
hideInToc: true
---

# The joy of coin flipping

- I flip a coin fifteen times and get the results: $X=\{H,H,H,T,H,T,H,T,H,H,H,T,T,H,H\}$
  - What do you think about this result?

<v-click>

- What if I told you I'm a _prolific_ cheater with an extensive collection of weighted coins?
  - Given this information, what do you think $P(H)$ is for the coin I'm flipping?
  - Do this now!

</v-click>
<v-click>

- How would you construct your _best_ estimate of $P(H)$?
  - Maximum likelihood estimation (MLE) to the rescue!

</v-click>

---
level: 2
---

# Maximum Likelihood Estimation (MLE)

- Let's start by saying describing heads as an individual observation $x_i = 1$ and we seek to estimate the parameter, $p$, that captures this probability

<v-click>

- We need to estimate $p$ from the data we have, $X$
  - Formally, we put hats on estimated quantities: $\hat{p}$


</v-click>
<v-click>

- We first write down the _likelihood function_, $P(\theta|X)$ 
  - Often written $\mathcal{L}(\theta|X)$

</v-click>

---
level: 3
---

# Maximum Likelihood Estimation (MLE)

- For an individual coin flip:
  $$\mathcal{L}(p|X=x) = p^{x}(1-p)^{1-x}$$
  - When $x=1$, we get $p$ (the probability of flipping $H$)
  - When $x=0$, we get $1-p$ (the probability of flipping $T$)


<v-click>

- For a bunch of coin flips $X=\{x_1, x_2, \ldots,x_n\}$:

$$\mathcal{L}(p|X) = \prod_{x_i \in X} p^{x_i}(1-p)^{1-x_i}$$

</v-click>

---
level: 3
---

# Maximizing the likelihood

- If we flip $n$ heads and $m$ tails, we can rewrite the likelihood:
$$ \mathcal{L}(p|X) = p^{n}(1-p)^{m} $$
- To maximize, set $\frac{d\mathcal{L}}{dp}=0$:

<v-click>

$$\frac{d\mathcal{L}}{dp} = np^{n-1}(1-p)^m - mp^n (1-p)^{m-1} $$

</v-click>
<v-click>

$$\frac{d\mathcal{L}}{dp} = p^{n-1}(1-p)^{m-1}\big(n(1-p) - mp \big) $$

</v-click>
<v-click>

$$n(1-\hat{p}_{MLE}) - m\hat{p}_{MLE}  = 0 $$

</v-click>
<v-click>

$$n = \hat{p}_{MLE} (n+m) $$

</v-click>
<v-click>

$$\hat{p}_{MLE} = \frac{n}{n+m} $$

</v-click>


---
level: 3
---

# Circling back:

- The maximum likelihood estimator for the probability of success (heads) in a Bernoulli trial (coinflip) is:
$$ \hat{p}_{MLE} = \frac{n}{n+m}$$
- For my original example this is:
$$\hat{p}_{MLE} = \frac{10}{10+5} \approx 0.667$$
- We are going to think about dichotomous responses to items as coin flips and then model the underlying probability!
- But first, a new challenger has appeared...

---
level: 3
---

# A new, scummier, question

- As a known cheater with weighted coins, I am going to pull _two_ out, with unknown true probabilities $p_A, p_B$

<v-click>

- I will select a coin at random and flip it ten times
  - I will only tell you the results of the ten flips, but **not** which coin produced them
  - I will, however, generate multiple sequences, selecting a coin at random each time
  - Each sequence of coin flips has a _latent_ coin assignment, $\theta_i \in \{A,B\}$, that dictates what coin generated the data
  - We _never_ get to observe this information. The $\theta_i$s are completely unrecoverable


</v-click>
<v-click>

- What is your best guess at the weights of these two coins?
  - Specifically, compute $\hat{p}_A, \hat{p}_B$
  - What could you try here?

</v-click>

---
level: 3
---

# Try something!

Here are data from five sets of ten coin flips:

1. $H,T,T,T,H,H,H,H,T,T$
2. $H,H,H,H,T,H,H,H,H,H$
3. $H,T,H,H,H,H,H,T,H,H$
4. $H,T,H,T,T,T,H,H,T,T$
5. $T,H,H,H,T,H,H,H,T,H$

Estimate $\hat{p}_A, \hat{p}_B$!


---
level: 2
---

# The Expectation-Maximization Algorithm

- This is a new type of missing data problem
  - We never get the latent coin assignments, $\theta_1, \cdots, \theta_5$
  - With these, the problem is _super_ easy
- The strategy is to estimate both the parameters we care about, $p_A, p_B$, and the latent coin assignments, $\theta_1, \cdots, \theta_5$, _at the same time_
  - We do this using the Expectation-Maximization (EM) Algorithm
- Iterative algorithm 
  - Treats the latent assignments as a _probability distribution_
  - Allows us to create a weighted set of data that represents all possible coin assignments (E-step)
  - Then we estimate our parameters $\hat{p}_A, \hat{p}_B$ from that (M-step)
  - Repeat until convergence!

---
level: 3
---

# The E-Step

- We start from some initial parameter estimates: $\hat{p}_A^{(0)}=0.6, \hat{p}_B^{(0)}=0.5$
- We compute the likelihood of observing each string of flips under each coin assignment
$$ \mathcal{L}(p|X) = p^{n}(1-p)^{m} $$
- Normalize the likelihoods to find the distribution $P(\theta_i)$
$$P\big(\theta_i^{(1)}=A\big) = \frac{\mathcal{L}(\hat{p}_A^{(0)},X)}{\mathcal{L}(\hat{p}_A^{(0)},X) + \mathcal{L}(\hat{p}_B^{(0)},X)}$$

---
level: 3
---

# The E-Step

| $H,T$  | $\mathcal{L}(\hat{p}_A^{(0)},X)$ | $\mathcal{L}(\hat{p}_B^{(0)},X)$ | $P\big(\theta_i^{(1)}=A\big)$ | $P\big(\theta_i^{(1)}=B\big)$ |
|--------|----------------------------------|----------------------------------|-------------------------------|-------------------------------|
| $5, 5$ | $0.6^5\cdot 0.4^5$ | $0.5^5\cdot 0.5^5$ | 0.45 | 0.55 |
| $9, 1$ | $0.6^9\cdot 0.4^1$ | $0.5^9\cdot 0.5^1$ | 0.80 | 0.20 |
| $8, 2$ | $0.6^8\cdot 0.4^2$ | $0.5^8\cdot 0.5^2$ | 0.73 | 0.27 |
| $4, 6$ | $0.6^4\cdot 0.4^6$ | $0.5^4\cdot 0.5^6$ | 0.35 | 0.65 |
| $7, 3$ | $0.6^7\cdot 0.4^3$ | $0.5^7\cdot 0.5^3$ | 0.65 | 0.35 |


---
level: 3
---

# The M-Step

- We use the weights from the previous step to weight the observations and compute new parameter estimates: $\hat{p}_A^{(1)}, \hat{p}_B^{(1)}$


| $H,T$  | Coin $A$    | Coin $B$    |
|--------|-------------|-------------|
| $5, 5$ | $2.2H,2.2T$ | $2.8H,2.8T$ |
| $9, 1$ | $7.2H,0.8T$ | $1.8H,0.2T$ |
| $8, 2$ | $5.9H,1.5T$ | $2.1H,0.5T$ |
| $4, 6$ | $1.4H,2.1T$ | $2.6H,3.9T$ |
| $7, 3$ | $4.5H,1.9T$ | $2.5H,1.1T$ |

$$\hat{p}^{(1)}_A \approx \frac{21.3}{21.3 + 8.6} \approx 0.71;\ 
\hat{p}^{(1)}_B \approx \frac{11.7}{11.7 + 8.4} \approx 0.58$$

---
level: 3
---

# Doing it in code

```r
flips <- matrix(c(5, 9, 8, 4, 7, 5, 1, 2, 6, 3), 
                nrow=5, ncol=2, byrow=F)
p_new <- c(0.6, 0.5)
p_old <- c(0,0)

while(!identical(round(p_old,2), round(p_new,2))){
  p_old <- p_new
  p <- matrix(p_new, nrow=5, ncol=2, byrow=T)
  likelihood <- p^flips * (1-p)^(10-flips)
  theta <- likelihood / rowSums(likelihood)
  theta_A <- theta[,1]*flips
  theta_B <- theta[,2]*flips
  p_new <- c(sum(theta_A[,1])/sum(theta_A), 
             sum(theta_B[,1])/sum(theta_B)) 
  print(round(p_new,2))
}
```
````md magic-move
```
# Results go here
```
```
[1] 0.71 0.58
```
```
[1] 0.71 0.58
[1] 0.76 0.48
```
```
[1] 0.71 0.58
[1] 0.76 0.48
[1] 0.78 0.52
```
```
[1] 0.71 0.58
[1] 0.76 0.48
[1] 0.78 0.52
[1] 0.79 0.50
```
```
[1] 0.71 0.58
[1] 0.76 0.48
[1] 0.78 0.52
[1] 0.79 0.50
[1] 0.79 0.51
```
```
[1] 0.71 0.58
[1] 0.76 0.48
[1] 0.78 0.52
[1] 0.79 0.50
[1] 0.79 0.51
[1] 0.80 0.51
```
```
[1] 0.71 0.58
[1] 0.76 0.48
[1] 0.78 0.52
[1] 0.79 0.50
[1] 0.79 0.51
[1] 0.80 0.51
[1] 0.80 0.51
```
````


---
level: 1
layout: section
---

# Break
