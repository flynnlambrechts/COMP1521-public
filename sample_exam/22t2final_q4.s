	.data
numbers:
	.word 0:10	# int numbers[10] = { 0 };

	.text
main:
	li	$t0, 0		# i = 0;

main__input_loop:
	bge	$t0, 10, main__input_finished	# while (i < 10) {

	li	$v0, 5			# syscall 5: read_int
	syscall
	mul	$t1, $t0, 4
	sw	$v0, numbers($t1)	#	scanf("%d", &numbers[i]);
	
	addi	$t0, 1			#	i++;
	b	main__input_loop	# }

main__input_finished:
	#############################
	# TODO: YOUR CODE GOES HERE #
	#############################
	li	$t1, 1 # max_run
	li	$t2, 1 # current_run
	li	$t0, 1 # i = 1
main__loop:
	bge	$t0, 10, main__loop_finished	# while (i < 10) {
	mul	$t3, $t0, 4
	lw	$t4, numbers($t3)
	sub	$t3, $t3, 4
	lw	$t5, numbers($t3)
	ble	$t4, $t5, else1
if1:
	addi	$t2, $t2, 1
	b 	endif1
else1:
	li		$t2, 1
endif1:

	ble	$t2, $t1, endif2
if2:
	move	$t1, $t2
	b 	endif2
endif2:
	
	addi	$t0, 1			#	i++;
	b	main__loop	# }

main__loop_finished:


main__print_42:
	li	$v0, 1		# syscall 1: print_int
	move	$a0, $t1
	syscall			# printf("42");

	li	$v0, 11		# syscall 11: print_char
	li	$a0, '\n'
	syscall			# printf("\n");

	li	$v0, 0
	jr	$ra		# return 0;
