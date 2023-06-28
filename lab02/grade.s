# read a mark and print the corresponding UNSW grade
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]
#mark $t1
main:
	la	$a0, prompt	# printf("Enter a mark: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", mark);
	syscall

	move $t1, $v0
	bge $t1, 85, hdist
	bge $t1, 75, dist
	bge $t1, 65, credit
	bge $t1, 50, pass
	b fail
hdist:
	la	$a0, hd		# printf("HD\n");
	b endif;
dist:
	la	$a0, dn		# printf("DN\n");
	b endif;
credit:
	la	$a0, cr		# printf("CR\n");
	b endif;
pass:
	la	$a0, ps		# printf("PS\n");
	b endif;
fail:
	la	$a0, fl		# printf("FL\n");
	b endif;



endif:

	li	$v0, 4
	syscall

	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter a mark: "
fl:
	.asciiz "FL\n"
ps:
	.asciiz "PS\n"
cr:
	.asciiz "CR\n"
dn:
	.asciiz "DN\n"
hd:
	.asciiz "HD\n"
