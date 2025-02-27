	.text
main:
	# $t0 - x
	# $t1 - y

	la	$a0, prompt_string
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall
	move	$t0, $v0

	mul	$t1, $t0, $t0

	move	$a0, $t1
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

	li	$v0, 0
	jr 	$ra	
	.data
prompt_string:
	.asciiz "Enter a number: "