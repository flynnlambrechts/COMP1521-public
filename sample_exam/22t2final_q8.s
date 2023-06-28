# COMP1521 22T2 ... final exam, question 8

	.data

# char default_char = ' ';
default_char:	.byte ' '


	.text
# void move_disks(char size, char *target, char *peg1, char *peg2) {
move_disks:
	# $s0 - peg_max
	# $s1 - size
	# $s2 - source
	# $s3 - other
	# $s4 - target
	# $t0 - i
	# $t1 - peg1
	# $t2 - peg2
	# $t3 - peg1[i]
	# $t4 - *peg_max
	# $t5 - peg2[i]
prologue:
	begin
	push	$ra
	push 	$s0
	push	$s1
	push	$s2
	push	$s3
	push	$s4
body:
	la		$s0, default_char	# peg_max = &default char
	move	$s2, $zero			# source = NULL
	move	$s3, $zero			# other = NULL

	move	$s1, $a0			# size 
	move	$s4, $a1			# target
	move	$t1, $a2			# peg1
	move	$t2, $a3			# peg2
	
	la	$t0, 0					# int i = 0
for:
	add	$t3, $t0, $t1			# peg1 + i
	lb	$t3, ($t3)				# peg1[i]
	beq	$t3, '\0', for_end

	lb	$t4, ($s0)				# *peg_max


if1:
	ble		$t3, $t4, endif1
	bgt		$t3, $s1, endif1

	add		$s0, $t1, $t0
	move	$s2, $t1
	move	$s3, $t2
endif1:
	add		$t5, $t0, $t2			# peg2 + i
	lb		$t5, ($t5)				# peg2[i]

	lb		$t4, ($s0)				# *peg_max
if2:
	ble		$t5, $t4, endif2
	bgt		$t5, $s1, endif2

	add		$s0, $t2, $t0
	move	$s2, $t2
	move	$s3, $t1
endif2:

for_step:
	addi	$t0, $t0, 1		# i++
	b 	for
for_end:
	lb	$t4, ($s0)	# *peg_max
	beq	$t4, ' ', epiloque


	sub		$a0, $s1, 1
#	li		$v0, 1
#	syscall
	move	$a1, $s3	# other
	move	$a2, $s2	# source
	move	$a3, $s4	# target
	jal 	move_disks



	move	$a0, $s4
	jal 	find_lowest_target
	move	$a1, $v0
	move	$a0, $s0
	jal 	swap


while:


	lb		$t4, ($s0)	# *peg_max
	addi	$t0, $s0, 1	# peg_max + 1
	lb		$t1, ($t0)	# *(peg_max + 1)
	beq		$t1, $t4, while_end

	move	$a0, $s0
	move	$a1, $t0
	jal 	swap
	addi	$s0, $s0, 1 
	b 		while
while_end:



	jal	print_towers

	sub		$a0, $s1, 1	# size - 1
	move	$a1, $s4	# target
	move	$a2, $s2	# source
	move	$a3, $s3	# other
	jal		move_disks 

epiloque:
	pop		$s4
	pop		$s3
	pop		$s2
	pop		$s1
	pop 	$s0
	pop		$ra
	end
	jr	$ra

	.text
# char *find_lowest_target(char *target) {
find_lowest_target:
	# TODO: Complete this function
	begin
	push	$ra
	lb	$t0, ($a0)
	bne	$t0, ' ', find_lowest_target_else
find_lowest_target_if:
	move	$v0, $a0
	b 	find_lowest_target_if_end
find_lowest_target_else:
	addi	$a0, $a0, 1
	jal	find_lowest_target
find_lowest_target_if_end:
	pop 	$ra
	end
	jr	$ra
