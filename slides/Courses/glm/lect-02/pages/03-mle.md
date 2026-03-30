---
level: 1
layout: section
---

# Maximum Likelihood Estimation

---
level: 2
---

# Likelihood

<v-clicks depth="2">

- The likelihood treats the data as fixed and the parameter values as variable
- For one Bernoulli trial:
  $$
  f(x \mid p) = p^x(1-p)^{1-x}
  $$
- The likelihood has the same algebraic form:
  $$
  \mathcal{L}(p \mid x) = p^x(1-p)^{1-x}
  $$
- For many trials $X$:
  $$
  \mathcal{L}(p \mid X) = \prod_{x \in X} p^x(1-p)^{1-x}
  $$

</v-clicks>

---
level: 2
hideInToc: true
---

# Why Use the Log Likelihood?

<v-clicks depth="2">

- Maximum likelihood estimation picks the parameter values that make the observed data most likely
- Products of many probabilities become extremely small
- Derivatives are easier to work with when products become sums
- The log is monotonic, so the parameter values that maximize the likelihood also maximize the log likelihood

</v-clicks>

---
level: 3
---

# Bernoulli Log Likelihood

Starting from:

$$
\mathcal{L}(p \mid x) = p^x(1-p)^{1-x}
$$

<v-clicks>

$$
\ell(p \mid x) = \log\left[p^x(1-p)^{1-x}\right]
$$

$$
\ell(p \mid x) = \log p^x + \log(1-p)^{1-x}
$$

$$
\ell(p \mid x) = x \log p + (1-x)\log(1-p)
$$

</v-clicks>

<v-click>

- Now instead of a product across many trials:
$$
\mathcal{L}(p \mid X) = \prod_{x \in X} p^x(1-p)^{1-x}
$$

</v-click>
<v-click>

- The log likelihood lets us write a sum:

$$
\ell(p \mid X) = \sum_{x \in X} x \log p + (1-x)\log(1-p)
$$

</v-click>

---
level: 2
---

# Our First MLE: Bernoulli Trials

If a coin is flipped $100$ times and comes up heads $63$ times, what is your best estimate of $p$?

<v-clicks>

- We will estimate this using MLE!
- Note that 63 (the number of successes) is the _sufficient statistic_ for $p$

</v-clicks>


<v-click>

- How do we go about maximizing the log likelihood?

$$
\ell(p \mid X) = \sum_{x \in X} x \log p + (1-x)\log(1-p)
$$

</v-click>

---
level: 3
---

# Deriving the MLE

Starting from the log likelihood:

$$
\ell(p \mid X) = \sum_{x \in X} x \log p + (1-x)\log(1-p)
$$


<v-clicks>

Let $N$ be the number of trials and $n$ the number of successes:

$$
\ell(p \mid X) = n \log p + (N - n)\log(1-p)
$$

Differentiate and set equal to zero:

$$
\frac{d}{dp}\left[n \log p + (N-n)\log(1-p)\right] = 0
$$

$$
\frac{n}{\hat{p}_{MLE}} - \frac{N-n}{1-\hat{p}_{MLE}} = 0
$$

</v-clicks>

---
level: 3
---

# Solving the MLE

<v-clicks>

$$
\frac{n}{\hat{p}_{MLE}} = \frac{N-n}{1-\hat{p}_{MLE}}
$$

$$
n - n\hat{p}_{MLE} = N\hat{p}_{MLE} - n\hat{p}_{MLE}
$$

$$
n = N\hat{p}_{MLE}
$$

$$
\hat{p}_{MLE} = \frac{n}{N}
$$

</v-clicks>

---
level: 3
---

# Interpretation

<v-clicks depth="2">

- For repeated Bernoulli trials, the MLE of $p$ is the sample proportion of successes
- For binary data coded as $x \in \{0,1\}$, that is also the sample mean

</v-clicks>
<v-click>

$$
\hat{p}_{MLE} = \bar{X} = \frac{1}{N}\sum_{x \in X} x
$$

</v-click>

---
level: 2
---

# Linear Regression via MLE


Recall a simple linear regression:

$$
Y_i = \beta_0 + \beta_1 X_i + \epsilon_i
$$

<v-clicks>

$$
\epsilon_i \sim \mathcal{N}(0,\sigma^2)
$$

Consider the normal PDF:

$$
f(x) = \frac{1}{\sqrt{2\pi\sigma^2}} \exp \bigg(-\frac{(x-\mu)^2}{2\sigma^2}\bigg)
$$

We can write down the probability of observing our data:

