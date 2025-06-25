FLAG_ROWS = 6
FLAG_COLS = 12
SIZEOF_CHAR = 1
	.text
main:
	# $t0 - row
	# $t1 - col


	li	$t0, 0
loop_rows_cond:
	bge	$t0, FLAG_ROWS, loop_rows_end

	li	$t1, 0
loop_cols_cond:
	bge	$t1, FLAG_COLS, loop_cols_end

	mul	$t2, $t0, FLAG_COLS
	add	$t2, $t2, $t1
	mul	$t2, $t2, SIZEOF_CHAR

	lb	$a0, flag($t2)
	li	$v0, 11
	syscall
	
loop_cols_step:
	addi	$t1, $t1, 1
	j	loop_cols_cond

loop_cols_end:
	li	$a0, '\n'
	li	$v0, 11
	syscall

loop_rows_step:
	addi	$t0, $t0, 1
	j	loop_rows_cond
loop_rows_end:

li	$v0, 0
jr	$ra

	.data
flag:
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
	.byte '#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'