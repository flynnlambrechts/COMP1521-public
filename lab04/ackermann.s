########################################################################
# .DATA
# Here are some handy strings for use in your code.
	.data
prompt_m_str:	.asciiz	"Enter m: "
prompt_n_str:	.asciiz	"Enter n: "
result_str_1:	.asciiz	"Ackermann("
result_str_2:	.asciiz	", "
result_str_3:	.asciiz	") = "

########################################################################
# .TEXT <main>
	.text
main:

	# Args: void
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - $s0: m
	#   - $s1: n
	#   - $t0: f
	#
	# Structure:
	#   - main
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

main__prologue:

	# TODO: set up your stack frame
	begin
	push 	$ra
	push	$s0
	push	$s1

main__body:
	la	$a0, prompt_m_str			# printf("Enter m: ");
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall
	move	$s0, $v0				# scanf("%d", &m);

	la	$a0, prompt_n_str			# printf("Enter n: ");
	li	$v0, 4
	syscall

	li	$v0, 5
	syscall
	move	$s1, $v0				# scanf("%d", &n);

	move	$a0, $s0				# args = (m,
	move	$a1, $s1				#	  n)
	jal	ackermann				# ackermann(m, n);
	move	$t0, $v0				# f = ^

	la	$a0, result_str_1			# printf("Ackermann(");
	li	$v0, 4
	syscall

	move	$a0, $s0				# printf("%d", m)				
	li	$v0, 1
	syscall

	la	$a0, result_str_2			# printf(", ");
	li	$v0, 4
	syscall

	move	$a0, $s1				# printf("%d", n)				
	li	$v0, 1
	syscall

	la	$a0, result_str_3			# printf(") = ");
	li	$v0, 4
	syscall

	move	$a0, $t0				# printf("%d", f)				
	li	$v0, 1
	syscall

	li	$v0, 11					# syscall 11: print_char
	li	$a0, '\n'				# 
	syscall						# printf("%c", '\n');


main__epilogue:

	# TODO: clean up your stack frame
	pop	$s1
	pop	$s0
	pop	$ra
	end
	li	$v0, 0
	jr	$ra			# return 0;

########################################################################
# .TEXT <ackermann>
	.text
ackermann:

	# Args:
	#   - $a0: int m
	#   - $a1: int n
	# Returns: int
	#
	# Frame:	[]
	# Uses: 	[]
	# Clobbers:	[]
	#
	# Locals:
	# Locals:
	#   - $s0: m
	#   - $s1: n
	#
	# Structure:
	#   - ackermann
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

ackermann__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	# TODO: set up your stack frame

ackermann__body:
	move	$s0, $a0
	move	$s1, $a1
	# TODO: add your function body here
	beq	$s0, 0, case_1
	beq	$s1, 0, case_2
	b 	else_case
case_1:
	addi	$v0, $s1, 1
	b ackermann__epilogue
case_2:
	addi	$a0, $s0, -1code 
	li	$a1, 1
	jal ackermann
	b ackermann__epilogue
else_case:
	move	$a0, $s0
	addi	$a1, $s1, -1
	jal 	ackermann

	move 	$a1, $v0
	addi	$a0, $s0, -1
	jal 	ackermann

ackermann__epilogue:

	# TODO: clean up your stack frame
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra
