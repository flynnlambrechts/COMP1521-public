	.text
main:
	# $t0 - n
	# $t1 -  fac
	# $t2 - i
	la	$a0, n_string
	li	$v0, 4
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

	la	$a0, n_fac_string
	li	$v0, 4
	syscall

	move	$a0, $t1
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

epilogue:
	li	$v0, 0
	jr	$ra


.data
n_string:
.asciiz "n  = "
n_fac_string:
.asciiz "n! = "