
FLAG_ROWS = 6
FLAG_COLS = 12
SIZE_OF_CHAR = 1

	.text
main:
	# $t0 - row
	# $t1 - col
row_loop_init:
	li	$t0, 0
row_loop_cond:
	bge	$t0, FLAG_ROWS, row_loop_end
row_loop_body:

col_loop_init:
	li	$t1, 0
col_loop_cond:
	bge	$t1, FLAG_COLS, col_loop_end
col_loop_body:
	mul	$t2, $t0, FLAG_COLS
	add	$t2, $t2, $t1
	mul	$t2, $t2, SIZE_OF_CHAR	# $t2 = OFFSET ([row][col])
	lb	$t3, flag($t2)		# $t3 = flag[row][col]
	
	move	$a0, $t3
	li	$v0, 11
	syscall				#  printf("%c", flag[row][col]);
col_loop_step:
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

epilogue:
	li	$v0, 0
	jr	$ra


	.data
flag:
   	.byte 	'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
   	.byte 	'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
   	.byte 	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
  	.byte 	'.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.', '.'
   	.byte 	'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
 	.byte 	'#', '#', '#', '#', '#', '.', '.', '#', '#', '#', '#', '#'
