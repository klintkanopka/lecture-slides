---
level: 1
layout: section
---

# Supreme Court Voting Records

---
level: 3
hideInToc: true
---

# Supreme Court voting records

- We don't typically think about voting records as item response data, but it is!

<v-clicks>

  - Individuals (Justices, $i$) 
  - respond to items (cases, $j$) 
  - by endorsing the majority opinion ($X_{ij}=1$) 
  - or dissenting ($X_{ij}=0$)

</v-clicks>

- There are some key assumptions we make here---what are they?

---
level: 3
---

# Preparing the data

- Only consider cases after 2000
- Recode majority opinion/concurrence as 1 and dissent as 0, dropping everything else
- Drop cases with no disagreement

```r
d <- SCDB_2022_01_justiceCentered_Citation |> 
  filter(year(dateDecision) >= 2000) |> 
  select(caseId, justiceName, vote) |> 
  mutate(vote = case_when(vote %in% c(1, 3) ~ 1,
                          vote == 2 ~ 0,
                          TRUE ~ NA_real_)) |> 
  na.omit() |>
  group_by(caseId) |> 
  mutate(var = var(vote, na.rm=T)) |> 
  filter(var != 0) |> 
  pivot_wider(id_cols = justiceName, names_from = caseId, values_from = vote)
```

---
level: 3
layout: image-right
image: /1pl-score.svg
---

# Estimating a 1PL

```r
resp <- select(d, -justiceName) 
m1 <- mirt(resp, 
           model = 1, 
           itemtype = 'Rasch')

d$onepl_score <- fscores(m1) 

ggplot(d, 
       aes(x = onepl_score, 
           y = reorder(justiceName, 
                       onepl_score))) +
  geom_point(color = okabeito_colors(3)) +
  labs(y=NULL) +
  theme_bw()
```

- What have we just measured?
- Why?

---
level: 3
layout: image-right
image: /2pl-score.svg
---


# Estimating a 2PL

```r
m2 <- mirt(resp, 
           model = 1, 
           itemtype = '2PL')

anova(m1, m2)
```

```
         AIC    SABIC        HQ       BIC    logLik       X2  df p
m1 11463.172 9246.408 11501.508 12211.810 -4762.586               
m2  6930.605 2501.652  7007.199  8426.337 -1529.302 6466.567 967 0
```
```r
d$twopl_score <- fscores(m2)

ggplot(d, 
       aes(x = twopl_score, 
           y = reorder(justiceName, 
                       twopl_score))) +
  geom_point(color = okabeito_colors(3)) +
  labs(y=NULL) +
  theme_bw()
```

- What did we measure now?


---
level: 3
---

# Examining Cases

```r
case_names <- SCDB_2022_01_justiceCentered_Citation |> 
  select(caseId, caseName) |> 
  distinct()

items <- data.frame(coef(m2, IRTpars=TRUE, simplify=TRUE)$items) |> 
  select(-g, -u) |> 
  rownames_to_column('caseId') |> 
  left_join(case_names, by='caseId')

items |>
  arrange(-b) |>
  head(5) |>
  pull(caseName) 
```
```
[1] "A. ELLIOTT ARCHER, ET UX. v. ARLENE L. WARNER"                               
[2] "VOLVO TRUCKS NORTH AMERICA, INC. v. REEDER-SIMCO GMC, INC."                  
[3] "NIKE, INC., et al. v. MARC KASKY"                                            
[4] "WESTERNGECO LLC v. ION GEOPHYSICAL CORP."                                    
[5] "CSX TRANSPORTATION, INC., PETITIONER v. ALABAMA DEPARTMENT OF REVENUE et al."
```

---
level: 3
---

# Examining Cases


```r
items |>
  arrange(b) |>
  head(5) |>
  pull(caseName)
```
```
[1] "PETRELLA v. METRO-GOLDWYN-MAYER, INC."                                                                                                            
[2] "CHARLES ANDREW FOWLER, AKA MAN, PETITIONER v. UNITED STATES"                                                                                      
[3] "EMPIRE HEALTHCHOICE ASSURANCE, INC., DBA EMPIRE BLUE CROSS BLUE SHIELD v. DENISE F. MCVEIGH, AS ADMINISTRATRIX OF THE ESTATE OF JOSEPH E. MCVEIGH"
[4] "SUPAP KIRTSAENG, DBA BLUECHRISTINE99, PETITIONER v. JOHN WILEY & SONS, INC."                                                                      
[5] "CUOZZO SPEED TECHNOLOGIES, LLC v. LEE"   
```

```r
items |>
  filter(abs(b) < 1) |>
  arrange(b) |>
  head(5) |>
  pull(caseName)
```
```
[1] "BEN CHAVEZ v. OLIVERIO MARTINEZ"                               
[2] "UTAH, et al. v. DONALD L. EVANS, SECRETARY OF COMMERCE, et al."
[3] "NATIONAL RAILROAD PASSENGER CORPORATION v. ABNER MORGAN, JR."  
[4] "UNITED STATES v. ARTHREX INC."                                 
[5] "TRANSUNION LLC v. RAMIREZ"  
```


---
level: 3
---

# Questions

With a $3 \pm 1$ people, answer the following:

1. How do the item parameters look to you? Are there any potential issues?
2. Because of these parameters, how must the IRFs look?
3. What were the major assumptions we made in doing this? How did we try to address them? If we didn't try to address them, how could we check them?