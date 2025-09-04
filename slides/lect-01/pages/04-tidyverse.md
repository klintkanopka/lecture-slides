---
level: 1
layout: section
---

# Data manipulation with the `tidyverse`


---
level: 2
---

# What is the `tidyverse`?

- A family of packages designed for "data science"
- Designed to work on dataframes (or `tibbles`)
- Loading the package `tidyverse` is an alias for loading _seven_ other packages:

```r {all|1|3|4|5|6|7|8|9|3,5,6}
library(tidyverse)   # the whole family bundled together

library(dplyr)       # data manipulation
library(tibble)      # an alternative to dataframes
library(ggplot2)     # visualization
library(tidyr)       # pivoting tools
library(stringr)     # string manipulation tools
library(lubridate)   # tools for working with dates as a datatype
library(purrr)       # functional programming tools; map() family
```

---
level: 2
---

# `dplyr` verbs

- Built around dataframes in a "tidy" format:
    - Each row is one observation
    - Each column is one variable
    - Each cell contains one single value (numeric or otherwise)
- We'll focus on six core `dplyr` verbs that end up doing most of the heavy lifting:

```r
select()     # selects columns in a dataframe
filter()     # selects rows in a dataframe that meet a condition
mutate()     # creates new columns in a dataframe
group_by()   # adds one or more layers of grouping
ungroup()    # removes all layers of grouping
summarize()  # combines multiple rows together, respects grouping
```

- Each of these has a consistent structure
    - The first argument each verb takes is always the dataframe you want to operate on
    - The output is always the dataframe after the operation has been performed

```r
output_data <- dplyr_verb(input_data, arg_1, arg_2, arg_3, ...)
```

---
level: 2
---

# `select()`

- Read the documentation:

```r
library(tidyverse)
?select
```

- Usage:

```r {all|1|3-4|6-7}
raw_data <- read_csv('./file_path/data.csv')

# specify the columns you'd like to keep:
data <- select(raw_data, var_1, var_2, var_3)

# alternatively, specify the columns you'd like to drop:
data <- select(raw_data, -var_4)
```
<div v-click>

- Remember:
    - No quotes around variable names
    - There are helper functions you can use to select columns based on conditions
    - The first input and the output are always dataframes

</div>

---
level: 2
---

# `filter()`

- Read the documentation:

```r
?filter
```

- Usage:

```r {all|1|3-4|6-7}
raw_data <- read_csv('./file_path/data.csv')

# use a logical expression to specify what rows to keep
data <- filter(raw_data, var_1 > 0)

# you can also specify multiple conditions that all must be met
data <- filter(raw_data, var_2 <= 7, var_3 != 0)
```
<div v-click>

- Remember:
    - Still no quotes around variable names
    - Multiple conditions can be in one `filter()` call or spread out across multiple calls
    - Rows where the condition is `TRUE` are kept, rows where the condition is `FALSE` are dropped
    - The first input and the output are always dataframes

</div>


---
level: 2
---

# `mutate()`

- Read the documentation:

```r
?mutate
```

- Usage:

```r {all|1|3-4|6-11}
raw_data <- read_csv('./file_path/data.csv')

# create a new variable name and specify what it should be
data <- mutate(raw_data, mean_vars = (var_1 + var_2 + var_3)/3)

# you can also create multiple new variables at once
data <- mutate(
    raw_data, 
    max_var = max(var_1, var_2, var_3), 
    min_var = min(var_1, var_2, var_3)
    )
```
<div v-click>

- Remember:
    - Adds a new column to the dataframe, computing a value for each row;  existing data left untouched
    - The first input and the output are always dataframes

</div>


---
level: 2
---

# `group_by()` and `ungroup()`

- Read the documentation:

```r
?group_by
```

- Usage:

```r {all|1|3-4|6-7|9-10}
raw_data <- read_csv('./file_path/data.csv')

# create groups of rows that have the same value for var_1
data <- group_by(raw_data, var_1)

# specifying multiple grouping variables
data <- filter(raw_data, var_2, var_3)

# remove grouping
data <- ungroup(data)
```
<div v-click>

- Remember:
    - Multiple grouping variables creates groups for each unique combination of values across those variables
    - `ungroup()` removes **all** grouping variables
    - The first input and the output are always dataframes

</div>

---
level: 2
---

# `summarize()`

- Read the documentation:

```r
?summarize
```

- Usage:

```r {all|1|3-4|6-7|9-10|12}
raw_data <- read_csv('./file_path/data.csv')

# most useful on grouped dataframes!
data <- group_by(raw_data, var_1)

# works like mutate, except it destroys all data except the grouping variables!
data <- summarize(data, mean_var_2 = mean(var_2), sd_var_2 = sd(var_2))

# don't forget to remove grouping if you don't want it anymore!
data <- ungroup(data)

# final data frame will have three columns: var_1, mean_var_2, sd_var_2 and one row per unique value of var_1
```
<div v-click>

- Remember:
    - `summarize()` combines rows together and is most often used on grouped dataframes
    - The first input and the output are always dataframes

</div>

---
level: 2
---

# Long data and wide data


---
level: 2
---

# `pivot_longer()`

---
level: 2
---

# `pivot_wider()`

