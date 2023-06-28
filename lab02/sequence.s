# Read three numbers `start`, `stop`, `step`
# Print the integers bwtween `start` and `stop` moving in increments of size `step`
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

# start $t0
# stop $t1
# step $t2
# i $t3

main:				# int main(void)
	la	$a0, prompt1	# printf("Enter the starting number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall
	move $t0, $v0
	
	la	$a0, prompt2	# printf("Enter the stopping number: ");
	li	$v0, 4
	syscall
	
	li	$v0, 5		# scanf("%d", number);
	syscall
	move $t1, $v0

	la	$a0, prompt3	# printf("Enter the step size number: ");
	li	$v0, 4
	syscall
	
	li	$v0, 5		# scanf("%d", number);
	syscall
	move 	$t2, $v0





if1:
	bge $t1, $t0, cont1	# if stop > start goto cont1
	bge $t2, $zero, cont1	# if step > 0 goto cont1		

	move $t3, $t0		# int i = start
loop1:
	
	move	$a0, $t3	# printf("%d", i);
	li	$v0, 1
	syscall
	
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	
	add $t3, $t3, $t2	# i += step
	
	bge $t3, $t1, loop1 	# keep looping if i >= stop
	
cont1:

if2:
	bge $t0, $t1, cont2	# if start > stop  goto cont2
	bge $zero, $t2, cont2	# if step < 0 goto cont2		

	move $t3, $t0		# int i = start
loop2:

	move	$a0, $t3	# printf("%d", i);
	li	$v0, 1
	syscall
	
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	
	add $t3, $t3, $t2	# i += step
	
	bge $t1, $t3, loop2 	# keep looping if i <= stop
	
cont2:
end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt1:
	.asciiz "Enter the starting number: "
prompt2:
	.asciiz "Enter the stopping number: "
prompt3:
	.asciiz "Enter the step size: "
