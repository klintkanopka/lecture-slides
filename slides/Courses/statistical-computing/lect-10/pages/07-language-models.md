---
level: 1
layout: section
---

# Language Models

---
level: 3
hideInToc: true
---

# What is a language model?

- In general: a model that describes how text is _generated_
- Models should be _generative_, meaning that they can produce new text
- Models should also be _evaluative_, meaning they can quantify the degree to which something looks like "real" text
- This is, primarily (but not always), done by next-token-prediction
- Tons of ways to do this some work better than others
  - Transformer based models generally work best
  - Recurrent neural network models (RNNs) were the old state of the art
  - Before that, models were purely statistical and based on word and/or character frequency
- Part 3 of ps5 builds a character based language model---let's talk about what that is and how it works

---
level: 3
---

# A character-based language model

- **Core Idea:** Some character combinations are common (i.e., `th`, `on`, `er`) and some are not (i.e., `qz`, `xx`, `uu`), so we have some idea of what English words _should_ look like
- If we train a model from some corpus by counting the instances of two letter pairs, we can compare two pieces new text and see which set of character combinations looks more likely to exist given our trained model

---
level: 3
---

# Building the language model

- Beginning from our training text:
  1. Preprocess the text down to just individual letter information
  2. Count pairs of characters: `teeth` gets a count for `te`, `ee`, `et`, and `th`
  3. Put all of these counts into a table where you can retrieve them easily
  4. Turn all of these counts into log probabilities

---
level: 3
---

# Using the language model

1. Take a string of text and separate it into character pairs:
  - `onions` becomes `on`, `ni`, `io`, `on`, `ns`
2. Look up each character pair in your log probability table
3. Add the log probabilities of each character pair together to get the log probability of the entire string
4. Real words should contain observed pairs of characters, and therefore be considered more likely (higher probability)