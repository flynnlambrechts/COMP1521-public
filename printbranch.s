#x $t0
#y $t1

main:
	li $v0, 4
	la $a0, prompt
	syscall

	#scanf
	li $v0, 5
	syscall
	move $t0, $v0
	ble $t0, 46340, square_x



too_big:
	li $v0, 4
	la $a0, too_big_msg
	
square_x:
	
	
	.data
prompt:
	.asciiz "Enter a number: "
too_big_msg:
	.asciiz "Square too big for 32 bits\n"
