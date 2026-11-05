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

- A _token_ $(t)$ is an individual unit of text (usually a word)
- A _document_ $(d)$ is a collection of tokens
- A _corpus_ $(D)$ is a collection of documents
- A _vocabulary_ $(V)$ is the collection of tokens represented in a corpus

---
level: 3
---

# Quantification of text

- All of the statistics and models we use to describe things act on _numbers_

<v-clicks depth="2">

- How might we turn text into numbers?
- The options boil down to basically two things:
  1. Count words (classical NLP)
  2. Embed words in a vector space (deep NLP)
- From here, we aggregate up to the document level in some way
- The most common classical way to represent a corpus for analysis is the _Document Term Matrix_ (DTM)
  - One row per document in a corpus
  - One column per word in the vocab
  - Word counts in the individual cells
  - Treats documents as a _bag of words_

</v-clicks>

---
level: 3
---

# Preprocessing

- Raw text is kind of a mess!

<v-clicks>

- At the most basic level, we want to strip punctuation and convert words to lowercase
- What other problems can arise from just counting words?
- **Stop words** are super common words
  - e.g., a, an, the
  - Typically non-informative about the actual content of text, so we remove them
- Sometimes the "same" word can appear in a different form
  - Singular and plural words (dog and dogs)
  - Adjectives and adverbs (quick, quicker, quickly)
  - **Stemming** is the process of stripping tokens down so that these differences are counted together
- More important in classical methods
- Not needed for deep methods
- Often you'll have domain-specific words you also want to drop

</v-clicks>



---
level: 3
---

# Counting words

- Any thoughts on what we could do with a DTM to learn about the collection of documents?

<v-clicks depth="2">

- We can count how many times a term $t$ appears in document $d$

$$f_{t,d}$$

- We can count how many times a term $t$ appears in corpus $D$

$$ \sum_{d\in D} f_{t,d} $$

- We can look at the most common tokens in a document, or _term frequency_

$$ \text{tf}(t, d) = \frac{f_{t,d}}{\sum_{t'\in d} f_{t',d}} $$

- Frequently used words get higher term frequencies and are associated with being more important to an individual document

</v-clicks>

---
level: 3
---

# Counting words

- We can look at how many documents a word appears in, or _inverse document frequency_

<v-clicks depth="2">

$$ \text{idf}(t, D) = \ln \frac{|D|}{|\{d\in D: t\in d\}|} $$

- Rare words get _higher_ inverse document frequency
- A common way combine these into one weight is _term frequency inverse document frequency_ (tf-idf)

$$\text{tf-idf}(t, d, D) = \text{tf}(t,d)\cdot\text{idf}(t,D)$$

- This weight is applied to combinations of terms and documents
  - High term frequency means a term is common in a document
  - High inverse document frequency means a term is rare in the corpus
  - High tf-idf means that a term is important to the document it is in ($t$ is common in $d$ but rare in $D$)

</v-clicks>
