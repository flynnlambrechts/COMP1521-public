# YOUR-NAME-HERE, DD/MM/YYYY

########################################################################
# .DATA
# Here are some handy strings for use in your code.

	.data
prompt_str:
	.asciiz "Enter a random seed: "
result_str:
	.asciiz "The random result is: "

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
	#   - $a0: random_seed
	#   - $s0: value
	#
	# Structure:
	#   - main
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

main__prologue:
	begin
	# TODO: add code to set up your stack frame here 
	push	$ra
	push	$s0

main__body:
	# TODO: complete your function body here
	li	$v0, 4					# syscall 4: print_string
	la	$a0, prompt_str				# printf("Enter a random seed: ");
	syscall						

	li	$v0, 5
	syscall
	move	$a0, $v0				# scanf("%d", &random_seed);

	jal 	seed_rand				# seed_rand(random_seed);

	li	$a0, 100				# args = (100)
	jal	rand					# rand(100)
	move	$s0, $v0				# int value = rand(100);


	move	$a0, $s0				# args = (value)
	jal	add_rand				# add_rand(value);
	move	$s0, $v0				# value = ^

	move	$a0, $s0				# args = value
	jal	sub_rand				# sub_rand(value);
	move	$s0, $v0				# value = ^

	move	$a0, $s0				# args = value
	jal	seq_rand				# seq_rand(value);
	move	$s0, $v0				# value = ^

	li	$v0, 4					# syscall 4: print_string
	la	$a0, result_str				# printf("The random result is: %d\n", value);
	syscall			

	move	$a0, $s0
	li	$v0, 1
	syscall						# printf("%d", value)

	li	$v0, 11				# syscall 11: print_char
	li	$a0, '\n'				# 
	syscall						# printf("%c", '\n');



main__epilogue:
	# TODO: add code to clean up stack frame here
	pop	$s0
	pop 	$ra
	end

	li	$v0, 0
	jr	$ra				# return 0;

########################################################################
# .TEXT <add_rand>
	.text
add_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - $s0: value
	#
	# Structure:
	#   - add_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

add_rand__prologue:
	begin
	push	$ra
	push	$s0
	# TODO: add code to set up your stack frame here

add_rand__body:
	move	$s0, $a0

	li	$a0, 0xFFFF
	jal	rand

	add	$v0, $s0, $v0
	# TODO: complete your function body here

add_rand__epilogue:
	
	# TODO: add code to clean up stack frame here
	pop	$s0
	pop	$ra
	end

	jr	$ra


########################################################################
# .TEXT <sub_rand>
	.text
sub_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - sub_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

sub_rand__prologue:
	begin
	push	$ra
	push	$s0
	# TODO: add code to set up your stack frame here

sub_rand__body:
	# args = value
	jal	rand

	sub	$v0, $s0, $v0
	# TODO: complete your function body here

sub_rand__epilogue:
	
	# TODO: add code to clean up stack frame here
	pop	$s0
	pop	$ra
	end

	jr	$ra

########################################################################
# .TEXT <seq_rand>
	.text
seq_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - $s0: value
	#   - $s1: limit
	#   - $s2: i
	

	#
	# Structure:
	#   - seq_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

seq_rand__prologue:
	begin
	push	$ra

	# TODO: add code to set up your stack frame here

seq_rand__body:
	# TODO: complete your function body here
	move 	$s0, $a0 				# save value
	
	li	$a0, 100
	jal 	rand
	move	$s1, $v0				#int limit = rand(100);


	move	$s2, $zero				# int i = 0
for_i_loop:
	bge	$s2, $s1, for_i_loop_end

	move	$a0, $s0				# args = (value)
	jal	add_rand
	move	$s0, $v0				# value = add_rand(value);

for_i_loop_step:
	addi	$s2, 1
	b for_i_loop
for_i_loop_end:

	move	$v0, $s0				# return = value
seq_rand__epilogue:
	
	# TODO: add code to clean up stack frame here

	pop	$ra
	end
	
	jr	$ra



##
## The following are two utility functions, provided for you.
##
## You don't need to modify any of the following,
## but you may find it useful to read through.
## You'll be calling these functions from your code.
##

OFFLINE_SEED = 0x7F10FB5B

########################################################################
# .DATA
	.data
	
# int random_seed;
	.align 2
random_seed:
	.space 4


########################################################################
# .TEXT <seed_rand>
	.text
seed_rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int seed
	# Returns: void
	#
	# Frame:	[]
	# Uses:		[$a0, $t0]
	# Clobbers:	[$t0]
	#
	# Locals:
	#   - $t0: offline_seed
	#
	# Structure:
	#   - seed_rand

	li	$t0, OFFLINE_SEED		# const unsigned int offline_seed = OFFLINE_SEED;
	xor	$t0, $a0			# random_seed = seed ^ offline_seed;
	sw	$t0, random_seed

	jr	$ra				# return;

########################################################################
# .TEXT <rand>
	.text
rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int n
	# Returns:
	#   - $v0: int
	#
	# Frame:    []
	# Uses:     [$a0, $v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#   - $t0: int rand
	#
	# Structure:
	#   - rand

	lw	$t0, random_seed 		# unsigned int rand = random_seed;
	multu	$t0, 0x5bd1e995  		# rand *= 0x5bd1e995;
	mflo	$t0
	addiu	$t0, 12345       		# rand += 12345;
	sw	$t0, random_seed 		# random_seed = rand;

	remu	$v0, $t0, $a0    
	jr	$ra              		# return rand % n;
