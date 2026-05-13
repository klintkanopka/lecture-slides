---
level: 1
layout: section
---

# Getting Deep with GAM Smoothing

---
level: 2
---

# The Core Smoother: `s()`

<v-clicks depth="3">

- When you wrap a variable in `s()`, you are telling `gam()` to apply spline-based smoothing to it
  - There are a _lot_ of arguments that you can tune here
  - Check the documentation at `?s` for more info
- `k` is the _dimension of the basis used to represent the smooth term_
  - Think of this as an upper bound on the available degrees of freedom of the spline fit
  - What does this mean? More `k` $\rightarrow$ more wiggles
  - Running `gam.check()` on a model after you fit it will tell you if the `k` for any term is obviously too small
  - OOS prediction tells you if you made `k` too large (overfitting)

</v-clicks>

---
level: 3
---

# Regression Penalties in `mgcv`

<v-clicks depth="3">

- This package is built around using penalized regressions; specifically, $L_2$, or _ridge_ penalties
- These penalties help combat overfitting, but you can override it with the `fx` argument to your smoothers
- The default, `fx = FALSE` applied a penalty to the spline fit
- `fx = TRUE` tells `gam()` to _not_ apply a regularization penalty to the spline, which may lead to overfitting

</v-clicks>

---
level: 3
---

# Other Types of Splines

<v-clicks depth="3">

- There are bunch of different types of splines that can be used and supplied to the `bs` argument
- The default are _thin plate_ splines, which can be called with `bs = "tp"`
  - These do not have knots and do not use many degrees of freedom
- Cubic splines can be used with `bs = "cr"`
  - Increasing `k` increases the number of knots used
- B-splines (or _basis_ splines) can be used with `bs = "bs"`
  - Lots of options for degree of the basis and weirdo penalties
- Way more weird ones!
  - Splines on the sphere (`bs = "sos"`) are good if your data are latitude and longitude over a large portion of a globe
  - Markov Random Fields (`bs = "mrf"`) are good for geographic data, like census tracts or zip codes
  - Check the documentation for more!

</v-clicks>

---
level: 2
---

# Tensor Product Smoothers: `te()` and `ti()`

<v-clicks depth="2">

- Tensor product smoothers give you an opportunity to construct smoothers over multiple variables
- These work by taking the the spline fits on multiple variables and multiplying them together (kind of)
- These are ways to set up more flexible interactions!
- In general, you supply multiple comma separated variable names to `te()` to get a more flexible smooth:
  - `y ~ te(x, z)`
- If you'd prefer to separate out the different main effects and interaction effects (for, say, model comparisons), instead use _tensor interactions_:
  - `y ~ ti(x) + ti(z) + ti(x, z)`
- All of the same arguments we used with `s()` (and more) can be supplied to the tensor smoothers

</v-clicks>

