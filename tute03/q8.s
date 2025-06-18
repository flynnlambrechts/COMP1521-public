N_SIZE = 10
N_SIZE_M_1 = N_SIZE - 1
N_SIZE_D_2 = N_SIZE / 2
	.text
main:

	li	$t0, 0
loop_cond:
	bge	$t0, N_SIZE_D_2, loop_end

	mul	$t1, $t0, 4

	sub	$t2, N_SIZE_M_1, $t0
	mul	$t2, $t2, 4

	lw	$t3, numbers($t1)
	lw	$t4, numbers($t2)

	sw	$t4, numbers($t1)
	sw	$t3, numbers($t2)	

	addi	$t0, $t0,1
	j	loop_cond

loop_end:

epilogue:
	li	$v0, 0
	jr	$ra 

	.data
numbers:
	.word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
numbers2:
	.word 5