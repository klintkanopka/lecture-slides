---
level: 1
layout: section
---

# Dating Apps

---
level: 2
hideInToc: true
---

# Dating Apps

<v-clicks depth="3">

- I think most people have tried dating apps?
- A rough dating app typology:
  - Question-based
    - OKCupid and older apps
  - Swipe-based
    - Tinder, Hinge, etc
  - Location-based
    - Grindr, Scruff
- Other stuff?


</v-clicks>

---
level: 3
---

# Dating Apps

<v-clicks depth="3">

- What’s the goal of a dating app?
  - Make money
    - Sell premium features
    - Maximize ad exposure
  - Connect people
    - If people don’t like who they see, they won’t use the app
    - If nobody talks to a person, they won’t use the app
- What could we do if we design our own app?
  - How would you design the app?
  - How would you match users?
  - Talk to a few neighbors about it!


</v-clicks>

---
level: 3
---

# Tinder

<v-clicks depth="2">

- Tinder used to use an Elo system (Bumble, too)
- The probability person $i$ swipes right on person $j$, $X_{ij} = 1$, depends on the difference between their-  latent scores in the app
    - Assumes people will swipe left $(X_{ij} = 0)$ on people they view as “beneath them”
    - Goal: Display profiles to maximize the probability that they swipe right _on each other_
    - When is this probability maximized?
- Turns out this made people really upset
- Now they display people based on app usage


</v-clicks>


---
level: 3
---

# Hinge

<v-clicks depth="3">

- Hinge is “designed to be deleted” or something
- They treat dating as a stable matching problem
  - Assume we have two groups that attempt to match with each other, $A,B$
    - Pairings are not stable if a member of $A$ prefers some member of $B over the one they’re matched with
    - _and_ the member of $B$ they prefer also prefers them over who the member of $A$ they’re matched with
- The solution to this is the Gale-Shapley Agorithm (which won the 2012 Nobel Prize in Economics)
  - This requires group members to develop rankings of members of the other group

</v-clicks>

---
level: 3
---

# Gale-Shapley Algorithm

<v-clicks depth="3">


- How it works:
  - In each iteration, members of group $A$ who have not yet matched make an offer to their top choice in group 𝐵 who they have not yet made an offer to
  - Members of group 𝐵 evaluate their offers against their current match and either accept the best new offer or reject all offers
  - Repeat until all members are matched
- Guaranteed to match everyone
- Guaranteed to produce stable matches

</v-clicks>

---
level: 3
---

# Back to Hinge

<v-clicks depth="3">


- What’s the problem?
- Users don’t produce rankings of everyone they’re trying to date!
- How does Hinge infer rankings?
  - They use interaction patterns to determine the type of users you prefer
  - They’re not specific about the methods they use, but we could make some guesses!
  - How would you do it?

</v-clicks>


---
level: 3
---

# OKCupid

<v-clicks depth="3">

- Individuals respond to questions and describe how their ideal partner would respond to those questions
  - Additionally they specify how important responses are to them
- OKCupid provides users with “Match %”
  - They’re not super specific on what the actual model is
- How could we do this?

</v-clicks>


---
level: 3
---

# OKCupid Experiments

<v-clicks depth="3">

- OKCupid has been really open about the fact that they collect lots of data and experiment on their users
- The book _Dataclysm_ is a super interesting documentation of applied statistics, measurement, and data science from the founder of OKCupid
- In 2013 OKCupid made a bunch of people pretty upset:
  - They basically just randomly rearranged the match scores
  - Turns out, if you tell people they’re a high percentage match, they’re more likely to talk to each other and keep talking
- The OKCupid Data Blog used to be full of cool stuff, but it’s really only accessible via the Wayback Machine

</v-clicks>