# Reads a line and prints whether it is a palindrome or not

LINE_LEN = 256

########################################################################
# .TEXT <main>
main:
	# Locals:
	#   - $t0: i
	#   - $t1: line[i] or  line[j]
	#   - $t2: k
	#   - $t3: j
	#   - $t4: line[k]

	li	$v0, 4				# syscall 4: print_string
	la	$a0, line_prompt_str		#
	syscall					# printf("Enter a line of input: ");

	li	$v0, 8				# syscall 8: read_string
	la	$a0, line			#
	la	$a1, LINE_LEN			#
	syscall					# fgets(buffer, LINE_LEN, stdin)


	li	$t0, 0				# int = 0;
while1:
	lb	$t1, line($t0)			# line[i]
	beq	$t1, '\0', endwhile1


	addi 	$t0, $t0, 1			# i++
	b 	while1
endwhile1:

	li	$t3, 0				# int j = 0
	addi	$t2, $t0, -2			# int k = i - 2
	
while2:
	bge     $t3, $t2, end_while2

	lb	$t1, line($t3)			# line[j]
	lb	$t4, line($t2)			# line[k]


	bne	$t1, $t4, not_palindrome	# if (line[j] != line[k])			
	
while2__step:
	addi	$t3, $t3, 1			# j++
	addi	$t2, $t2, -1 			# k--
	b  	while2
end_while2:
	b 	palindrome

not_palindrome:
	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_not_palindrome_str	#
	syscall					# printf("not palindrome\n");
	
	b 	end

palindrome:
	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_palindrome_str	#
	syscall					# printf("palindrome\n");

end:
	li	$v0, 0
	jr	$ra				# return 0;


########################################################################
# .DATA
	.data
# String literals
line_prompt_str:
	.asciiz	"Enter a line of input: "
result_not_palindrome_str:
	.asciiz	"not palindrome\n"
result_palindrome_str:
	.asciiz	"palindrome\n"

# Line of input stored here
line:
	.space	LINE_LEN

