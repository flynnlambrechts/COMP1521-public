# i $t0
# j $t1

main:
	li $t0, 1

line_loop:
	bgt $t0, 10, line_end
	
	li $t1, 1
star_loop:
	bgt $t1 , $t0, star_end
	li $v0, t1
 	li $a0, '*'
	syscall

	add $t1, $t1, 1

	b star_loop


star_end:
	li $v0, 11
	li $a0, '\n'
	syscall

	add $t0, $t0, 1
	b line_loop
line_end:
	jr $ra
