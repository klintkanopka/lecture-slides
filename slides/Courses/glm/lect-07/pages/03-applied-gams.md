---
level: 1
layout: section
---

# Applied GAMs

---
level: 2
---

# Loading Some Data

- We are going to use data from the book "Generalized Additive Models: An Introduction with `R`"
- The cool thing is they have a package with a bunch of datasets that are helpful!
- First install and load the package:

```r
install.packages('gamair')
library(gamair)
```

- Let's load the first dataset and look at the codebook:

```r
data(blowfly)
?blowfly
```

- From these data:
  - What are you looking at?
  - Plot population against time
  - Fit a GAM with a smooth term on `day` using default options
  - Plot a line that shows the GAM predictions (look at last week's slides!)

---
level: 2
---

# Experimenting with Smoother Options

- Using the `blowfly` data, fit separate models for $k \in \{3, 5, 10, 20\} and plot the GAM predictions
  - What happens as $k$ increases?
  - Refit the models with `fx = TRUE`. How do the predictions change?
  - Try different types of splines and use the documentation (type `?s`) to change some of the arguments. What happens?

<v-click>

- Now we'll load the Cairo temperature data

```r
data(cairo)
?cairo
```

- How does this data look similar to (and different from) the `blowfly` data?
- Find a smoother on `time` that describes the data well.
- Plot the fit over the data. What arguments did you need to provide to `s()`?

</v-click>


---
level: 3
---

# Using a Tensor Smoother

```r
data(co2s)
?co2s
```

- Fit the following GAMs (adjusting arguments to `s()` as needed):
  - `y ~ s(c.month)`
  - `y ~ s(month)`
  - `y ~ s(c.month) + s(month)`
  - How well does each model match the data?

<v-click>

- Now use a tensor smoother to fit (adjusting arguments to `te()` as needed):
  - `y ~ te(c.month, month)`
  - What do you find happens?
  - How does model output change?

</v-click>