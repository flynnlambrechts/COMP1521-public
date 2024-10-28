FLAG_ROWS = 6
FLAG_COLS = 12
SIZEOF_CHAR = 1
	.text
main:
row_loop_init:
	li	$t0, 0
row_loop_cond:
	bge	$t0, FLAG_ROWS, row_loop_end
row_loop_body:

	li	$t1, 0
col_loop_cond:
	bge	$t1, FLAG_COLS, col_loop_end

	mul	$t2, $t0, FLAG_COLS
	add	$t2, $t2, $t1
	mul	$t2, $t2, SIZEOF_CHAR
	lb	$a0, flag($t2)

	li	$v0, 11
	syscall

	addi	$t1, $t1, 1
	j	col_loop_cond
col_loop_end:

	li	$a0, '\n'
	li	$v0, 11
	syscall

row_loop_step:
	addi	$t0, $t0, 1
	j	row_loop_cond
row_loop_end:


main__epilogue:
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