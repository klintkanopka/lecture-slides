---
level: 2
transition: fade
---

# Table of Contents

<Toc text-sm minDepth="1" maxDepth="2"/>


---
level: 2
---

# Announcements

- PS3 is now late
- PS4 is posted, due in two weeks
  - This is all numerical optimization
  - The PCA activity, while cool, got punted to PS5
  - Happened because the optimization activities are plenty long on their own



---
level: 2
---

# Check-In

- [PollEv.com/klintkanopka](https://PollEv.com/klintkanopka)


---
level: 1
layout: section
--- 

# Motivating Problem


---
level: 3
---

# Numerical Optimization

- We have a function, $f\big(\mathbf{X}, \theta \big)$, where $\mathbf{X}$ is data and $\theta$ are parameters
- Numerical optimization answers the question:

$$ \operatorname*{argmin}_{\theta} f\big(\mathbf{X}, \theta \big)$$

- From last week, remember argmin (or argmax) says: what value of $\theta$ minimizes (or maximizes) the output of $f\big(\mathbf{X}, \theta \big)$?
- Note that now $\mathbf{X}$ is a matrix argument (that also contains our outcome, $y$) and $\theta$ is (often) a vector argument
- If we are using argmin, $f\big(\mathbf{X}, \theta \big)$ is often referred to as a _loss function_
  - Our goal is to write problems such that when we minimize the loss function, we've found the answer!


---
level: 3
---

# Just thinking about $\operatorname*{argmin}$

- How could we use a computer to minimize this?


$$ \operatorname*{argmin}_{x} x^2 - 2x - 3 $$

<v-clicks>

- Take the derivative with respect to $x$, set $\frac{df}{dx} = 0$, and solve
- Make a list of possible $x$ values, plug them in, and check which one gives the lowest value
- Plot it and eyeball it
- Some secret fourth thing???

</v-clicks>

---
level: 3
---

# How do we optimize?

- Remember that analytic solutions can be hard/impossible and grid search can be inefficient/slow/imprecise
- Numerical optimization leverages an algorithm to find a solution faster, more efficiently, and more precisely than grid search
- There are LOTS of algorithms with different tradeoffs
- We will develop my favorite one today
  - It might actually be my all-time favorite algorithm?
