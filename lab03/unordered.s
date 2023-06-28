# Reads 10 numbers into an array
# printing 0 if they are in non-decreasing order
# or 1 otherwise.
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
	li	$t0, 0				# i = 0;
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
	j	scan_loop__cond			# }
scan_loop__end:

	# TODO: add your code here!
	li	$t3, 0				# int swapped = 0;
	li	$t0, 1				# int i = 1;
swapped_loop:
	bge	$t0, ARRAY_LEN, swapped_loop_end# while (i < ARRAY_LEN) {
		
	mul	$t1, $t0, 4			#   calculate &numbers[i] == numbers + 4 * i
	la	$t2, numbers			#
	add	$t2, $t2, $t1			#
	addi	$t2, $t2, -4

	lw	$t4, 4($t2)			# x = numbers[i]	
	lw	$t5, 0($t2)			# y = numbers[i-1]
	
if_swapped:
	bge	$t4, $t5, end_if_swapped	# if (x >= y) endif
	li 	$t3, 1

end_if_swapped:
	
	addi	$t0, $t0, 1			#   i++;
	b 	swapped_loop
swapped_loop_end:

	li	$v0, 1				# syscall 1: print int
	move	$a0, $t3
	syscall	

	li	$v0, 11				# syscall 11: print_char
	li	$a0, '\n'			#
	syscall					# printf("%c", '\n');

	li	$v0, 0
	jr	$ra				# return 0;

	.data
numbers:
	.word	0:ARRAY_LEN			# int numbers[ARRAY_LEN] = {0};
