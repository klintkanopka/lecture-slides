---
level: 1
---

# Natural Language Processing with Deep Learning


---
level: 2
hideInToc: true
---

# Word vectors

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
level: 3
---

# Transformer Models

- Transformers are a specific deep learning architecture developed by Google scientists
  - Vaswani, A., et al. (2017). Attention is all you need. _Advances in neural information processing systems, 30._
- Bidirectional Encoder Representations from Transformers (BERT) provide contextual embeddings that allow words to have different representations based on context
- Seq2seq models map sequences of embeddings to other sequences of embeddings and drove most machine translation
- Large Language Models (LLMs) like ChatGPT are wildly over-parameterized transformer models that work on vector embeddings 

---
level: 1
layout: section
transition: fade
---

# Wrap Up

---
level: 2
hideInToc: true
---

# Recap

- The ways in which we quantify text limit (or augment) how we can learn from it
- Most classical methods are _bag of words_ models that just count instances of tokens
- Topic models function like factor analysis on the document term matrix
- Modern deep learning methods use vector embeddings of words to carry more information in each token


---
level: 3
---

# Check-Out

- [PollEv.com/klintkanopka](https://PollEv.com/klintkanopka)