$$
P(Y_i \mid X_i, \beta_0, \beta_1, \sigma^2) = \frac{1}{\sqrt{2\pi\sigma^2}} \exp \bigg(- \frac{\big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2}{2\sigma^2}\bigg)
$$

$$
P(Y \mid X, \beta_0, \beta_1, \sigma^2) = \prod_i^N \frac{1}{\sqrt{2\pi\sigma^2}} \exp \bigg(- \frac{\big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2}{2\sigma^2}\bigg)
$$

</v-clicks>

---
level: 3
---

# Linear Regression via MLE


Turn this into a likelihood:

$$
\mathcal{L}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) = \prod_i^N \frac{1}{\sqrt{2\pi\sigma^2}} \exp \bigg(- \frac{\big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2}{2\sigma^2}\bigg)
$$

<v-clicks>

$$
\mathcal{\ell}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) = \sum_i^N \log \bigg[ \frac{1}{\sqrt{2\pi\sigma^2}} \exp \bigg(- \frac{\big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2}{2\sigma^2}\bigg)\bigg]
$$

$$
\mathcal{\ell}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) = \sum_i^N \log \bigg[ \frac{1}{\sqrt{2\pi\sigma^2}}\bigg] + \sum_i^N \log \bigg[\exp \bigg(- \frac{\big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2}{2\sigma^2}\bigg)\bigg]
$$

$$
\mathcal{\ell}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) = N \log \big[2\pi\sigma^2\big]^{-\frac{1}{2}} - \sum_i^N  \frac{\big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2}{2\sigma^2}
$$

$$
\mathcal{\ell}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) = -\frac{N}{2} \log \big[2\pi\big]-\frac{N}{2} \log \big[\sigma^2\big] - \frac{1}{2\sigma^2} \sum_i^N \big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2
$$

</v-clicks>

---
level: 3
---

# Linear Regression via MLE

Start taking partial derivatives and setting them equal to zero:

$$
\mathcal{\ell}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) = -\frac{N}{2} \log \big[2\pi\big]-\frac{N}{2} \log \big[\sigma^2\big] - \frac{1}{2\sigma^2} \sum_i^N \big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2
$$

<v-clicks>
$$
\frac{\partial}{\partial \beta_0} \mathcal{\ell}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) =\frac{\partial}{\partial \beta_0} \bigg[ -\frac{N}{2} \log \big[2\pi\big]-\frac{N}{2} \log \big[\sigma^2\big] - \frac{1}{2\sigma^2} \sum_i^N \big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2 \bigg]
$$

$$
\frac{\partial}{\partial \beta_0} \mathcal{\ell}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) = \frac{\partial}{\partial \beta_0} \bigg[- \frac{1}{2\sigma^2} \sum_i^N \big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2 \bigg]
$$

$$
\frac{1}{\sigma^2} \sum_i^N \big(Y_i-(\beta_0 + \beta_1 X_i)\big) = 0
$$

$$
\sum_i^N \big(Y_i-(\beta_0 + \beta_1 X_i)\big) = 0
$$

</v-clicks>


---
level: 3
---

# Linear Regression via MLE

Repeat for $\beta_1$:

$$
\mathcal{\ell}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) = -\frac{N}{2} \log \big[2\pi\big]-\frac{N}{2} \log \big[\sigma^2\big] - \frac{1}{2\sigma^2} \sum_i^N \big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2
$$

<v-clicks>

$$
\frac{\partial}{\partial \beta_1} \mathcal{\ell}(\beta_0, \beta_1, \sigma^2 \mid Y, X ) = \frac{\partial}{\partial \beta_1} \bigg[- \frac{1}{2\sigma^2} \sum_i^N \big(Y_i-(\beta_0 + \beta_1 X_i)\big)^2 \bigg]
$$

$$
\frac{1}{\sigma^2} \sum_i^N X_i \big(Y_i-(\beta_0 + \beta_1 X_i)\big) = 0
$$

$$
\sum_i^N X_i\big(Y_i-(\beta_0 + \beta_1 X_i)\big) = 0
$$



</v-clicks>

---
level: 3
---

# Linear Regression via MLE

Then you can solve this system of linear equations:

$$
\sum_i^N X_i\big(Y_i-(\beta_0 + \beta_1 X_i)\big) = 0
$$


$$
\sum_i^N \big(Y_i-(\beta_0 + \beta_1 X_i)\big) = 0
$$

<v-clicks>

As it turns out, these are exactly the same results you get from minimizing the sum of squared errors!

If you write these down in matrix formulation, it's also way less of a mess! You'll end up with:

$$
\hat{\beta} = (X^\top X) ^{-1} X^\top Y
$$

</v-clicks>
