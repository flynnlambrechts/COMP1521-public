main:

loop_init:
	li	$t0, 24 # x = 24
loop_cond:
	bge	$t0, 42, loop_end
loop_body:
	move	$a0, $t0
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall
loop_step:
	addi	$t0, $t0, 3
	j	loop_cond
loop_end:
	jr	$ra