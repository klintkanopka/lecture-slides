---
level: 1
layout: section
---

# Computer Architecture

---
level: 3
---

# Why care about architecture?

- Two things decide how fast our code runs:
  - How fast the processor can do arithmetic
  - How fast it can get the data it needs to do that arithmetic
- Usually the second one is the bottleneck!
- A rough mental model of the hardware helps explain things that seem like magic:
  - Why vectorized code is fast
  - Why `apply(X, MARGIN = 2, ...)` over columns is quicker than over rows
  - Why parallel code is never as fast as we hope
- Four pieces today: memory, scheduling, multiple cores, and GPUs

---
level: 3
---

# The memory hierarchy

<div class="grid grid-cols-[3fr_2fr] gap-6">
<div>

- Data lives in layers, from small and fast to big and slow
- If an L1 read took **1 second**, RAM would take **2 minutes** and an SSD **a day**
- Data moves in chunks, so neighboring values come along for free
  - `R` stores vectors and matrix columns contiguously
- Run out of RAM and the computer falls back on the disk: everything crawls

</div>
<div>

```mermaid {scale: 0.5}
flowchart TB
  REG["<b>Registers</b><br/>bytes · under 1 ns"]
  L1["<b>L1 cache</b> (per core)<br/>~100 KB · ~1 ns"]
  L2["<b>L2 cache</b><br/>a few MB · ~4 ns"]
  L3["<b>L3 cache</b> (shared)<br/>tens of MB · ~10–40 ns"]
  RAM["<b>RAM</b><br/>8–64 GB · ~100 ns"]
  DISK["<b>SSD / hard disk</b><br/>TBs · ~0.1–10 ms"]
  REG --- L1 --- L2 --- L3 --- RAM --- DISK
```

<p class="text-xs opacity-70 text-center">Typical numbers; they vary by machine</p>

</div>
</div>

---
level: 3
---

# Processes and scheduling

<div class="grid grid-cols-[3fr_2fr] gap-6">
<div>

- Your computer runs hundreds of _processes_, but each core runs one at a time
- The operating system's _scheduler_ gives each a time slice of a few milliseconds, then switches
- Why it matters for us:
  - More workers than cores just take turns
  - Other programs compete for the same cores, so timings vary
- HPC clusters have a scheduler too (like Slurm) that hands out cores to jobs

</div>
<div>

```mermaid {scale: 0.85}
stateDiagram-v2
  direction TB
  [*] --> Ready: starts
  Ready --> Running: scheduled
  Running --> Ready: time slice ends
  Running --> Waiting: needs disk/network
  Waiting --> Ready: data arrives
  Running --> [*]: finished
```

</div>
</div>

---
level: 3
---

# Multi-core processors

<div class="grid grid-cols-[3fr_2fr] gap-6">
<div>

- A processor has several _cores_, each running its own process
- Each core has small private caches; all cores share the big cache and RAM
- `R` is _single-threaded_: one session uses one core
- Parallel `R` starts several `R` processes, one per core
- Speedups fall short because workers compete for shared memory, and some chips mix fast and slow cores (my laptop has 4 of each)

</div>
<div>

```mermaid {scale: 0.55}
flowchart TB
  subgraph CHIP["Processor chip"]
    C1["<b>Core 1</b><br/>L1 / L2"]
    C2["<b>Core 2</b><br/>L1 / L2"]
    C3["<b>Core 3</b><br/>L1 / L2"]
    C4["<b>Core 4</b><br/>L1 / L2"]
    L3["<b>Shared L3 cache</b>"]
    C1 & C2 & C3 & C4 --- L3
  end
  RAM["<b>RAM</b><br/>shared by every core"]
  L3 --- RAM
```

</div>
</div>

---
level: 3
---

# CPUs vs GPUs

<div class="grid grid-cols-[3fr_2fr] gap-6">
<div>

- A **CPU** has a few powerful cores, good at complicated, step-by-step logic
- A **GPU** has thousands of simple cores running the _same_ instruction on _different_ data
  - Built for graphics (matrix arithmetic), which is why they're great for deep learning
- Data must be copied to the GPU's own memory first, which is slow
- So GPUs only help with big, uniform arithmetic; base `R` doesn't use them (`torch` does)

</div>
<div>

```mermaid {scale: 0.75}
flowchart TB
  CPU["<b>CPU</b><br/>4–24 powerful cores<br/>large caches"]
  RAM["<b>RAM</b>"]
  VRAM["<b>GPU memory</b>"]
  GPU["<b>GPU</b><br/>thousands of simple cores<br/>same instruction, different data"]
  CPU --- RAM
  RAM ---|"copy data over (slow)"| VRAM
  VRAM --- GPU
```

</div>
</div>
