.text


main:
	li	$a0, 11
	li	$a1, 13
	li	$a2, 17
	li	$a3, 19
	jal	sum4

	move	$a0, $v0
	li	$v0, 1
	syscall

	li	$a0, '\n'
	li	$v0, 11
	syscall

main_epilogue:
	li	$v0, 0
	jr 	$ra


sum4:
sum4_prologue:
	begin
	push 	$ra
	push 	$s0
	
	jal	sum2
	move	$t0, $v0

	move	$a0, $a2
	move	$a1, $a3
	jal	sum2
	move	$a1, $v0

	move	$a0, $s0
	jal	sum2

sum4_epilogue:
	pop	$s0
	pop 	$ra
	end
	jr	$ra

sum2:
	begin
	push	$ra

	add	$v0, $a0, $a1	
sum2_epilogue:
	pop $ra
	jr $ra
	end