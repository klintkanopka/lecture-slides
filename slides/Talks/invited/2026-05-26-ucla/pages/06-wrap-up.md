---
level: 1
layout: section
transition: fade
---

# Wrap Up

---
level: 2
---

# Caveats

<v-clicks depth="2">

- First and foremost, this is only helpful if your LLM-based item responses are informative!
  - Garbage in, garbage out
  - The upside is that if your predicted responses are garbage, power tuning will have $\hat{\lambda} \rightarrow 0$ and the only thing you waste is your time and the money you spent prompting the LLM
- There's a hidden scale linking step to place item parameters estimated from human subjects and silicon subjects on the same scale
- The way you do the power tuning depends explicitly on how you plan to score the test
  - ML and EAP estimates of ability propagate error in parameter estimates differently
- In finite samples, estimating item parameters and power tuning on the same sample will produce biased item parameter estimates
  - You can fix this with split-sample estimation
  - For more, see: Mani, P., Xu, P., Lipton, Z. C., & Oberst, M. (2025). [No free lunch: Non-asymptotic analysis of prediction-powered inference](https://arxiv.org/abs/2505.20178). _arXiv preprint_.


</v-clicks>


---
level: 2
---

# Looking Forward

<v-clicks depth="2">

- We've developed software, documentation, and vignettes to guide you through using this with your own data!
  - Currently finishing testing with expected release later this week!
  - You're on your own for model prompting, but we can see a world where $\hat{\lambda}$ estimates are used for evaluating the quality of LLM-generated data
- Preprint with full technical details coming very soon after the software!
- If you're interested in implementing this or doing something adjacent, let's talk more!

</v-clicks>


---
level: 3
---

# Thank you!

Happy to take questions and please feel free to reach out!

Find me at:
- New York University (let's hang out if you're in town!)
- [klint.kanopka@nyu.edu](mailto:klint.kanopka@nyu.edu)
- [@klint.bsky.social](https://bsky.app/profile/klint.bsky.social)
- [klintkanopka.com](https://klintkanopka.com)
