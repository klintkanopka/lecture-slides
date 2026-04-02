---
level: 1
layout: section
---

# Applied LCA

---
level: 2
---

# Citywide Mobility Survey

- [Citywide Mobility Survey - October 2020](https://data.cityofnewyork.us/Transportation/Citywide-Mobility-Survey-October-2020/3mpc-kqwk/about_data)
- NYC Open Data survey on demographics and transportation attitudes
- Data are available [here](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/lect-10/public/citywide-mobility-survey.csv)
- Codebook is available [here](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/lect-10/public/Open_Data_Dictionary_CMS_2020_10.xlsx)
- We will use it to look for latent classes based on transportation preferences

---
level: 2
layout: two-cols-header
---

# Fitting Candidate Models

:: left ::

- Start with a set of attitudinal items
- Fit several candidate class solutions rather than assuming the right number of classes in advance
- Compare fit statistics across solutions
- Then inspect the resulting classes, interpret them, and see if they make sense

:: right ::

```r
library(glca)

d <- read_csv('citywide-mobility-survey.csv')

f <- item(attitude_street_dining,
          attitude_drive,
          attitude_walk,
          attitude_bike,
          attitude_bus,
          attitude_stay_home) ~ 1

m2 <- glca(f, data = d, nclass = 2, verbose = FALSE)
m3 <- glca(f, data = d, nclass = 3, verbose = FALSE)
m4 <- glca(f, data = d, nclass = 4, verbose = FALSE)
m5 <- glca(f, data = d, nclass = 5, verbose = FALSE)

gofglca(m2, m3, m4, m5, test = 'boot')
```
---
level: 3
---

# Selecting a Model

- The function `gofglca()` is good for model comparison
- The goodness of fit table gives multiple options for comparison:
    - AIC and BIC (lower is better)
    - $p$-values for likelihood ratio tests if all the models use the same items
- The analysis of deviance table is similar to GLM output

```r
gofglca(m2, m3, m4, m5, test = 'boot')

Goodness of Fit Table :
    loglik      AIC      BIC entropy  df     Gsq Boot p-value
1 -7707.75 15513.49 15749.08    0.54 855 3573.77         0.04
2 -7620.12 15388.23 15744.02    0.65 830 3398.51         0.00
3 -7566.09 15330.18 15806.16    0.62 805 3290.45         0.08
4 -7519.73 15287.46 15883.65    0.69 780 3197.74         0.18

Analysis of Deviance Table :
  npar   loglik Df Deviance Boot p-value
1   49 -7707.75
2   74 -7620.12 25   175.26            0
3   99 -7566.09 25   108.06            0
4  124 -7519.73 25    92.71            0

```

---
level: 3
---

# Examining a Selected Model

- For the sake of a classroom exercise, we'll pick four classes
    - You should check more solutions
- We can use `summary()` to see the class probabilities
- Plot conditional response probabilities to understand what differentiates the classes using `plot()`

```r
summary(m4)
plot(m4)
```

---
level: 3
layout: two-cols-header
---

# `summary(m4)`

:: left ::

```r
Marginal prevalences for latent classes :
Class 1 Class 2 Class 3 Class 4
0.26407 0.20671 0.13534 0.39388

Item-response probabilities :
attitude_street_dining
         Y = 1  Y = 2  Y = 3  Y = 4  Y = 5
Class 1 0.1986 0.3737 0.2737 0.0966 0.0574
Class 2 0.5545 0.2321 0.0852 0.0206 0.1077
Class 3 0.3191 0.1586 0.2722 0.0612 0.1888
Class 4 0.5968 0.2549 0.0850 0.0634 0.0000
attitude_drive
         Y = 1  Y = 2  Y = 3  Y = 4  Y = 5
Class 1 0.3825 0.2597 0.3546 0.0000 0.0033
Class 2 0.9252 0.0000 0.0748 0.0000 0.0000
Class 3 0.4961 0.1534 0.0965 0.0426 0.2114
Class 4 0.2069 0.3511 0.1920 0.1565 0.0935
attitude_walk
         Y = 1  Y = 2  Y = 3  Y = 4  Y = 5
Class 1 0.0983 0.2857 0.5365 0.0701 0.0094
Class 2 0.6378 0.2056 0.0864 0.0519 0.0183
Class 3 0.2659 0.2091 0.1598 0.0685 0.2968
Class 4 0.3805 0.4759 0.0787 0.0649 0.0000
```

:: right ::

```r
attitude_bike
         Y = 1  Y = 2  Y = 3  Y = 4  Y = 5
Class 1 0.0047 0.0257 0.5204 0.1916 0.2576
Class 2 0.2295 0.1763 0.2643 0.1249 0.2049
Class 3 0.0183 0.0000 0.0000 0.0845 0.8972
Class 4 0.1787 0.1707 0.1716 0.2258 0.2531
attitude_bus
         Y = 1  Y = 2  Y = 3  Y = 4  Y = 5
Class 1 0.1118 0.1527 0.5396 0.1432 0.0527
Class 2 0.2699 0.2038 0.1443 0.1847 0.1972
Class 3 0.2267 0.0723 0.2450 0.0253 0.4308
Class 4 0.1011 0.1754 0.2497 0.2697 0.2041
attitude_stay_home
         Y = 1  Y = 2  Y = 3  Y = 4  Y = 5
Class 1 0.1860 0.3186 0.3107 0.1229 0.0618
Class 2 0.7490 0.1923 0.0204 0.0230 0.0153
Class 3 0.4022 0.1169 0.0528 0.1572 0.2709
Class 4 0.2894 0.4112 0.1583 0.1012 0.0398
```
---
level: 3
layout: image
image: /class-prevalence.svg
---


---
level: 3
layout: image
image: /attitude-street-dining.svg
---

---
level: 3
layout: image
image: /attitude-drive.svg
---

---
level: 3
layout: image
image: /attitude-walk.svg
---

---
level: 3
layout: image
image: /attitude-bike.svg
---

---
level: 3
layout: image
image: /attitude-bus.svg
---

---
level: 3
layout: image
image: /attitude-stay-home.svg
---


---
level: 2
---

# Practical Notes

- Good class solutions still require interpretation
- A model with better fit but incoherent classes may not be the best substantive choice
- This is the logic and practice of clustering for categorical response data, but with uncertainty and model comparison built in (like GMMs)
