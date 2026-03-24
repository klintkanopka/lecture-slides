---
level: 1
layout: section
---

# More `mirt.model`s

---
level: 2
hideInToc: true
---

# IRTrees and `mirt.model()`

- `mirt` allows for _very_ complex and detailed model specifications in a variety of ways
- The primary way is through the `mirt.model()` syntax
- Previously, we've used `model=1` or just `1` in the second argumetnt of `mirt()` to generally specify a one-factor model
  - The thing you provide to the `model` can actually be incredibly complex!
  - Check the help file at `?mirt.model`
- For Part 2 of the assignment, you need to specify a _very specific_ factor structure with your IRTrees model
  - This is a three factor model
  - Each item is associated with only one factor
  - We need to assign the correct factor to each item

---
level: 3
---

# `mirt.model()` syntax

- Generally you write out the model as a string and then pass the string to the `mirt.model()` function
- Then the object returned by `mirt.model()` gets passed as the second argument to `mirt()`
- For setting factor structures, you can use item numbers or item names
  - You can reference items directly or item ranges
  
  
---
level: 3
---

# `mirt.model()` syntax (example 1)
  
For ten items and two factors, we can use item number to specify factor structure and fit a model like this:

```r
s <- 'F1 = 1-5
      F2 = 6-10'
      
F2_model <- mirt.model(s)

m <- mirt(resp, F2_model, itemtype = '2PL')
```

---
level: 3
---

# `mirt.model()` syntax (example 2)

We are totally allowed to name the factors as we like and reference items directly:

```r
s <- 'ARITHMETIC = 1,3,5
      GEOMETRY = 2,4,6
      PROBABILITY = 7-10'
      
F3_model <- mirt.model(s)

m <- mirt(resp, F3_model, itemtype = '2PL')
```


---
level: 3
---

# `mirt.model()` syntax (example 3)

We can also use item names. Here we assume the item names are the column names in the `resp` dataframe. Additionally, items can belong to multiple factors:

```r
s <- 'A = item_1,item_3,item_5
      B = item_2,item_4,item_6
      C = item_3-item_5'
      
F3_model <- mirt.model(s, itemnames = names(resp))

m <- mirt(resp, F3_model, itemtype = '2PL')
```

- When using item names, ranges specify a starting and ending column and take **all** columns in between
- If your columns are out of order, this will backfire!


---
level: 3
---

# The `pars` argument in `mirt()`

- The `mirt()` function has an argument called `pars` that allows a dataframe to specify names, starting values, and whether or not individual parameters are estimated
  - If you set `pars='values'` and run a `mirt()` call, it won't actually fit a model, it will just output this data frame
  - You can then _modify_ this data frame however you like
  - Pass it back to the `pars=` argument and `mirt()` will use it

---
level: 3
---

# Why is the `pars` dataframe useful?

- Factor structure is entirely specified by the discrimination parameters!
- A three factor model looks like: $\sigma \big (a_1\theta_1 + a_2 \theta_2 + a_3 \theta_3 + b \big )$
- To enforce a Rasch structure with only the second factor, we can set $a_2 =1$ and $a_1 = a_3 = 0$
- The `pars` data frame has a column called `est` that takes a logical value
  - For a parameter, if `est == TRUE`, `mirt()` will use MLE to estimate the parameter
  - If `est == FALSE`, `mirt()` will fix it to its starting value
- We set the `value` all of the `a1, a2, a3` parameters to either `1` or `0` _and_ `est==FALSE` to manually specify the factor structure



---
level: 3
---

# Using the `pars` argument in `mirt()`

- First extract your `pars` matrix: 
  - `parmat <- mirt(resp, 3, pars='values')`
- Focus on the columns: `item, name, value, est`
  - `item` is the item name
  - `name` is the name of the parameter - `a1,a2,a3` are the discriminations 
  - `value` is the starting value of the parameter you want to set to `0` or `1` for the discriminations
  - `est` is set to `TRUE` for the discriminations, but we need to set it to `FALSE`
- Pass the modified `parmat` back to the `mirt()` call:
  - `m <- mirt(resp, 3, pars=modified_parmat)`
- Note that here you can't specify `itemtype='Rasch'` when `model=3`, so we fix discriminations to `1` to get the same effect
  - Models where discriminations are freely estimated are called _exploratory_
  - Models with pre-specified factor structure are called _confirmatory_



---
level: 3
---

# PS3 considerations

- You have a lot of items!
- For the IRTrees part, you might have $\approx 400$ items
- If using the `mirt.model()` approach, rearranging the columns in your `resp` matrix and then using ranges of names can be really helpful!
- If using the `pars` approach, `dplyr` functions like `mutate()` involving `if_else()` and `case_when()` can be really helpful to enforce conditions and manipulate specific items
  - Don't forget to set the `est` column to `FALSE` for the discrimination parameters `a1, a2, a3`
- If you use the `mirt.model()` approach, you can set `itemtype='Rasch'`
- If you use the `pars` approach, you need to manually fix the discriminations to `1` for the factors you use
