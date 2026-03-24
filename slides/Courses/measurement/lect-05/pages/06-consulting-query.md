---
level: 2
---

# Fitting Polytomous Models with `mirt`

<v-clicks>

- Data should be an item response matrix
  - Individual responses are numeric
  - If response categories are ordered, use ordered integers
  - It does not matter whether the lowest category starts at 0 or 1
- Choose model type using `itemtype` in `mirt()`
  - `'Rasch'` fits a partial credit model with discriminations fixed to 1
  - `'gpcm'` fits a generalized partial credit model
  - `'graded'` fits a graded response model
  - `'nominal'` fits a nominal response model

</v-clicks>


---
level: 1
layout: section
---

# Break

---
level: 1
layout: section
---

# Consulting Query

---
level: 3
---

# Consulting Query

- Many of us are engaged in our own research or work
- If you have a question related to class content and can share context or data, we can discuss it as a group
- If you can share data, it's possible that we even can do your work for you!
- The goal is for this class to be responsive and useful for your own needs

---
level: 3
---

# The Problem

Someone approaches you with the following request seeking your newfound consulting expertise:

_I am conducting a study and want to measure grit. I found some questions online and asked them to a bunch of people without doing any real pilot or preparation. I spent all of my research budget doing this, so I can't recollect my data. I need grit scores for each person and want to see how they relate to age. Can you help me make sense of this?_

With $3 \pm 1$, you'll figure out how screwed they are! Download the data [here](https://github.com/klintkanopka/lecture-slides/blob/main/slides/measurement-lect-05/public/grit_brummerhoffman_2021.csv).

- Take a look at the data
    - What looks good? 
    - What looks bad?
    - What information do you have?
- Come up with a (vague) plan!
    - We'll check in before I turn you loose to execute your plan

---
level: 3
---

# The Items

Items are rated on a 5-point scale from 1 being _not at all like me_ to 5 being _very much like me_. The item names and their text are listed below:
				
- (`grit_diligent`) I am diligent.
- (`grit_finish`) I finish whatever I begin. 
- (`grit_focus`) I have difficulty maintaining my focus on projects that take more than a few months to complete. 
- (`grit_goals`) I often set a goal but later choose to pursue a different one. 
- (`grit_hardworking`) I am a hard worker.
- (`grit_interest`) I have been obsessed with a certain idea or project for a short time but later lost interest.
- (`grit_new_projects`) New ideas and projects sometimes distract me from previous ones.
- (`grit_setbacks`) Setbacks don't discourage me.


