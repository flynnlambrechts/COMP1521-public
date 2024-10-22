---
tags: 
aliases: 
date: 2024-10-21
title: IEEE 754 Standard
category: None
---
# IEEE 754 Standard
---
The Formula
$$
\text{sign } \times (1 + \text{frac}) \times 2^{\text{exp} - 127}
$$
Where the components are portions of 32 bit number.
`s eeee eeee fff ffff ffff ffff ffff ffff`
From left to right (most sig to least sig)
- 1 bit of sign
- 8 bits of exponent
- 32 - 1 - 8 = 23 bits of fraction

## Converting [[Decimal]] Numbers into IEEE

**Example**
We know (from [[Binary And Decimal]]) that 29.125 in binary is 11101.001, which can be written as
$1.1101001 \times 2^4$ using scientific notation for [[Binary]] numbers
so `sign = 0`, `frac = 1101001`, `exp = 4 + 127 = 131`
now all that left to do is to convert the exponent from [[Binary And Decimal|Decimal to Binary]] which is `131 = 0b 1000 0011`

So our number is 
`0    1000 0011    110 1001 0000 0000 0000 0000`

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

