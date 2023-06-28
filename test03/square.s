# $t0, x
# $t1, i
# $t2, j


main:
	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0

	li $t1, 0

while1:
	bge $t1, $t0, endwhile1

	addi $t1, $t1, 1 #i++

	li $t2, 0	
while2:
	bge $t2, $t0, endwhile2

	li	$a0, '*'		# printf(*);
	li	$v0, 11
	syscall

	addi $t2, $t2, 1 #j++
	b while2
endwhile2:


	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall	

	b while1
	addi $t1, $t1, 1 #i++
endwhile1:

end:
	li	$v0, 0		# return 0
	jr	$ra
