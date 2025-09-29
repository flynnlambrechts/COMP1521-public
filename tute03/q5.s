N_SIZE = 10
	.text
main:
	# i - $t0
	# &numbers[i] - $t1


loop_init:
	li	$t0, 0
loop_condition:
	bge	$t0, N_SIZE, loop_end
loop_body:
	li	$v0, 5
	syscall
	move	$t2, $v0

	mul	$t1, $t0, 4	
	sw	$t2, numbers($t1)
loop_step:
	addi	$t0, $t0, 1
	j	loop_condition
loop_end:
	li	$v0, 0
	jr	$ra

	.data
numbers:
	# .word	0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	.word	0:N_SIZE

