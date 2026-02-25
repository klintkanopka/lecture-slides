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

<v-click>

- Let's write down the data structure
  - Follow an individual's response through the decision tree
  - Consider each node as its own item
  - If a respondent doesn't reach a node, mark it as `NA`

</v-clicks>
