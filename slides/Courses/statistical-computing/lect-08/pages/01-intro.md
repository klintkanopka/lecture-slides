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

- PS4 due two days before Halloween
  - Very spooky
  - How's it going?


---
level: 2
---

# Some Observations from a Midterm

A friend who is a CS professor at Tandon just gave a midterm in his computer vision class. Highlights:

<v-clicks>

- Couple of students just did 1 question out of 6 - rage quit and gave in the exam after 1 hour (out of 2.5 hours allotted), because “they don’t know what’s going on in the questions”. This is after we gave them a practice exam a week before that is an identical copy of the midterm (with numbers changed).
- They asked what is cosine of 90 and cosine of 0
- They asked how do you multiply matrices
- One of them asked to go to the bathroom during the exam, of the TA’s asked him leave his phone in his backpack before he left. When he heard that, he just gave up and gave in his midterm and left.

</v-clicks>

---
level: 2
---

# Final Exam Stuff

- We can finally reasonably start talking about final exam stuff after today!
- I was pretty openly disappointed in the results of the final from last year
  - I do admit it was probably one question too long
- In general, many students didn't seem to know how to do things that we highlighted as important (i.e., optimization, writing functions, loops, control flow, using `optim()`, bootstrapping)
- I'll post last year's final and the practice final they were given on Slack so you can see what my expectations are!



---
level: 2
---

# Vector Norms

- We often want to talk about the _length_ of a vector, but how do we measure length?
- Conceptually, think of the length of a vector as the distance it spans from the origin
- We'll talk about two types of norms today

---
level: 3
---

# The Euclidean Norm

<v-clicks>

- The Euclidean distance a vector extends in space from the origin
- Often called the $L^2$ norm and abbreviated $||\vec{x}||_2$

</v-clicks>
<v-clicks>

$$ ||\vec{x} ||_2 = \sqrt{\vec{x}\cdot\vec{x}} $$
$$ ||\vec{x} ||_2 = \sqrt{\sum_{k=1}^K x_k^2} $$
$$ ||\vec{x} ||_2 = \sqrt{x_1^2 +  \cdots + x_K^2} $$

</v-clicks>

---
level: 3
---

# The Manhattan Norm

<v-clicks>

- Sometimes called the _Taxicab Norm_
- The Manhattan distance a vector extends in space from the origin
- Often called the $L^1$ norm and abbreviated $||\vec{x}||_1$

</v-clicks>
<v-clicks>

$$ ||\vec{x} ||_1 = \sum_{k=1}^K |x_k| $$
$$ ||\vec{x} ||_1 = |x_1| +  \cdots + |x_K|$$

</v-clicks>