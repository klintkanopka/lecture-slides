---
level: 1
layout: section
---

# Tools


---
level: 2
---

# Single Precision Floating Point Numbers

- In computers, numbers are typically stored using 32 bits of memory
  - Each bit can have a value of either 0 or 1
  - This means that there are only 4,294,967,296 possible values
  - This has to cover every possible positive number, negative number, decimal, or super huge value
- The way computers handle this is using floating point numbers
  - Think of this as scientific notation
  - $2,395,423 \rightarrow 2.395423 \times 10^6$
- How is this stored?
  - One bit stores the sign (+/-)
  - Eight bits store the exponent (256 values, ranging from -126 to 127 with all 0s or 1s held back)
  - 23 bits stores the mantissa (this is about 6-8 decimal places of precision)
  - Importantly, the more extreme the value of the exponent, the less precise the entire number
  - This means nearly all computations contain some amount of rounding error

---
level: 2
---

# Monotonic Functions and Transformations

- A function is monotonic if it preserves order
- For a monotonic function, $f$:
  - $a > b \implies f(a) > f(b)$
- We will use the _log transformation_ all the time in numerical optimization
- Because $\log(x)$ is a monotonic function:
  
$$ \operatorname*{argmin}_{x} f(x) =  \operatorname*{argmin}_{x} \log f(x) $$

- You can turn multiplication into addition, leading to less extreme exponent values
    - $\log(ab) = \log(a) + \log(b)$
- The log transform maps positive numbers with negative exponents to negative numbers (with smaller exponents) and positive numbers with positive exponents into positive numbers (with smaller exponents)



---
level: 2
---

# Derivatives and Gradients

- Recall the derivative of a function with respect to a variable $x$ is the slope of a line tangent to the function at a specific value of $x$
- The gradient is the multivariate (read: _vector_) generalization of the derivative
  - The gradient constructs a column vector of partial derivatives
- If you think of a multivariate function as a surface, the gradient is a vector that points "uphill"
- We write the derivative of $f$ with respect to $x$ as: $\frac{df}{dx}$
- If $f$ takes a vector argument, $\mathbf{x}$, of dimension $k$, we write the gradient of $f$ as: $\nabla f$ 

$$\nabla f = \frac{\partial f}{\partial \mathbf{x}}= \begin{bmatrix} \frac{\partial f}{\partial x_1} \frac{\partial f}{\partial x_2} \cdots \frac{\partial f}{\partial x_k} \end{bmatrix}^\top$$

