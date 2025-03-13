
	.text
main:
main__prologue:
	push	$ra
main__body:
	li	$a0, 11
	li	$a1, 13
	li	$a2, 17
	li	$a3, 19
	jal	sum4
	move	$t0, $v0 # int result = sum4(11, 13, 17, 19);

	li	$v0, 1
	move	$a0, $t0
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall
main__epilogue:
	li	$v0, 0
	pop	$ra
	jr	$ra

sum4:
sum4__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	push	$s3
	push	$s5
	push	$s6
sum4__body:
	#	$s5 - res1
	#	$s6 - res2
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2
	move	$s3, $a3

	jal	sum2
	move	$s5, $v0

	move	$a0, $s2
	move	$a1, $s3
	jal	sum2
	move	$s6, $v0


	move	$a0, $s5
	move	$a1, $s6
	jal	sum2
sum4__epilogue:
	pop	$s6
	pop	$s5
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra

sum2:
sum2__prologue:
	begin
	push	$ra
sum2__body:
	add	$v0, $a0, $a1
sum2__epilogue:
	pop	$ra
	end
	jr	$ra
