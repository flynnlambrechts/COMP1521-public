.text
main:
	# $t0 - x
	# $t1 - message

	la	$a0, prompt
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall
	move	$t0, $v0

	la	$t1, small_big

	ble	$t0, 100, print_string
	bge	$t0, 1000, print_string

	la	$t1, medium

print_string:
	move	$a0, $t1
	li	$v0, 4
	syscall

epilogue:
	jr	$ra

	.data
prompt:
	.asciiz "Enter a number: "
small_big:
	.asciiz "small/big\n"
medium:
	.asciiz  "medium\n"