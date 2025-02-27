SQUARE_MAX = 46340

main:
	# $t0 - x
	# $t1 - y


	la	$a0, prompt_string
	li	$v0, 4
	syscall	 		# printf("Enter a number: ");

	li	$v0, 5
	syscall
	move	$t0, $v0	# scanf("%d", &x);

	ble	$t0, SQUARE_MAX, print_square
too_big:
	la	$a0, too_big_string
	li	$v0, 4
	syscall	 

	j	epilogue

print_square:
	mul	$t1, $t0, $t0

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
prompt_string:
	.asciiz "Enter a number: "
too_big_string:
	.asciiz	"square too big for 32 bits\n"