---
level: 1
layout: section
---

# Measurement of and with Text

---
level: 2
hideInToc: true
---

# This week's readings

- Alvero, A. J., Giebel, S., Gebre-Medhin, B., Antonio, A. L., Stevens, M. L., &amp; Domingue, B. W. (2021). Essay content and style are strongly related to household income and SAT scores: Evidence from 60,000 undergraduate applications. _Science advances, 7(42)_, eabi9031.
- Fesler, L., Dee, T., Baker, R., &amp; Evans, B. (2019). Text as data methods for education research. _Journal of Research on Educational Effectiveness, 12(4)_, 707-727.
- Grimmer, J., &amp; Stewart, B. M. (2013). Text as data: The promise and pitfalls of automatic content analysis methods for political texts. _Political analysis, 21(3)_, 267-297.
- Roberts, M. E., Stewart, B. M., &amp; Tingley, D. (2019). Stm: An R package for structural topic models. _Journal of Statistical Software, 91_, 1-40.
- Garg, N., Schiebinger, L., Jurafsky, D., &amp; Zou, J. (2018). Word embeddings quantify 100 years of gender and ethnic stereotypes. _Proceedings of the National Academy of Sciences, 115(16)_, E3635-E3644.

---
level: 3
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
- The options boil down to basically two things:
  1. Count words (classical NLP)
  2. Embed words in a vector space (deep NLP)
- From here, we aggregate up to the document level
- The most common way to represent a corpus for analysis is the _Document Term Matrix_ (DTM)
  - One row per document in a corpus
  - One column per word in the vocab
  - Word counts in the individual cells
  - Treats documents as a _bag of words_


---
level: 3
---

# Preprocessing

- Raw text is kind of a mess!
- At the most basic level, we want to strip punctuation and convert words to lowercase
  - What other problems can arise from just counting words?
- **Stop words** are super common words 
  - e.g., a, an, the
  - Typically non-informative about the actual content of text, so we remove them
- Sometimes the "same" word can appear in a different form
  - Singular and plural words (dog and dogs)
  - Adjectives and adverbs (quick, quicker, quickly)
  - **Stemming** is the process of stripping tokens down to stems so that these differences are counted together
- Typically you want to do these sorts of things
  - More important in classical methods
  - Not needed for deep methods
  - Often you'll have domain-specific words you also want to drop
  