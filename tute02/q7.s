	.text
main:
	# $t0 - x
loop_init:
	li	$t0, 24
loop_cond:
	bge	$t0, 42, loop_end
loop_body:
	li	$v0, 1
	move	$a0, $t0	
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall
loop_step:
	addi	$t0, $t0, 3
	j	loop_cond
loop_end:

epilogue:
	jr	$ra