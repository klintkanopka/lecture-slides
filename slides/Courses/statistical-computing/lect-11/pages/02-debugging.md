---
level: 1
layout: section
---

# Advanced Debugging

---
level: 2
---

# The tools we have so far

<v-clicks>

- Googling error messages
- `print()` statements
- `traceback()`
- Any others?

</v-clicks>

---
level: 3
---

# What about generative AI?

<v-clicks>

- I honestly don't know that much about debugging code with AI tools, though I've started using Claude Code this year
- What's your experience been with using AI tools to help you debug or write code?
- Are there other models/tools that you use?
- What prompting strategies do you use?
- Do you feel like using generative AI to help with coding tasks increases your understanding?
- Any other notes?

</v-clicks>

---
level: 2
---

# A more powerful debugging tool: `browser()`

- `browser()` lets you step into the code and execute it line by line while you monitor what is loaded in each environment and the values of intermediate objects
- You can further step into functions you encounter along the way
- How does it work?
  - You insert the `browser()` function call into some code you want to debug
  - When R reaches `browser()`, all execution halts
  - You get a special prompt in the console, `Browse[1]>`, to let you know you're doing browser stuff, and the next line to be run appears above it
  - The Environment pane shows you the values and variables for the environment you're currently executing code in

---
level: 3
---

# Using `browser()`

- First, you can use the `Browse[1]>` prompt like any other sort of console prompt and execute code from there
- Second, and more importantly, you get access to a bunch of new commands:
  1. `n` runs the **next** line of code (whatever is currently above the prompt)
  2. `s` is like next, but if the next line is a function, you'll **step into** it and run it interactively (line-by-line)
  3. `c` exits step-by-step mode and **continues** running normally (until the next `browser()` or the end)
  4. `Q` **quits** out of the browser

---
level: 3
---

# Why and how to use `browser()`?

- Essentially it's not too far off from inserting `print()` statements after every single line
- It allows you to see what changes after each line of code is run
- You can also insert code into a function to see if it fixes your problem
- A few other ways to use it:
  - Running `debug(FUN)` flags `FUN` so that every call to `FUN()` opens the browser at its first line. Turn this off with `undebug(FUN)`
  - `debugonce(FUN)` does the same, but only for the next call to `FUN()`

<v-click>

- **Next let's use `browser()` with the activity from lab yesterday**

</v-click>