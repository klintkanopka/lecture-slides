---
level: 2
transition: fade
---

# Table of Contents

<Toc text-sm minDepth="1" maxDepth="2"/>


---
level: 2
---

# Announcements

- PS0 and PS1 grades are out!
- PS2 is due tomorrow at 11.59p!
- PS3 is out!
  - It has six parts
  - They are not ordered by difficulty
  - You should be able to do them all using information from lecture today
  - Start soon!
- Really enjoying seeing people around the department, at office hours, and active in Slack


---
level: 2
layout: image-right
image: /problem-sets.png
---

# A Note on Past Problem Sets

- Correlation between scores on the two assignments is low $(r=0.34)$
- People mostly did better on PS1 (above the dotted line)
- People who did worse had one of two problems:
  - Not following directions on Part 3
  - Turning it in late
- If you have a problem with how either assignment was graded, you can submit a regrade request on Gradescope and I'll take a look


---
level: 2
---

# A Note on Searching

- Everything we do is really a search problem
- The challenge is that the search spaces are often infinite
- All of the models we pick and assumptions we make limit the size of the search space
- The algorithms we use define how we carry out the search
- Good choices of models/assumptions/algorithms allow us to take intractable problems and solve them relatively quickly and easily!

---
level: 1
layout: section
---

# Motivating Problem

---
level: 2
---

# Buffon's Needle

  Suppose we have a floor made of parallel strips of wood, each with the same width, and we drop a needle onto the floor. What is the probability that the needle will lie across a line between two strips?

<div v-click>

## More Specifically:
  Given a needle of length $l$ dropped on a floor with parallel lines distance $t$ apart, what is the probability that the needle will lie across a line when landing?

</div>

---
level: 3
layout: image
image: /needle.png
---
