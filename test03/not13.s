main:
	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0

	li	$v0, 5		# scanf("%d", &y);
	syscall			#
	move	$t1, $v0

	move $t2, $t0   # int i = num1
	addi $t2, $t2, 1  # i++

loop:
	bge $t2, $t1, end_loop

	beq	$t2, 13, endif

	move	$a0, $t2		# printf("%d\n", 42);
	li	$v0, 1
	syscall	

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall	
endif:

	addi $t2, $t2, 1
	b loop
end_loop:


end:
	li	$v0, 0         # return 0
	jr	$ra
