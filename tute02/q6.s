	.text
main: 
	# $t0: x

	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 5
	syscall
	move	$t0, $v0

	ble	$t0, 100, small_big
	bge	$t0, 1000, small_big
medium:
	la	$a0, medium_out
	j	print
small_big:
	la	$a0, small_big_out
	j 	print
print:
	li	$v0, 4
	syscall


epilogue:
	li	$v0, 0
	jr	$ra

	.data
prompt:
	.asciiz "Enter a number: "
medium_out:
	.asciiz "medium\n"
small_big_out:
	.asciiz "small/big\n"
