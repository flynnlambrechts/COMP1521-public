---
tags: 
aliases: 
date: 2024-10-21
title: Two's Complement
category: None
---
# Two's Complement
---
Take a number
1. Invert all the bits
2. Add one (if any carry ignore it)
$$
TwosComplement(x) =  \textasciitilde x + 1
$$
## It's Own Inverse
The twos complement is it's own inverse.
**Try this:**
The number 5 is `0b0000 0101` taking the twos complement is `~0b0000 0101 + 1 = 0b1111 1010 + 1 =  0b1111 1011` (which represents -5)
Now take the twos complement of this `~0b1111 1011 + 1 = 0b0000 0100 + 1 = 0b0000 0101` which is again back to 5. 
This makes perfect since the negative of a negative number is positive.
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

