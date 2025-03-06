N_SIZE = 10
	.text
main:
	# $t0 - i
	
	li	$t0, 0
main__loop_cond:
	bge	$t0, N_SIZE, main__loop_end
main__loop_body:
	li	$v0, 5
	syscall
	move	$t1, $v0

	mul	$t2, $t0, 4	# i * 4
	addi	$t2, $t2, numbers
	sw	$t1, ($t2)

main__loop_step:
	addi	$t0, $t0, 1
	j	main__loop_cond
main__loop_end:

main__epilogue:
	li	$v0, 0
	jr	$ra

	.data
numbers:
	.word	N_SIZE:0

