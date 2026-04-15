---
level: 1
layout: section
---

# Cognitive Diagnostic Models

---
level: 2
hideInToc: true
---

# Cognitive Diagnostic Models

<v-clicks depth="2">

- Cognitive diagnostic models (CDMs) and diagnostic classification models (DCMs) are the same thing
- They are also just latent class analysis with stronger theory built in
- CDMs diagnose whether respondents have mastered categorical latent skills called attributes
- You propose some number, $A$, of attributes
- Respondents are grouped into $2^A$ latent classes representing all possible skill profiles
  - Three attributes means $2^3 = 8$ classes
  - Eight attributes means $2^8 = 256$ classes

</v-clicks>

---
level: 2
---

# CDM Goals

<v-clicks depth="2">

- Instead of estimating one latent ability, we estimate a latent skill profile
- The goal is diagnostic information that can inform instruction
- Each item measures one or more latent attributes
- The item response function depends on which attributes the respondent has mastered

</v-clicks>

---
level: 2
---

# CDM Structure

<v-clicks depth="2">

- We start with the DINA model:
  - Deterministic Input Noisy AND gate
  - The AND means you need all required attributes
  - Think of this as a non-compensatory multidimensional model with categorical latent traits
- Each item $j$ has two parameters:
  - Guess $(g_j)$: probability of a correct response when _at least one_ required attribute is missing
  - Slip $(s_j)$: probability of an incorrect response when _all_ required attributes are mastered
- Required attributes are defined by a $Q$-matrix
  - One row per item, one column per attribute
  - `1` means the item requires that attribute
  - `0` means it does not

</v-clicks>

---
level: 2
---

# The DINA Specification

$$
P(X_{ij}=1\mid\alpha_i) = g_j^{1-\eta_{ij}}(1-s_j)^{\eta_{ij}}
$$

<v-clicks depth="2">

- $\alpha_i$ is person $i$'s latent attribute vector
- $\eta_{ij} = 1$ if person $i$ has mastered all attributes required by item $j$
- $g_j = P(X_{ij}=1 \mid \eta_{ij}=0)$
- $s_j = P(X_{ij}=0 \mid \eta_{ij}=1)$

</v-clicks>

---
level: 2
---

# The G-DINA Framework

$$
P(X_{ij}=1\mid\alpha_i) =
\delta_{j0} + \sum_{k=1}^{K^\star_j}\delta_{jk}\alpha_{ik} +
\sum_{k^\prime = k+1}^{K^\star_j}\sum_{k=1}^{K^\star_j-1}
\delta_{jkk^\prime}\alpha_{ik}\alpha_{ik^\prime} + \cdots +
\delta_{j12\ldots K^\star_j}\prod_{k=1}^{K^\star_j}\alpha_{ik}
$$

<v-clicks depth="2">

- $\delta_{j0}$ is a baseline intercept
- Main effects and interaction effects come from the required attributes
- $K^\star_j$ is the set of attributes required by item $j$
- The DINA model is a restricted special case of G-DINA
  - $g_j = \delta_{j0}$
  - Guessing rate is the intercept
  - $1 - s_j = \delta_{j0} + \delta_{j12 \ldots K_j^\star}$
  - The probability of correct response if you have all the attributes is the guess rate (intercept) plus the interaction term for the full attribute vector

</v-clicks>

---
level: 2
---

# Why G-DINA Matters

<v-clicks depth="2">

- G-DINA adds many more parameters, but it also nests a large family of diagnostic models
- Examples:
  - DINA
  - DINO (Deterministic Input Noisy OR gate: a fully compensatory version of a CDM where you only need one attribute instead of all)
  - Additive CDM (each attribute and interaction contributes differently to the probability of correct response, bridges the gap between DINA and DINO)
- This makes the framework flexible, but fitting and interpretation can get complicated quickly
- In `R`, the `GDINA` package handles a huge amount of this workflow

</v-clicks>

---
level: 2
---

# Using `GDINA` in `R`

