	.text
main:
	# $t0 i
	li	$t0, 0

loop_init:
loop_cond:
	bge	$t0, 10, loop_end
loop_body:
	la	$t2, numbers
	mul	$t3, $t0, 4

	lw	$a0, ($t3)
	li	$v0, 4
	syscall
loop_step:
	addi	$t0, $t0, 1
	j	loop_cond
loop_end:


epilogue:
	li	$v0, 0
	jr 	$ra

	.data
numbers:
	.word 10, 0