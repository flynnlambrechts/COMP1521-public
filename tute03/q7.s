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
	mul	$t1, $t0, 4
	lw	$t2, numbers($t1)

	bgez 	$t2, loop_step
	
	addi	$t2, $t2, 42
	sw	$t2, numbers($t1)
loop_step:
	addi	$t0, $t0, 1
	j	loop_condition
loop_end:
	li	$v0, 0
	jr	$ra

	.data
numbers:
	
	.word	0, 1, 2, -3, 4, -5, 6, -7, 8, 9

