---
layout: section
level: 1
---

# Logicals

---
level: 2
---

# Logical Statements

- Sometimes we want to compare conditions and know if they're `TRUE` or `FALSE`
  - Called _Boolean_ after the work of George Boole
  - Only two possible values (dichotomous), and clear rules for evaluation

<v-click>The primary comparison operators we use are:</v-click>

<v-clicks>

  - `A == B` : returns `TRUE` if the value of `A` and `B` are equal, `FALSE` otherwise
  - `A != B` : returns `TRUE` if the value of `A` and `B` are **not** equal, `FALSE` otherwise
  - `A > B` : returns `TRUE` if the value of `A` is strictly greater than `B`, `FALSE` otherwise
  - `A >= B` : returns `TRUE` if the value of `A` is greater than or equal to `B`, `FALSE` otherwise
  - `A < B` : returns `TRUE` if the value of `A` is strictly less than `B`, `FALSE` otherwise
  - `A <= B` : returns `TRUE` if the value of `A` is less than or equal to `B`, `FALSE` otherwise

</v-clicks>


---
level: 2
---

# Logical Statements

- Often we store `TRUE` or `FALSE` status in a variable and need to check multiple conditions, or need rules on how to combine them
- Arithmetic with Boolean variables is easy - `TRUE = 1` and `FALSE = 0`
  - This can be leveraged to do some really clever stuff!

<v-click>Sometimes we have more complex conditions to check, and we get three primary logical operators:</v-click>

<v-clicks>

  - `&` is the logical AND - `A&B` is `TRUE` if both are `TRUE`, and `FALSE` otherwise
  - `|` is the logical OR - `A|B` is `TRUE` if either `A` or `B` are `TRUE`, and `FALSE` if both are `FALSE`
  - `!` is the logical NOT - `!A` is `TRUE` if `A` is `FALSE`, and `FALSE` if `A` is `TRUE`

</v-clicks>

<v-click>A confusing thing is that there are two other logical operators:</v-click>

<v-clicks>

  - `&&` is a logical AND that ONLY works on single values (not vectors)
  - `||` is a logical OR that ONLY works on single values (not vectors)
  - Both `&` and `|` are vectorized, and will do elementwise operations with normal recycling rules
  - Use `&&` and `||` for control flow! 

</v-clicks>
