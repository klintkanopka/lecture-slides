---
level: 1
layout: section
---

# The `apply()` Family

---
level: 2
---

# Side Effects

- If a function or operation modifies things outside its local environment, it has “side effects”
- These side effects can be hard to observe, but cause serious errors in analysis!
- Side effects most often occur when we are trying to hack together a solution to a problem
  - Functions that take and modify information from the global environment
  - Janky loops

---
level: 3
---

# Avoiding Side Effects

- Writing things in functions is a good start! 
  - Calls to functions generate new environments 
  - New environments protect data in the global environment
- We can “hide loops”
  - The `apply()` family of functions does this really well
  - These nest the entire loop we want to carry out inside of a function call

---
level: 2
---

# The `apply()` Family

- `apply()` takes a function and applies it to each element of a data object
- Whole bunch of different `apply()` functions
  - Different functions take different data objects as input
  - Different functions spit out different data objects
- Note that `apply()` functions aren't really any faster than loops! 
  - They are not vectorized
  - They are, however, very easy to _parallelize_
  
---
level: 3
---

# The main `apply()` functions

|**function** | **input**            | **output**               | **comment**    |
|-------------|----------------------|--------------------------|----------------|
| `apply()`   | matrix or array      | vector or array or list  |                |
| `lapply()`  | list or vector       | list                     |                |
| `sapply()`  | list or vector       | vector or matrix or list | simplify       |
| `vapply()`  | list or vector       | vector or matrix or list | safer simplify |
| `tapply()`  | data, categories     | array or list            | ragged         |
| `mapply()`  | lists and/or vectors | vector or matrix or list | multiple       |



