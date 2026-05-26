---
level: 2
layout: section
---

# Data Augmentation

---
level: 3
---

# Simulation and Generation vs. Augmentation

<v-clicks depth="2">

- Simulation studies are a treasured feature of our field
  - Simulated data are generated from scratch according to a known data-generating process (DGP)
  - Simulated data are used to examine how models behave under a range of possible DGPs
- Data augmentation is conceptually quite different from simulating data, however
- Data augmentation is the process of using existing data to generate new data
  - Typically the goal is to attempt to mimic an _unknown_ DGP for a lower cost than collecting new data
  - These data are then combined with the real data to train new models
  - See: Van Dyk, D. A., & Meng, X. L. (2001). [The art of data augmentation](https://www.tandfonline.com/doi/abs/10.1198/10618600152418584?casa_token=4FXmJ5QGN9oAAAAA:_QQRHgIhnIau0owxfTlH62kkzvDGoei-SzAow-KAdhedmwHWGM6uJaapC0m-ABl9ag89kgFURLcoNQ). _Journal of Computational and Graphical Statistics_, 10 (1), 1–50.
- Data augmentation requires known good data and does not generate useful data from nothing

</v-clicks>



---
level: 3
---

# Data Augmentation

<img
  v-click
  style="position: absolute; top: 100px; left: 100px; width: 300px"
  src="/da-hotdog-1.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 100px; left: 500px; width: 300px"
  src="/da-dog-1.jpg"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 150px; left: 150px; width: 300px"
  src="/da-hotdog-2.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 150px; left: 550px; width: 300px"
  src="/da-dog-2.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 200px; left: 100px; width: 300px"
  src="/da-hotdog-3.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 200px; left: 500px; width: 300px"
  src="/da-dog-3.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 250px; left: 150px; width: 300px"
  src="/da-hotdog-4.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 250px; left: 550px; width: 300px"
  src="/da-dog-4.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 300px; left: 100px; width: 300px"
  src="/da-hotdog-5.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 300px; left: 500px; width: 300px"
  src="/da-dog-5.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 350px; left: 150px; width: 300px"
  src="/da-hotdog-6.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 350px; left: 550px; width: 300px"
  src="/da-dog-6.png"
  alt=""
/>

<img
  v-click
  style="position: absolute; top: 400px; left: 100px; width: 300px"
  src="/da-hotdog-7.png"
  alt=""
/>



---
level: 3
---

# Psychometric Data Augmentation

<v-clicks depth="3">

- What are our options for data augmentation?
- Merely perturbing human responses randomly is unlikely to preserve the DGP
- We’re going to use a Large Language Model (LLM)
- It’s super important to note that LLMs are generally quite bad at simulating human responses to things:
  - Wang, P., Zou, H., Yan, Z., Guo, F., Sun, T., Xiao, Z., & Zhang, B. (2024). [Not yet: Large language models cannot replace human respondents for psychometric research](https://osf.io/download/rwy9b). _Preprint_.
  - Liu, Y., Bhandari, S., & Pardos, Z. A. (2025). [Leveraging LLM respondents for item evaluation: A psychometric analysis](https://bera-journals.onlinelibrary.wiley.com/doi/full/10.1111/bjet.13570). _British Journal of Educational Technology_, 56 (3), 1028–1052.
- **Two really important takeaways:**
  - **I am not here advocating for replacing all human respondents with LLM-generated responses**
    - If you want to measure constructs in people, you need to give your items to people!
  - **The method I will present today scales with the quality of your LLM-generated item responses**
    - GIGO always holds!

</v-clicks>
