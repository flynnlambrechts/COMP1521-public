# COMP1521 22T2 ... final exam, question 2

main:
	li	$v0, 5		# syscall 5: read_int
	syscall
	move	$t0, $v0	# read integer into $t0


	li 	$t2, 0	# count
	li  $t1, 0  # i
loop1:
	bge	$t1, 32, loop1_end
	andi	$t3, $t0, 1
	beq		$t3, 1, loop1_step
	addi	$t2, $t2, 1

loop1_step:
	sra 	$t0, $t0, 1
	addi	$t1, $t1, 1
	b 	loop1
loop1_end:

	li		$v0, 1		# syscall 1: print_int
	move	$a0, $t2
	syscall			# printf("42");

	li	$v0, 11		# syscall 11: print_char
	li	$a0, '\n'
	syscall			# printf("\n");
	# REPLACE THE LINES ABOVE WITH YOUR CODE

main__end:
	li	$v0, 0		# return 0;
	jr	$ra
