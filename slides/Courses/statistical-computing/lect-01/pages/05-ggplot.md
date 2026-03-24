---
level: 1
layout: section
---

# Data visualization with `ggplot2`

---
level: 2
---

# The grammar of graphics

- Grammar is the syntax we used to combine words into sentences to express ideas
- Plots convey ideas with their own “grammatical structure”
    - Layers
        - Data
        - Mappings
        - Statistical transformations
        - Geometric objects
        - Position Adjustments
    - Scales
        - Numerical scales, color scales, etc
    - Coordinate Systems
        - Cartesian, Polar, etc
    - Facets
        - Panels

---
level: 2
---

# Layers

- Have five parts:
    1. Data (nouns, the subject of our plot)
        - The data we want to describe
    2. Mappings (verbs, the actions that assign our data to scales)
        - How we assign data to different scales
        - $x$-axis, $y$-axis, color, fill, size, transparency, etc.
    3. Statistical transformations (adjectives, modify data)
        - Log transforms, power transforms, adding variables together, etc
    4. Geometric objects (objects - mappings project data to scales)
        - Scatter plots, bars, lines, etc
    5. Position Adjustments (adjectives, modify objects)
        - Nudges, jitters, etc
- Added to plots using `geom_xxx()` functions
- Inherit data and mappings from the original `ggplot()` call

---
level: 2
---

# Scales

- Scales determine how data are transformed into visual elements
    - They can be used to translate values to colors
    - They can be used to translate values to numeric scales for positions
- Added using `scale_A_B()` calls
    - `A` is the aspect you’re scaling ($x$, $y$, color, fill)
    - `B` is how you’re scaling it (manually, `log10`, or something else)

---
level: 2
---

# Coordinate Systems

- Often not specified!
- The default is cartesian (an $x,y$ plane)
- Could also be polar, 3d, or other specialized stuff
- Fancy coordinate systems are often harder to understand for readers

---
level: 2
---

# Facets

- Facets allow you to create different panels so you can compare similar plots of subsets of data side-by-side
- Added using `facet_grid()` or similar
- Facets share all the same layers, scales, and coordinate systems

---
level: 2
---

# What does `ggplot()` want from us?

- “Long form data”
    - Every variable you want to map to a scale has to have its own column
    - Makes every item drawn in the plot in its own row
- We often have “wide data”
    - Multiple observations are in the same row
    - Example: tracking steps for an office walking contest
        - Each row is a person
        - First column is their name
        - Each subsequent column is the number of steps they took on a given day
    - If you wanted to make line plots with a different line for each person, `ggplot()` can’t handle this format!
        - It wants three columns: `name, day, steps`
        - You need to use `pivot_longer()`!
        - If you collect data for ten days, each person has ten rows

---
level: 2
---

# Building a plot using `ggplot()` 

- Recall the office walking contest: 
    - We have a dataframe called `data` 
    - In long form with one row per person-day
    - Three columns: `name, day, steps`

````md magic-move {lines: true}


```r
ggplot()
```

```r
ggplot(data, aes())
```

```r
ggplot(data, aes(x =, y =, color =))
```

```r
ggplot(data, aes(x = day, y =, color =))
```

```r
ggplot(data, aes(x = day, y = steps, color =))
```

```r
ggplot(data, aes(x = day, y = steps, color = name))
```

```r
ggplot(data, aes(x = day, y = steps, color = name)) +
  geom_line()
```

```r
ggplot(data, aes(x = day, y = steps, color = name)) +
  geom_line() +
  scale_color_manual()
```

```r
ggplot(data, aes(x = day, y = steps, color = name)) +
  geom_line() +
  scale_color_manual(values =)
```

```r
ggplot(data, aes(x = day, y = steps, color = name)) +
  geom_line() +
  scale_color_manual(values = c('klint' = 'green', 
                                'ravi' = 'blue', 
                                'daphna' = 'red', 
                                'alex' = 'purple')
```

```r
ggplot(data, aes(x = day, y = steps, color = name)) +
  geom_line() +
  scale_color_manual(values = c('klint' = 'green', 
                                'ravi' = 'blue', 
                                'daphna' = 'red', 
                                'alex' = 'purple') +
  theme_minimal()
```

````
