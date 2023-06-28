# Read a number and print positive multiples of 7 or 11 < n
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

# $t0 i
# $t1 number
# $t2 rem7
# $t3 rem11

main:				# int main(void) {

	la	$a0, prompt	# printf("Enter a number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall
	move 	$t1, $v0
	
	li 	$t0, 1		# int i = 0;
loop1:	
	rem 	$t2, $t0, 7
	rem	$t3, $t0, 11


	beq	$t2, $zero, then1
	beq	$t3, $zero, then1
loopcont:
	addi 	$t0, $t0, 1
	bgt $t1, $t0, loop1
	j end
then1:
	move	$a0, $t0	# printf("%d", i);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	j loopcont	
end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter a number: "
