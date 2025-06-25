	.text
change:


change__body:
	# $a0 - nrows
	# $a1 - ncols
	# $a2 - &M
	# $a3 - factor
	
	# $t0 - row
	# $t1 - col
	# $t2 - &M[row][col]


	li	$t0, 0
row_loop_cond:
	bge	$t0, $a0, row_loop_end


	li	$t1, 0
col_loop_cond:
	bge	$t1, $a1, col_loop_end


	mul	$t2, $t0, $a1
	add	$t2, $t2, $t1
	mul	$t2, $t2, 4	# calculate offset 
	add	$t2, $t2, $a2

	lw	$t3, ($t2)
	mul	$t3, $t3, $a3
	sw	$t3, ($t2)


col_loop_step:
	addi	$t1, $t1, 1
	j	col_loop_cond
col_loop_end:

row_loop_step:
	addi	$t0, $t0, 1
	j	row_loop_cond
row_loop_end:

change__epilogue:
	jr	$ra


	.data
