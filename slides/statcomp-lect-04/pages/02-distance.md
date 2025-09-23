---
level: 1
layout: section
---

# Tools

---
level: 2
layout: section
---

# Measuring Distances

---
level: 3
---

# Measuring Distances

- If you want to talk about how "close together" two things are, you need some notion of distance
- Distances are _dissimilarity_ metrics
  - Larger magnitudes mean less similar (or farther apart) objects
  - Assign a value of 0 to identical objects
- Contrast these with _similarity_ metrics
  - Larger magnitudes mean more similar (or closer together) objects
  - Assign maximal values (sometimes 1) to identical objects

---
level: 3
layout: image
image: ../img/map.png
---

<img
  v-click
  style="position: absolute; top: 400px; left: 250px; width: 30px"
  src="../img/pin.png"
  alt=""
/>
<img
  v-click
  style="position: absolute; top: 140px; left: 600px; width: 30px"
  src="../img/pin.png"
  alt=""
/>
<arrow v-click x1="285" y1="410" x2="500" y2="70" width="4" color="#3772ff" />
<arrow v-click x1="510" y1="70" x2="610" y2="135" width="4" color="#3772ff" />
<arrow v-click x1="285" y1="410" x2="610" y2="140" width="4" color="#df2935" />


---
level: 3
---

# Measuring Distances

- Most generically, we often think about _Euclidean distance_
  - Sometimes called "as the crow flies"
  - It's straight line distance


$$ d(p,q) = \sqrt{(x_p - x_q)^2 + (y_p - y_q)^2}$$
$$d(p,q) = \sqrt{\sum_i (p_i - q_i)^2}$$


---
level: 3
---

# Measuring Distances

- Depending on the situation, something else might make more sense!
- Another spatial distance metric is _Manhattan distance_
- It's what you might expect from the name


$$ d(p,q) = |x_p - x_q| + |y_p - y_q|$$
$$d(p,q) = \sum_i |p_i - q_i|$$
