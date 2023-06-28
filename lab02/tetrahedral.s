# Read a number n and print the first n tetrahedral numbers
# https://en.wikipedia.org/wiki/Tetrahedral_number
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]
# $t0 how_many
# $t1 i
# $t2 j
# $t3 n
# $t4 total


main:				# int main(void) {

	la	$a0, prompt	# printf("Enter how many: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall
	move 	$t0, $v0

	li 	$t3, 1 		# n = 1

loop1:
	li	$t4, 0		# total  = 0
	li 	$t2, 1		# j = 1
loop2:
	li	$t1, 1		# i = 1
loop3:
	add	$t4, $t4, $t1	# total = total + i
	addi	$t1, $t1, 1	# i = i + 1
	
	bge	$t2, $t1, loop3	# while j >= i keep looping
end3:
	addi 	$t2, $t2, 1 	# j = j + 1
	bge	$t3, $t2, loop2	# n >= j keep looping
end2:	

	move	$a0, $t4 	# printf("%d", total);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	
	addi	$t3, $t3, 1 	# n = n + 1

	bge	$t0, $t3, loop1	# if how_many >= n keep looping

end1:



end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter how many: "
