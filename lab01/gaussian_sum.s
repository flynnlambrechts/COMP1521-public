# A simple MIPS program that calculates the Gaussian sum between two numbers

# int main(void)
# {
#   int number1, number2;
#
#   printf("Enter first number: ");
#   scanf("%d", &number1);
#
#   printf("Enter second number: ");
#   scanf("%d", &number2);
#
#   int gaussian_sum = ((number2 - number1 + 1) * (number1 + number2)) / 2;
#
#   printf("The sum of all numbers between %d and %d (inclusive) is: %d\n", number1, number2, gaussian_sum);
#
#   return 0;
# }

main:
	# printf("Enter first number: ");
  	li $v0, 4
	la $a0, prompt1
	syscall

	# scanf("%d", &number1);
	li $v0, 5
	syscall
	move $t0, $v0

	# printf("Enter second number: ");
	li $v0, 4
	la $a0, prompt2
	syscall

	# scanf("%d", &number2);
	li $v0, 5
	syscall
	move $t1, $v0

	# int gaussian_sum = ((number2 - number1 + 1) * (number1 + number2)) / 2;
	# number2 - number1
	subu $t3, $t1, $t0	
	#number2 - number1 + 1
	addiu $t4, $t3, 1
	#number2 + number1
	addu $t5, $t1, $t0
	# (number2 - number1 + 1) * (number1 + number2)
	mul $t7, $t5, $t4
	# ((number2 - number1 + 1) * (number1 + number2)) / 2
	li $t8, 2
	div $t9, $t7, $t8

	li $v0, 4
	la $a0, answer1
	syscall

	li $v0, 1
	move $a0, $t0
	syscall

	li $v0, 4
	la $a0, answer2
	syscall

	li $v0, 1
	move $a0, $t1
	syscall

	li $v0, 4
	la $a0, answer3
	syscall

	# print(gaussian_sum)
	li $v0, 1
	move $a0, $t9
	syscall

	li $v0, 11
	la $a0, '\n'
	syscall


  	li   $v0, 0
  	jr   $ra     # return
  


.data
	prompt1: .asciiz "Enter first number: "
	prompt2: .asciiz "Enter second number: "

	answer1: .asciiz "The sum of all numbers between "
	answer2: .asciiz " and "
	answer3: .asciiz " (inclusive) is: "
