---
tags: 
aliases:
  - Decimal to Binary
  - binary to decimal
date: 2024-10-14
title: Binary To Decimal
category: None
---
# Binary And Decimal
---
## Binary to Decimal
$$
\begin{align}
11010_{2} &= 1\times 2^4+1\times {2}^3+0\times 2^2 + 1 \times 2^1+0\times 2^0 \\
&=16 + 8 + 0 +2+ 0 \\
&=26
\end{align}
$$

## Decimal to Binary
1. Divide the number by two and note down the remainder

| Number | Quotient | Remainder | Significance |
| ------ | -------- | --------- | ------------ |
| 29     | 14       | 1         | LSB          |
| 14     | 7        | 0         | $\uparrow$   |
| 7      | 3        | 1         | $\uparrow$   |
| 3      | 1        | 1         | $\uparrow$   |
| 1      | 0        | 1         | MSB          |
result = `0b11101`
> [!NOTE] Note
> The result is read from the table bottom to top

### For Fractions
1. Multiply the number by two and take note of the whole portion.

| Number | Product | Whole Component | Significance |
| ------ | ------- | --------------- | ------------ |
| 0.125  | 0.25    | 0               | MSB          |
| 0.25   | 0.5     | 0               | $\downarrow$ |
| 0.5    | 1.0     | 1               | $\downarrow$ |
| 0.0    | 0.0     | 0               | LSB          |
result = 0.125 = `0b001`
So a number like 29.125 is represented as 11101.001 in binary.
# Next Up: [[]]
---
# References
---
- 
# See Also
---
- 
# Tags
---

# Thoughts
---

