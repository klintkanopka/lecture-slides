---
level: 1
---

# More Similarity Metrics

- How do you know that two things are similar?
- In some ways, "similarity" is the inverse of "distance"
- You can use distance formulas (Euclidean, Manhattan)
- Minkowsky Distance generalizes the two:
  
$$ D(A,B) = \bigg( \sum_{i=1}^n |a_i - b_i|^p \bigg)^{\frac{1}{p}}$$

---
level: 3
hideInToc: true
---

# More Similarity Metrics

- For vectors, we frequently use _cosine similarity_
  - Measures the angle between two vectors
  - Cares about the _direction_ they point in, but not the _length_
  
$$ S_c(A,B) = \frac{\mathbf{A}\cdot\mathbf{B}}{||A|| ||B||} = \frac{\sum_{i=1}^n a_i b_i}{\sqrt{\sum_{i=1}^n a_i^2}\cdot \sqrt{\sum_{i=1}^n b_i^2}}  $$

---
level: 3
hideInToc: true
---

# Similarity between other things

- For sets, we often use Jaccard Similarity
  - The number of items that are common to both sets divided by the number of items across both sets
  - Very common with binary (or dichotomous) data!
  
$$ J(A,B) = \frac{|A \cap B|}{|A \cup B|} = \frac{|A \cap B|}{|A| + |B|- |A \cap B|}$$

---
level: 3
hideInToc: true
---

# Similarity between other strings

- For strings of text, there are a ton of options:
  - Hamming Distance counts the number of positions where the two strings are different
    - `hamburger` and `burgers` have a Hamming distance of 8
    - `here` and `there` have a Hamming distance of 5
  - Levenshtein distance measures the minimum number of single-character edits required to change one into the other
    - Counts insertions, deletions, and substitutions
    - `hamburger` and `burgers` have a Levenshtein distance of 4
    - `here` and `there` have a Levenshtein distance of 1



---
level: 1
layout: section
---

# The Quantification of Text

---
level: 3
hideInToc: true
---

# Quick text vocabulary

- A _token_ is an individual unit of text (usually a word)
- A _document_ is a collection of tokens
- A _corpus_ is a collection of documents
- A _vocabulary_ is the collection of tokens represented in a corpus

---
level: 3
---

# Quantification of text

- All of the statistics and models we use to describe things act on _numbers_
- How might we turn text into numbers?

<v-click>

- The options boil down to basically two things:
  1. Count words (classical NLP)
  2. Embed words in a vector space (deep NLP)

</v-click>

<v-click>

- From here, we aggregate up to the document level in some way

</v-click>

<v-click>

- The most common classical way to represent a corpus for analysis is the _Document Term Matrix_ (DTM)
  - One row per document in a corpus
  - One column per word in the vocab
  - Word counts in the individual cells
  - Treats documents as a _bag of words_

</v-click>



---
level: 3
---

# Preprocessing

- Raw text is kind of a mess!

<v-click>

- At the most basic level, we want to strip punctuation and convert words to lowercase
  - What other problems can arise from just counting words?

</v-click>
<v-click>

- **Stop words** are super common words 
  - e.g., a, an, the
  - Typically non-informative about the actual content of text, so we remove them

</v-click>
<v-click>

- Sometimes the "same" word can appear in a different form
  - Singular and plural words (dog and dogs)
  - Adjectives and adverbs (quick, quicker, quickly)
  - **Stemming** is the process of stripping tokens down to stems so that these differences are counted together

</v-click>
<v-click>

- More important in classical methods
- Not needed for deep methods
- Often you'll have domain-specific words you also want to drop

</v-click>
  
  
---
level: 1
layout: section
---

# Classical Text Analysis
  
---
level: 3
hideInToc: true
---

# Classical text analysis

- Any thoughts on what we could do with a DTM to learn about the collection of documents?
- We can look at the most common tokens in the corpus
- We can look at the most common tokens in a document, or _term frequency_ 

$$ \text{tf}(t, d) = \frac{f_{t,d}}{\sum_{t'\in d} f_{t',d}} $$ 

- We can look at how many documents a word appears in, or _inverse document frequency_

$$ \text{idf}(t, D) = \ln \frac{N}{d\in D: t\in D} $$

- A common way to weight is tf-idf: 

$$\text{tf-idf}(t, d) = \text{tf}(t,d)\cdot\text{idf}(t,D)$$

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

- Core idea: Topic models are basically principal component analysis performed on the DTM
- A singular value decomposition (SVD) on the DTM is called Latent Semantic Analysis (LSA)
  - This is functionally the same as doing a PCA on the DTM
  - Interpretation and use is identical - each "topic" is a dimension and words are more or less associated with each
- A better topic model is the Latent Dirichlet Allocation (LDA)
  - A Bayesian model (if you don't know what this means it doesn't super matter)
  - Structured as such:
    - A _document_ is made up of a mixture of _topics_
    - A _topic_ is made up of a mixture of _words_
    - Here, _mixture_ means probability distribution 

---
level: 3
---

# Topic Models
  
- Dealing with topic models is conceptually similar to dealing with PCA
- The interpretation you did in lab yesterday is the move!
- There are lots of types of topic models
  - Correlated topic models
  - Structural topic models
    - Allow for topic mixtures to vary as a function of other covariates
    - Use the excellent `stm` package for these
    
---
level: 1
layout: section
---

# Natural Language Processing with Deep Learning

---
level: 2
---

## Word vectors

- The more modern approach is to not preprocess text, but instead _embed_ it in a high dimensional vector space
- This means instead of word counts, documents are a sequence of high dimensional (typically $N \approx 300$) vectors
- Word2Vec was the classic implementation
  - "You shall know a word by the company it keeps"
  - Words that co-occur are pushed closer together in the vector space
  - Words that don't co-occur are spread farther apart
  - Typically trained on an enormous corpus (Google News, Google Books, etc)
- Word vectors capture latent features of language usage
  - See Garg, et al. (2018) for the most famous word embedding paper 
- Word vectors can also be aggregated in different ways to get up to document-level embeddings

---
level: 2
---

# Transformer Models

- Transformers are a specific deep learning architecture developed by Google scientists
  - Vaswani, A., et al. (2017). Attention is all you need. _Advances in neural information processing systems, 30._
- Bidirectional Encoder Representations from Transformers (BERT) provide contextual embeddings that allow words to have different representations based on context
- Seq2seq models map sequences of embeddings to other sequences of embeddings and drove most machine translation
- Large Language Models (LLMs) like ChatGPT are wildly over-parameterized transformer models that work on vector embeddings 