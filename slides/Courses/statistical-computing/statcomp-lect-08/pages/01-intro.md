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

- PS4 due the day before Halloween
  - Very spooky
  - How's it going?
- If you haven't already, please do the mid-semester survey
  - [https://forms.gle/Ljh25bvYeoAL5dEU8](https://forms.gle/Ljh25bvYeoAL5dEU8)


---
level: 3
---

# Check-In

- [PollEv.com/klintkanopka](https://PollEv.com/klintkanopka)


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

$$ ||\vec{x} ||_2 = \sqrt{\vec{x}^2} $$
$$ ||\vec{x} ||_2 = \sqrt{\vec{x}\cdot\vec{x}} $$
$$ ||\vec{x} ||_2 = \sqrt{\sum_{k=1}^K x_k^2} $$
$$ ||\vec{x} ||_2 = \sqrt{x_1^2 +  \cdots + x_k^2} $$

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
$$ ||\vec{x} ||_1 = |x_1| +  \cdots + |x_k|$$

</v-clicks>