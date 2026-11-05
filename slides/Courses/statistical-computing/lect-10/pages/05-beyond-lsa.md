---
level: 1
layout: section
---

# Beyond LSA

---
level: 3
---

# Topic Models

- What we just did, LSA, is the simplest _topic model_: a truncated SVD of the (weighted) DTM
  - Each "topic" is a dimension and words are more or less associated with each
- A better topic model is the Latent Dirichlet Allocation (LDA)
  - A Bayesian model (if you don't know what this means it doesn't super matter)
  - Structured as such:
    - A _document_ is made up of a mixture of _topics_
    - A _topic_ is made up of a mixture of _words_
    - Here, _mixture_ means probability distribution 
  - Because topics are probability distributions, there are no negative loadings, so no two-ended topics

---
level: 3
---

# Topic Models
  
- Dealing with topic models is conceptually similar to dealing with PCA
- The interpretation we just did with the LSA topics is the move!
- There are lots of types of topic models
  - Correlated topic models
  - Structural topic models
    - Allow for topic mixtures to vary as a function of other covariates
    - Use the excellent `stm` package for these
    

---
level: 3
---

# Dictionary methods

- Dictionaries are collections of words that have been coded to have some particular meaning
  - Conceptually: specific words are associated with ideas, themes, or emotions
  - If you use more of those words, you're expressing more of that thing
- The most common collection of dictionaries is Linguistic Inquiry and Word Count (LIWC)
  - Has dictionaries for affect, emotion, social behavior, references to health and culture, and a ton of other stuff
  - Also counts mechanical properties of text construction
  - These are a _great_ place to start with your own data!
  - LIWC costs $129.95 for an academic three year license, but free alternatives exist
- You can also develop your own dictionaries for specific purposes
  - This can be really time consuming to do well
  - Take a look at _The Development and Psychometric Properties of LIWC-22_ technical report for more information on how to do this
  
