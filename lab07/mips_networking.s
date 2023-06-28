# Reads a 4-byte value and reverses the byte order, then prints it

########################################################################
# .TEXT <main>
main:
	# Locals:
	#	- $t0: int network_bytes
	#	- $t1: int computer_bytes
	#	- $t2: int byte_mask
	#	- $t3: temp


	li	$v0, 5		# scanf("%d", &x);
	syscall

	#
	# Your code here!
	move	$t0, $v0
	li		$t1, 0
	li		$t2, 0xFF
	
	AND		$t3, $t0, $t2						# network_bytes & byte_mask
	SLL		$t3, $t3, 24						# (network_bytes & byte_mask)
	OR		$t1, $t1, $t3

	SLL		$t2, $t2, 8
	AND		$t3, $t0, $t2
	SLL		$t3, $t3, 8
	OR		$t1, $t1, $t3

	SLL		$t2, $t2, 8
	AND		$t3, $t0, $t2
	SRA		$t3, $t3, 8
	OR		$t1, $t1, $t3

	SLL		$t2, $t2, 8
	AND		$t3, $t0, $t2
	SRA		$t3, $t3, 24
	OR		$t1, $t1, $t3
	#

	move	$a0, $t1	# printf("%d\n", x);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall

main__end:
	li	$v0, 0		# return 0;
	jr	$ra
