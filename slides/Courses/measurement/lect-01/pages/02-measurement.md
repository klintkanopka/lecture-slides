---
level: 1
layout: section
---

# Measurement

---
level: 2
---

# Measurement

- The quantification of attributes of an object or event, which can be used to compare with other objects or events
- The fundamental building block of all quantitative science
- A measurement has four parts:
  - **Level** (or type): ratio, difference, ordinal, nominal[^2]
  - **Magnitude**: the number assigned by an _instrument_
  - **Unit**: the scale factor that allows comparison between different measurements
  - **Uncertainty**: a quantification of the error inherent to making the measurement, often a function of the properties of the instrument itself
  
[^2]: Nominal quantities are often _not_ considered measurements, but we are going to talk about them in the second half of the course

---
level: 2
---

# Units and Scales

- Meters
- Kilograms
- Proof
- Scoville heat units
- Mohs scale
- Schmidt pain index

---
level: 3
---

# Psychometrics

- Psychometrics is the study and practice of measuring psychological constructs
- _“All that exists, exists in some amount and can be measured” - E.L. Thorndike, 1918_
- Big problem:
  - Psychological constructs aren't directly observable
  - We call these _latent_ constructs
  - How do we measure what we can't observe?
- You put people in carefully crafted situations and see what they do
  - Tests
  - Surveys
  - Behavioral screeners
  - Observation protocols
  - We will blanket refer to these types data as _item response data_


---
level: 3
---

# Paradigm Shift

- Often survey research cares about _population_ level inferences
- Here we care about and develop tools for inference and comparison at the _individual_ level


---
level: 3
---

# The "Modern" Part: Unsupervised Machine Learning

- Machine learning is often used in a _supervised_ context
  - We have known outcomes
  - We can measure performance on out of sample data
  - We can predict outcomes for new observations
- Measurement contexts aren't like that!
- We can, however, think of them as _unsupervised_ machine learning problems
  - There is no known outcome
  - The model is supposed to learn patterns from the data
  - The constraints we put on the model dictate the types of patterns it will be sensitive to
  - Things like person abilities, item difficulties, and weights of individual items are all unknown and need to be estimated simultaneously
  - To do this, we'll use the EM algorithm (which will be a party in a future lecture)

---
level: 2
layout: section
---

# Scoring

---
level: 3
---

# Scoring

- Scoring is the process of summarizing individual item responses
- We want to think deeply about how scoring is done, as it is the fundamental process of measurement!
- For each of the assessments on the next slide, think:

1. How could we score each of these?
2. What are potential pros and cons of different scoring practices?

---
level: 3
---

# Scoring

## 1. Depression Screener

  1. I feel down, depressed, or hopeless
  2. I have trouble getting out of bed in the morning
  3. Every single day of my life is worse than the day before it, meaning every day you see me is on the worst day of my life

## 2. Math Test

  1. $4+3=?$
  2. $8 \div 2(2+2) = ?$
  3. $\int_0^\pi \sin x\ dx=?$

## 3. Health Screener

  1. Do you have diabetes?
