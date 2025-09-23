SQUARE_MAX = 46340
	.text
main:
	# x - $t0
	# y - $t1

	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 5
	syscall
	move	$t0, $v0

	bgt	$t0, SQUARE_MAX, too_big

square:
	mul	$t1, $t0, $t0
	
	move	$a0, $t1 
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

	j	epilogue
too_big:
	li	$v0, 4
	la	$a0, too_big_string
	syscall
epilogue:
	li	$v0, 0
	jr	$ra
	
	.data
prompt:
	.asciiz "Enter a number: "
too_big_string:
	.asciiz "square too big for 32 bits\n"