N_SIZE = 10
	.text
main:
	# $t0 - i
	# $t1 - numbers[i]
	# $t2 - intermediate value for array indexing
main__loop_init:
	li	$t0, 0
main__loop_cond:
	bge	$t0, N_SIZE, loop_end
main__loop_body:
	mul	$t2, $t0, 4
	lw	$t1, numbers($t2)

	blt	$t1, 0, main__if_true
	j	main__end_if
main__if_true:
	# numbers[i] += 42;
	addi	$t1, $t1, 42
	sw	$t1, numbers($t2)
main__end_if:

main__loop_step:
	addi	$t0, $t0, 1
	b	main__loop_cond

main__loop_end:
main__epilogue:
	li	$v0, 0
	jr	$ra

	.data
numbers:
	.word 0, 1, 2, -3, 4, -5, 6, -7, 8, 9