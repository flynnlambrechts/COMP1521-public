# Reads 10 numbers into an array, bubblesorts them
# and then prints the 10 numbers
# YOUR-NAME-HERE, DD/MM/YYYY

# Constants
ARRAY_LEN = 10

main:
	# Registers:
	#  - $t0: int i
	#  - $t1: temporary result
	#  - $t2: temporary result
	#  - $t3: swapped
	#  - $t4: x
	#  - $t5: y

scan_loop__init:
	li	$t0, 0				# i = 0
scan_loop__cond:
	bge	$t0, ARRAY_LEN, scan_loop__end	# while (i < ARRAY_LEN) {

scan_loop__body:
	li	$v0, 5				#   syscall 5: read_int
	syscall					#
						#
	mul	$t1, $t0, 4			#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers			#
	add	$t2, $t2, $t1			#
	sw	$v0, ($t2)			#   scanf("%d", &numbers[i]);

	addi	$t0, $t0, 1			#   i++;
	b	scan_loop__cond			# }
scan_loop__end:

	li $t3, 1				# int swapped = 1
big_while:
	bne $t3, 1, end_big_while	# if swapped != 1 end loop
	li $t3, 0				# int swapped = 0

	li	$t0, 1				# i = 1
swap_loop:
	bge	$t0, ARRAY_LEN, end_swap_loop	# if i >= ARRAY_LEN stop loop	

	mul	$t1, $t0, 4			#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers			#
	add	$t2, $t2, $t1			#
	
	lw	$t4, ($t2)			# x = numbers[i]
	lw	$t5, -4($t2)			# y = nunbers[i - 1]

if_swapped:
	bge	$t4, $t5, end_if_swapped
	sw	$t5, ($t2)			# numbers[i] = y
	sw 	$t4, -4($t2)			# numbers[i-1] = x
	li $t3, 1				# int swapped = 1
end_if_swapped:
	addi	$t0, $t0, 1
	b 	swap_loop
end_swap_loop:


	b big_while
end_big_while:


print_loop__init:
	li	$t0, 0				# i = 0
print_loop__cond:
	bge	$t0, ARRAY_LEN, print_loop__end	# while (i < ARRAY_LEN) {

print_loop__body:
	mul	$t1, $t0, 4			#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers			#
	add	$t2, $t2, $t1			#
	lw	$a0, ($t2)			#
	li	$v0, 1				#   syscall 1: print_int
	syscall					#   printf("%d", numbers[i]);

	li	$v0, 11				#   syscall 11: print_char
	li	$a0, '\n'			#
	syscall					#   printf("%c", '\n');

	addi	$t0, $t0, 1			#   i++
	b	print_loop__cond		# }
print_loop__end:
	
	li	$v0, 0
	jr	$ra				# return 0;


	.data
numbers:
	.word	0:ARRAY_LEN			# int numbers[ARRAY_LEN] = {0};