````md magic-move
```r
library(GDINA)

d <- sim10GDINA$simdat
Q <- sim10GDINA$simQ
```
```r
library(GDINA)

d <- sim10GDINA$simdat
Q <- sim10GDINA$simQ

d

        [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
   [1,]    1    0    1    1    0    1    1    1    0     1
   [2,]    1    1    1    1    1    1    1    1    0     1
   [3,]    1    1    1    0    1    1    1    0    1     0
   [4,]    1    0    1    1    1    1    1    1    1     0
   [5,]    0    0    1    1    0    0    1    0    0     0
   [6,]    1    0    0    0    0    0    0    1    0     1
   [7,]    1    1    0    0    1    1    0    1    1     1
   [8,]    1    1    0    0    0    0    0    0    0     1
   [9,]    0    0    1    0    0    1    0    1    0     1
  [10,]    0    0    1    1    1    1    1    0    1     1
  [ reached 'max' / getOption("max.print") -- omitted 990 rows ]

```
```r
library(GDINA)

d <- sim10GDINA$simdat
Q <- sim10GDINA$simQ

d
Q

      [,1] [,2] [,3]
 [1,]    1    0    0
 [2,]    0    1    0
 [3,]    0    0    1
 [4,]    1    0    1
 [5,]    0    1    1
 [6,]    1    1    0
 [7,]    1    0    1
 [8,]    1    1    0
 [9,]    0    1    1
[10,]    1    1    1

```
```r
library(GDINA)

d <- sim10GDINA$simdat
Q <- sim10GDINA$simQ

m_1 <- GDINA(dat = d, Q = Q, model = "DINA")


```
```r
library(GDINA)

d <- sim10GDINA$simdat
Q <- sim10GDINA$simQ

m_1 <- GDINA(dat = d, Q = Q, model = "DINA")
Iter = 123  Max. abs. change = 0.00010  Deviance  = 12178.01


```
```r
m_1 <- GDINA(dat = d, Q = Q, model = "DINA")
Iter = 123  Max. abs. change = 0.00010  Deviance  = 12178.01

```
```r
m_1


```
```r
m_1
Call:
GDINA(dat = d, Q = Q, model = "DINA")
GDINA version 2.9.12 (2025-07-01)
===============================================
Data
-----------------------------------------------
# of individuals    groups    items
            1000         1       10
===============================================
Model
-----------------------------------------------
Fitted model(s)       = DINA
Attribute structure   = saturated
Attribute level       = Dichotomous
===============================================
Estimation
-----------------------------------------------
Number of iterations  = 123
For the final iteration:
  Max abs change in item success prob. = 0.0001
  Max abs change in mixing proportions = 0.0000
  Change in -2 log-likelihood          = 0.0002
  Converged?                           = TRUE
Time used             = 0.1314 secs
```
```r
summary(m_1)
```
```r
summary(m_1)
Test Fit Statistics

Loglik = -6089.01

AIC    = 12232.01  | penalty [2 * p]  = 54.00
AICc   = 12179.57  | penalty [2 * p * (p+1) / (n - p - 1)]  = 213.51
BIC    = 12364.52  | penalty [log(n) * p]  = 186.51
CAIC   = 12391.52  | penalty [(log(n) + 1) * p]  = 213.51
SABIC  = 12278.77  | penalty [log((n + 2)/24) * p]  = 100.76

No. of parameters (p)  = 27
  No. of estimated item parameters =  20
  No. of fixed item parameters =  0
  No. of distribution parameters =  7

Attribute Prevalence

   Level0 Level1
A1 0.2741 0.7259
A2 0.4193 0.5807
A3 0.4576 0.5424

```
```r
Qval(m_1)
```
```r
Qval(m_1)

Q-matrix validation based on PVAF method

No Q-matrix modifications are suggested.
```
```r
coef(m_1)
```
```r
coef(m_1)
$`Item 1`
  P(0)   P(1)
0.0325 0.7455

$`Item 2`
  P(0)   P(1)
0.0919 0.7274

$`Item 3`
  P(0)   P(1)
0.0716 0.8927

$`Item 4`
 P(00)  P(10)  P(01)  P(11)
0.2197 0.2197 0.2197 0.7970

$`Item 5`
 P(00)  P(10)  P(01)  P(11)
0.0820 0.0820 0.0820 0.7156
```
```r
coef(m_1, what = 'gs')
```
```r
coef(m_1, what = 'gs')
        guessing   slip
Item 1    0.0325 0.2545
Item 2    0.0919 0.2726
Item 3    0.0716 0.1073
Item 4    0.2197 0.2030
Item 5    0.0820 0.2844
Item 6    0.5852 0.0724
Item 7    0.2559 0.3219
Item 8    0.1472 0.3080
Item 9    0.2681 0.2016
Item 10   0.3331 0.1546
```
```r
personparm(m_1)
```
```r
personparm(m_1)

        A1 A2 A3
   [1,]  1  0  1
   [2,]  1  1  1
   [3,]  1  1  1
   [4,]  1  1  1
   [5,]  1  0  1
   [6,]  1  0  0
   [7,]  1  1  0
   [8,]  1  1  0
   [9,]  0  0  1
  [10,]  1  1  1
  [ reached 'max' / getOption("max.print") -- omitted 990 rows ]
```
````


---
level: 3
layout: image-right
image: /gdina-item.svg
---

# Plotting with GDINA

- First we can probability of correct response by attribute profile:

```r
plot(m_1, what = 'IRF', item = 10)
```

---
level: 3
layout: image-right
image: /gdina-mp.svg
---

# Plotting with GDINA

- Next we can plot attribute mastery probabilities for individual people:

```r
plot(m_1, what = 'mp', person = 5:8) +
  scale_fill_okabeito() +
  theme_bw()
```

---
level: 3
---

# Looking at Some CDM Data

1. Download the [frac20.csv](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/lect-11/public/frac20.csv) data. It is 20 math items about fractions and a Q-matrix with eight skills
2. Separate that data into a wide form item response matrix and the Q-Matrix and fit a DINA model
3. Look at the model output, validate the Q-matrix, and examine individual items and persons
4. What useful insights can you derive from the results? Consider different potential users!

```r
frac20 <- read_csv('frac20.csv')

d <- frac20 |>
  select(id, item, resp) |>
  pivot_wider(id_cols=id, names_from=item, values_from='resp') |>
  arrange(id) |>
  select(-id)

Q <- frac20 |>
  select(item, starts_with("Qmatrix")) |>
  distinct() |>
  mutate(item = as.numeric(str_remove(item, 'item_'))) |>
  arrange(item) |>
  select(-item)

m_2 <- GDINA(dat = d, Q = Q, model = "DINA")
```