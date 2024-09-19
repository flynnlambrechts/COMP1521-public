main:
	la	$a0, prompt
	li	$v0, 4
	syscall
	
	.data
prompt:
	.asciiz "n = "