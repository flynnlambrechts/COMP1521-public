---
tags: 
aliases: 
date: 2024-10-21
title: Integers
category: None
---
# Integers
---
## Negative Numbers in Code and the [[Two's Complement]]
To convert an integer from true bits to it's decimal value.
1. If the MSB is 1, then convert as you normally would a [[Binary And Decimal|Binary To Decimal]]
2. Otherwise taken the two's complement and treat the number as negative.

> [!example] Example
> `twos_complement(0x8000) = ~0x1000 0000 0000 0000 + 1 = 0x0111 1111 1111 1111 + 1 = 0x1000 0000 0000 0000 = pow(2, 15) = 32768`
> i.e. 0x8000 represents the decimal number -32768

### Why bother:
There are a couple reasons we do this instead of simply having the MSB represent the sign and the rest be the number
1. Since this way there is only one zero. Otherwise `0b1000 0000` and `0b0000 0000` would be negative and positive zero
	1. This means we can get the range for `-128` to `+128` instead of `-127` to `+127`
2. This allows us to use the same hardware for addition and subtraction
3. The Two's complement let's us take the negative of a negative and it still makes sense

Here's an example, take the number `-1` for example if we only had 8 bits the naive approach would be to represent this as `0b1000 0001`. 
But now if we add `1` to this we get `0b1000 0010` i.e. -2 according to our system. 
Let's try it the twos complement way i.e. `-1 = 0b1111 1111` adding `1` we get `0b0000 0000` (since the carry falls off the end) which is zero as it should be and everyone is happy.

# Next Up: [[Floating Point Numbers]]
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

