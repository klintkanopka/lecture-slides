---
level: 1
layout: section
---

# Classical Text Analysis

---
level: 2
hideInToc: true
---
  
# Classical text analysis

- Does the DTM remind you of any objects we've worked with in this course already?
- Any thoughts on what we could do with a DTM to learn about the collection of documents?

<v-click>

- We can look at the most common tokens in the corpus

</v-click>
<v-click>

- We can look at how common tokens are within a document (often _term frequency_)

$$ \text{tf}(t, d) = \frac{f_{t,d}}{\sum_{t'\in d} f_{t',d}} $$

</v-click>
<v-click>

- We can look at how common tokens are across documents (often _inverse document frequency_)
$$ \text{idf}(t, D) = \ln \frac{N}{d\in D: t\in d} $$ 

</v-click>
<v-click>

- A common way to weight tokens is: $\text{tf-idf}(t,d,D) =\big(\text{tf}(t,d)\cdot\text{idf}(t,D)\big)$
  - When is tf-idf high?
  - When is tf-idf low?

</v-click>

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
  
---
level: 3
---

# Topic Models

- Core idea: Topic models are basically factor analysis performed on the DTM
- A singular value decomposition (SVD) on the DTM is called Latent Semantic Analysis (LSA)
  - This is functionally the same as doing a PCA on the DTM
  - Interpretation and use is identical---each "topic" is a dimension and words are more or less associated with each
- A better topic model is the Latent Dirichlet Allocation (LDA)
  - A Bayesian model (if you don't know what this means it doesn't super matter)
  - Structured as such:
    - A _document_ is made up of a mixture of _topics_
    - A _topic_ is made up of a mixture of _words_
    - Here, _mixture_ means probability distribution (this will come back to haunt us in future weeks)

---
level: 3
---

# Topic Models
  
- Each topic has a probability associated with each word, and higher probability words are more likely to be used by documents that contain higher levels of the topic
- These probabilities across words sum to one within each topic
- Each document has a probability associated with each topic, and these also sum to one in each document
- Interpreting:
  - Higher probability words are more associated with their topics
  - Higher probability topics are more associated with their documents

---
level: 3
---

# Lots of Topic Models

- LDA, implemented in the `topicmodels` package in `R`
  - Topics in LDA are modeled as independent
  - The Alvero, et al. (2021) paper uses a version of LDA that allows for correlated topics
- Structural topic models
  - Allow for topic mixtures to vary as a function of other covariates
  - You'll use these in the `stm` package in PS3
- Embedding-based topic models exist
  - BERTopic is the most common 
  - Last I checked it was kind of horrible
  - These are also harder to interpret
  