SQUARE_MAX = 46340
	.text
main:
	# $t0 - x
	# $t1 - y
	la	$a0, prompt
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall
	move	$t0, $v0

	ble	$t0, SQUARE_MAX, else_cond

	la	$a0, too_big_string
	li	$v0, 4
	syscall

	b	epilogue
else_cond:
	mul	$t1, $t0, $t0 # y = x * x

	move	$a0, $t1
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

epilogue:
	li	$v0, 0
	jr	$ra

	.data
prompt:
	.asciiz "Enter a number: "
too_big_string:
	.asciiz "square too big for 32 bits\n"