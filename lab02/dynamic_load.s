

#	$t0	instruction

main:
	la 	$v0, 4 
	la 	$a0, prompt
	syscall 
loop1:
	la	$v0, 5		# scanf instruction
	syscall
	move	$t0, $v0
	
	move	$a0, $t0
	la	$v0, 1
	syscall

	bne	$t0, -1, loop1
end1:
	
	la 	$v0, 4 
	la 	$a0, startprompt
	syscall 


	la 	$v0, 4 
	la 	$a0, finishprompt
	syscall 

	jr 	$ra
	.data
prompt:
	.asciiz "Enter mips instructions as integers, -1 to finish:\n"
startprompt:
	.asciiz "Starting executing instructions\n"
finishprompt:
	.asciiz "Finished executing instructions\n"
