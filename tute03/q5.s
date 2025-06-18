N_SIZE = 10
	.text
main:
	# $t0 - i
	# $t1 - &numbers[i]
	
loop_init:
	li	$t0, 0
loop_cond:
	bge	$t0, N_SIZE, loop_end
loop_body:
	li	$v0, 5
	syscall
	

	la	$t1, numbers
	mul	$t2, $t0, 4
	add	$t1, $t1, $t2  	# $t1 = &numbers[i]

	sw	$v0, ($t1)
loop_step:
	addi	$t0, $t0, 1
	j	loop_cond
loop_end:


	jr	$ra

	.data
numbers:
	.word	0:N_SIZE