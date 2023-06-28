# Reads numbers until a non-negative number is entered

main:
	# Registers:
	#   - $t0: int x
while:
	li	$v0, 4			# syscall 4: print_string
	la	$a0, prompt_str		#
	syscall				# printf("Enter a number: ");

	li	$v0, 5			# syscall 5: read_int
	syscall				#
	move	$t0, $v0		# scanf("%d", &x);

	bge	$t0, 0, pos

	li	$v0, 4			# syscall 4: print_string
	la	$a0, not_pos_str		#
	syscall		

	b while
pos:
	li	$v0, 4			# syscall 4: print_string
	la	$a0, result_str		#
	syscall				# printf("You entered: ");

	li	$v0, 1			# syscall 1: print_int
	move	$a0, $t0		#
	syscall				# printf("%d", x);

	li	$v0, 11			# syscall 11: print_char
	li	$a0, '\n'		#
	syscall				# printf("%c", '\n');
	
	b end_while

end_while:


	li	$v0, 0
	jr	$ra			# return 0;

########################################################################
# .DATA
# Add any strings here that you want to use in your program.
	.data
prompt_str:
	.asciiz "Enter a number: "
result_str:
	.asciiz "You entered: "
not_pos_str:
	.asciiz "Enter a positive number\n"
# Reads numbers until a non-negative number is entered

main:
	# Registers:
	#   - $t0: int x
while:
	li	$v0, 4			# syscall 4: print_string
	la	$a0, prompt_str		#
	syscall				# printf("Enter a number: ");

	li	$v0, 5			# syscall 5: read_int
	syscall				#
	move	$t0, $v0		# scanf("%d", &x);

	bge	$t0, 0, pos

	li	$v0, 4			# syscall 4: print_string
	la	$a0, not_pos_str		#
	syscall		

	b while
pos:
	li	$v0, 4			# syscall 4: print_string
	la	$a0, result_str		#
	syscall				# printf("You entered: ");

	li	$v0, 1			# syscall 1: print_int
	move	$a0, $t0		#
	syscall				# printf("%d", x);

	li	$v0, 11			# syscall 11: print_char
	li	$a0, '\n'		#
	syscall				# printf("%c", '\n');
	
	b end_while

end_while:


	li	$v0, 0
	jr	$ra			# return 0;

########################################################################
# .DATA
# Add any strings here that you want to use in your program.
	.data
prompt_str:
	.asciiz "Enter a number: "
result_str:
	.asciiz "You entered: "
not_pos_str:
	.asciiz "Enter a positive number\n"

