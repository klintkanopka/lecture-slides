---
level: 1
layout: section
---

# Modeling Response Processes

---
level: 2
hideInToc: true
---

# Response Processes

- The "response process" is the cognitive and physical process that individuals go through when they respond to an item
  - Physical processes include pushing buttons, filling in bubbles, sorting cards, etc.
  - Cognitive processes include understanding a question, understanding the response options, and going through a mental decision tree, etc.
- Think _metacognitively_ about your own response process as you answer these questions:

<v-clicks>

1. I am a hard worker. 
  - (_Strongly Disagree, Disagree, Agree, Strongly Agree_)
2.  $8 \div 2(1+3)=$ 
  - ($A: 1,\ B: 4,\ C: 8,\ D: 16$)
3.  What is your gender?
  - (_Male, Female_)

</v-clicks>

---
level: 2
---

# IRTrees

- IRTrees is the idea that we write out a decision tree associated with the expected response process and use IRT to model each decision point
- Really flexible approach!
  - Leverages IRT's resilience to missing data
  - Can incorporate multiple latent traits!
  - Each node can use any type of IRT model


---
level: 3
---

# IRTrees

- Let's build decision trees for each of these:
  - I am a hard worker. (_Strongly Disagree, Disagree, Agree, Strongly Agree_)
  - What is your gender? (_Male, Female_)

<v-clicks>

- Let's write down the data structure
  - Follow an individual's response through the decision tree
  - Consider each node as its own item
  - If a respondent doesn't reach a node, mark it as `NA`

</v-clicks>

<v-click>

- You can fit these models in `mirt` with clever data recoding or using the `irtrees` package
- You'll try both in PS3

</v-click>

---
level: 3
---

# Fitting an IRTree model in `mirt`

- Let's fit an IRTree model to an [empathizing–systemizing](https://openpsychometrics.org/tests/EQSQ.php) instrument
- Each respondent sees 120 statements that they rate on the following scale:
  - (1) strongly disagree
  - (2) slightly disagree
  - (3) slightly agree
  - (4) strongly agree
- Download the data [here](https://github.com/klintkanopka/lecture-slides/blob/main/slides/Courses/measurement/measurement-lect-06/public/empathizing_systemizing.csv) (redistributed from the Item Response Warehouse)

```r
d <- read_csv('empathizing_systemizing.csv')

resp <- d |>
  pivot_wider(
    id_cols = id,
    names_prefix = 'item_',
    names_from = item,
    values_from = resp
  ) |>
  select(-id)
```

---
level: 3
---

# Fitting an IRTree model in `mirt`

- We'll use the same decision tree we developed earlier that includes non-response
- We will model nonresponse, agreement, and extreme responses as separate latent traits
- We make responses for the nonresponse nodes first:

````md magic-move
```r

```
```r
tree_resp_node_1 <- resp
```
```r
tree_resp_node_1 <- resp
tree_resp_node_1[is.na(resp)] <- 0
```
```r
tree_resp_node_1 <- resp
tree_resp_node_1[is.na(resp)] <- 0
tree_resp_node_1[!is.na(resp)] <- 1
```
```r
tree_resp_node_1 <- resp
tree_resp_node_1[is.na(resp)] <- 0
tree_resp_node_1[!is.na(resp)] <- 1
colnames(tree_resp_node_1) <- paste0('F1_', colnames(tree_resp_node_1))
```
````



---
level: 3
---

# Fitting an IRTree model in `mirt`

- Next we construct responses for the agreement nodes:

````md magic-move
```r

```
```r
tree_resp_node_2 <- resp
```
```r
tree_resp_node_2 <- resp
tree_resp_node_2[resp <= 2] <- 0
```
```r
tree_resp_node_2 <- resp
tree_resp_node_2[resp <= 2] <- 0
tree_resp_node_2[resp >= 3] <- 1
```
```r
tree_resp_node_2 <- resp
tree_resp_node_2[resp <= 2] <- 0
tree_resp_node_2[resp >= 3] <- 1
colnames(tree_resp_node_2) <- paste0('F2_', colnames(tree_resp_node_2))
```
````


---
level: 3
---

# Fitting an IRTree model in `mirt`

- Next we construct responses for the agreement nodes:

````md magic-move
```r

```
```r
tree_resp_node_3 <- resp
```
```r
tree_resp_node_3 <- resp
tree_resp_node_3[resp %in% c(2, 3)] <- 0

```
```r
tree_resp_node_3 <- resp
tree_resp_node_3[resp %in% c(2, 3)] <- 0
tree_resp_node_3[resp %in% c(1, 4)] <- 1

```
```r
tree_resp_node_3 <- resp
tree_resp_node_3[resp %in% c(2, 3)] <- 0
tree_resp_node_3[resp %in% c(1, 4)] <- 1
colnames(tree_resp_node_3) <- paste0('F3_', colnames(tree_resp_node_3))

```

````

level: 3
---

# Fitting an IRTree model in `mirt`

- Next we combine the responses, free up some memory, and build out the `mirt.model` object


````md magic-move
```r

```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- ''
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = '
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = 
      AGREE = '
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = 
      AGREE = 
      STRONG = '
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = 
      STRONG = '
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = '
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model()
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = , itemnames = )
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = s, itemnames = )
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = s, itemnames = names(tree_resp))
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = s, itemnames = names(tree_resp))

m <- mirt()
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = s, itemnames = names(tree_resp))

m <- mirt(data = , model = , itemtype = )
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = s, itemnames = names(tree_resp))

m <- mirt(data = tree_resp, model = , itemtype = )
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = s, itemnames = names(tree_resp))

m <- mirt(data = tree_resp, model = tree_model, itemtype = )
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = s, itemnames = names(tree_resp))

m <- mirt(data = tree_resp, model = tree_model, itemtype = 'Rasch')
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = s, itemnames = names(tree_resp))

m <- mirt(data = tree_resp, model = tree_model, itemtype = 'Rasch')

thetas <- fscores(m)
```
```r
tree_resp <- bind_cols(tree_resp_node_1, tree_resp_node_2, tree_resp_node_3)

rm('tree_resp_node_1', 'tree_resp_node_2', 'tree_resp_node_3')

s <- 'RESPOND = F1_item_1-F1_item_120
      AGREE = F2_item_1-F2_item_120
      STRONG = F3_item_1-F3_item_120'

tree_model <- mirt.model(input = s, itemnames = names(tree_resp))

m <- mirt(data = tree_resp, model = tree_model, itemtype = 'Rasch')

thetas <- fscores(m)

tree_pars <- coef(m, IRTpars = TRUE, simplify = TRUE)
```

````
