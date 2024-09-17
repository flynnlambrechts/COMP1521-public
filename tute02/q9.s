	.text
main:
	# $t0 n
	# $t1: fac
	# $t2: i

	li	$v0, 4
	la	$a0, prompt
	syscall

	li	$v0, 5
	syscall
	move	$t0, $v0


	li	$t1, 1
loop_init:
	li	$t2, 1
loop_cond:
	bgt	$t2, $t0, loop_end
loop_body:
	mul	$t1, $t1, $t2
loop_step:
	addi	$t2, $t2, 1
	j	loop_cond
loop_end:

	li	$v0, 4
	la	$a0, output_text
	syscall

	li	$v0, 1
	move	$a0, $t1
	syscall

	li	$v0, 11
	li	$a0, '\n'
	syscall

	li	$v0, 0
	jr	$ra
.data
prompt:
	.asciiz "n  = "
output_text:
	.asciiz "n! = "