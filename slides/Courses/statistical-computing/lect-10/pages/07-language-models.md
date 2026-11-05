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
- Tons of ways to do this; some work better than others
  - Transformer based models generally work best
  - Recurrent neural network models (RNNs) were the old state of the art
  - Before that, models were purely statistical and based on word and/or character frequency
- Part 3 of ps5 builds a character based language model---let's talk about what that is and how it works

---
level: 3
---

# A character-based language model

- **Core Idea:** Some character combinations are common (e.g., `th`, `on`, `er`) and some are not (e.g., `qz`, `xx`, `uu`), so we have some idea of what English words _should_ look like
- If we train a model from some corpus by counting the instances of two-letter pairs, we can compare two pieces of new text and see which set of character combinations looks more likely to exist given our trained model

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

---
level: 3
---

# Details that matter

- **Unseen pairs:** a pair that never appears in the training text gets probability 0, and $\log 0 = -\infty$ wipes out the whole string
  - The fix is _smoothing_: e.g., add 1 to every count before turning counts into probabilities
- **Which probability?** You can use the probability of the pair itself, $P(\text{th})$, or the probability of the second letter given the first, $P(\text{h} \mid \text{t})$
  - The second one is next-token prediction!
- **Length:** every pair adds a negative log probability, so longer strings always look less likely
  - To compare strings of different lengths, use the average log probability per pair

---
level: 2
---

# Similarity between strings

- For strings of text, there are a ton of options:
  - Hamming Distance counts the number of positions where the two strings are different
    - Only defined for strings of the same length: `karolin` and `kathrin` have a Hamming distance of 3
    - `hamburger` and `burgers` (or `here` and `there`) have no Hamming distance, and padding the shorter string makes them look very different (8 and 5)
  - Levenshtein distance measures the minimum number of single-character edits required to change one into the other
    - Counts insertions, deletions, and substitutions
    - `hamburger` and `burgers` have a Levenshtein distance of 4
    - `here` and `there` have a Levenshtein distance of 1

---
level: 3
hideInToc: true
---

# Similarity between sets

- For sets, we often use Jaccard Similarity
  - The number of items that are common to both sets divided by the number of items across both sets
  - Very common with binary (or dichotomous) data!
  - e.g., compare two words by the sets of character pairs they contain
  
$$ J(A,B) = \frac{|A \cap B|}{|A \cup B|} = \frac{|A \cap B|}{|A| + |B|- |A \cap B|}$$
