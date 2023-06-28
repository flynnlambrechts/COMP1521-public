# Sieve of Eratosthenes
# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
# YOUR-NAME-HERE, DD/MM/YYYY

# Constants
ARRAY_LEN = 1000


#	- $t0: i
#	- $t1: j
#	- $t2: prime[i]

main:

	# TODO: add your code here
	li	$t0, 2			# int i = 2
for_i_loop:
	bge	$t0, ARRAY_LEN, for_i_loop_end

	lb	$t2, prime($t0)		# prime[i]
	bne	$t2, 1, for_i_loop_step	# if prime[i] != 1

	move	$a0, $t0
	li	$v0, 1
	syscall

	li	$v0, 11			# syscall 11: print_char
	li	$a0, '\n'		# 
	syscall				# printf("%c", '\n');

	mul	$t1, $t0, 2		# int j = 2 * i
for_j_loop:
	bge	$t1, ARRAY_LEN, for_j_loop_end

	sb	$zero, prime($t1)
	
for_j_loop_step:
	add	$t1, $t1, $t0		# j += 1
	b for_j_loop
for_j_loop_end:


for_i_loop_step:
	addi	$t0, 1			# i++
	b for_i_loop
for_i_loop_end:

	li	$v0, 0
	jr	$ra			# return 0;

	.data
prime:
	.byte	1:ARRAY_LEN		# uint8_t prime[ARRAY_LEN] = {1, 1, ...};
