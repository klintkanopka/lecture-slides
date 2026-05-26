---
level: 2
layout: section
---

# The Mixed Subjects Design

---
level: 3
---

# Mixed Subjects Designs

<img
  src="/mixed-subjects-qr.png"
  alt="QR code for mixed subjects design paper"
  style="position: absolute; top: 155px; right: 95px; width: 260px"
/>

<div style="width: 58%">

- Introduced in Broska, D., Howes, M., & van Loon, A. (2025). [The mixed subjects design: Treating large language models as potentially informative observations](https://journals.sagepub.com/doi/full/10.1177/00491241251326865?casa_token=sqfih2_iC7QAAAAA%3A1CL0BsGPwJOzn7TUjmTfzD9obMclvnzQZYneM3c7uCQs5cFamYQfvaFynS9ESXCGGlOMXg9wUrOqaw). _Sociological Methods & Research_, 00491241251326865.
- Extended estimators for causal estimation presented in our new preprint: Van Loon, A. & Kanopka, K. [Using Large Language Models as a Source of Human Behavioral Data in Social Science Experiments](https://doi.org/10.31235/osf.io/y74mu_v1). _SocArXiv Preprint_.

</div>

---
level: 3
layout: center
zoom: 2
---

![](/mixed-subj.png)

---
level: 3
---

# Mixed Subjects Design

<v-clicks depth="2">

- Instead of assuming that human-generated data and LLM-generated data are exchangeable (and therefore should be directly pooled), it treats LLM-generated data as potentially informative
- Uses PPI++ to combine the human-generated and LLM-generated data
  - The LLM serves the role of $f(\cdot)$
  - The key observation is that for the unlabeled data, $N \rightarrow \infty$
- Ensures unbiased parameter estimates and valid confidence intervals that are as small as (or smaller than) human estimates
- Degree of CI shrinkage depends on how similar the human-generated and LLM-generated data are
  - The better the LLM predictions, the larger the increase in the effective sample size


</v-clicks>
