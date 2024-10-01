.text
change:
change_prologue:
	begin
	push	$ra
change_body:

	li	$t0, 0
loop_row:
	bge	$t0, $a0, loop_row_end

	li	$t1, 0	
loop_col_cond:
	bge	$t1, $a1, loop_col_end

	mul	$t2, $t0, $a1
	add	$t2, $t2, $t1
	mul	$t2, $t2, 4 # T2: [row][col]
	add	$t2, $t2, $a2 # T2: &M[row][col]
	lw	$t3, ($t2) # T3: M[row][col]

	mul	$t3, $t3, $a3 # $t3 = M[row][col] * factor

	sw	$t3, ($t2)
	
	addi	$t1, $t1, 1
	j	loop_col_cond
loop_col_end:

loop_row_step:
	addi	$t0, $t0, 1
	j	loop_row

loop_row_end:

change__epilogue:
	pop	$ra
	end
	
	jr	$ra