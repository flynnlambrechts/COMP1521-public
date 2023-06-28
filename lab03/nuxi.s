
    # - $t0:  order
    # - $t1:  number
    # - $t2: i
    # - $t3: current
    # - $t4: temp address
    # - $t5: temp byte
    # - $t6: result address
    # - $t7: number address

main:
	# ASCII: U:0x55 N:0x4e I:0x49 X:0x58
	# 1481199189 = 0x58494e55 = UNIX
	# -2023406815 = 0x87654321 = 
	# 0x5350494d = MIPS
	# 0x494d5350 = PSMI
	
	#  0x58494e55 = UNIX
	# 0x4e555849 = IXUN
	
	
	li $v0, 5   		# read_int
	syscall
	move $t0, $v0 		# num2 = scanned_val
	
	# li $t0, 1481199189
	sw $t0, order

	li $v0, 5   		# read_int
	syscall
	move $t1, $v0 		#num1 = scanned_val
	
	# li $t1, -2023406815
	sw $t1, number
	
	
	li 	$t2, 0 		# i = 0
while:
	bge $t2, 4, end_while
	la	$t4, order	# get the address of the order
	add	$t4, $t4, $t2 	# add i to the address
	lb	$t5, ($t4)	# get byte from order
	
	la	$t7, number	# get the address of the number
	add	$t7, $t7, $t2 	# add i to the address
	
	la	$t6, result	# get the address of the result
	lb 	$t8, ($t7)
	beq	$t5, 'U', U
	beq	$t5, 'N', N
	beq	$t5, 'I', I
	beq	$t5, 'X', X
	
U:
	sb	$t8, 0($t6)
	b end_if
N:
	sb	$t8, 1($t6)
	b end_if
I:
	sb	$t8, 2($t6)
	b end_if
X:
	sb	$t8, 3($t6)

end_if:
	
	# li 	$v0, 11		# print byte
	# move $a0, $t5
	# syscall
	# li	$a0, '\n'	# printf("%c", '\n');
	# li	$v0, 11
	# syscall
	
	addi $t2, $t2, 1	# i++
	b while
end_while:
	li 	$v0, 1		# print result
	lw 	$a0, 0($t6)
	syscall
	
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

	li	$v0, 0
	jr	$ra				# return 0;

	.data
order:
	.space 4
number:
	.space 4
result:
	.space 4