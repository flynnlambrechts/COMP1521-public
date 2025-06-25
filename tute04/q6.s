	.text
max:
    # Frame:    [...]   <-- FILL THESE OUT!
    # Uses:     [...]
    # Clobbers: [...]
    #
    # Locals:           <-- FILL THIS OUT!
    #   - ...
    #
    # Structure:        <-- FILL THIS OUT!
    #   max
    #   -> [prologue]
    #       -> body
    #   -> [epilogue]
max__prologue:

max__body:

max__epilogue:



	# some simple test code which calls max
main:
main__prologue:
	push	$ra

main__body:
	la	$a0, array
	li	$a1, 10
	jal	max			# result = max(array, 10)

	move	$a0, $v0
	li	$v0, 1			# syscall 1: print_int
	syscall				# printf("%d", result)

	li	$a0, '\n'
	li	$v0, 11			# syscall 11: print_char
	syscall				# printf("%c", '\n');

	li	$v0, 0

main__epilogue:
	pop	$ra
	jr	$ra			# return 0;


	.data
array:
	.word 1, 2, 3, 4, 5, 6, 4, 3, 2, 1