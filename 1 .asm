#Name: David Jin
#Date: April 2, 2023
##Assignment: Program 1: Getting Familiar with Assembly
#Goals: Complete 3 tasks
#Objective: Getting familiar with assembly
#Background information: First assembly program homework assignment

.data
getNum1: .ascii "\nEnter a number: "
getNum2: .ascii "\nEnter another number: "
sum: .ascii "\nSum of the two numbers: "
difference: .ascii "\nDifference of the two numbers: "
product: .ascii "\nProduct of the two numbers: "
quotient: .ascii "\nQuotient of the two numbers: "
same: .ascii "\nUser inputs are the same"
notSame: .ascii "\nUser inputs are not the same"

.text

main:
#Task 1
	#Print out getNum1
	li $v0, 4
	la $a0, getNum1
	syscall

	#Get user input int
	li $v0, 5
	syscall
	#Move user input from $v0 to %$s0
	move $s0, $v0
	
	#Print out getNum2
	li $v0, 4
	la $a0, getNum2
	syscall

	#Get user input int
	li $v0, 5
	syscall
	#Move user input from $v0 to %$s1
	move $s1, $v0
	
	#Print first int inputted by user
	li $v0, 1
	move $a0, $s0
	syscall
	
	#Printing second int inputted by user
	li $v0, 1
	move $a0, $s1
	syscall
	
#Task 2
	#Solve and print out sum
	li $v0, 4
	la $a0, sum
	syscall
	
	add $a0, $s0, $s1
	li $v0, 1
	syscall
	
	#Solve and print out difference
	li $v0, 4
	la $a0, difference
	syscall
	
	sub $a0, $s0, $s1
	li $v0, 1
	syscall
	
	#Solve and print out product
	li $v0, 4
	la $a0, product
	syscall
	
	mul $a0, $s0, $s1
	li $v0, 1
	syscall
	
	#Solve and print out quotient
	li $v0, 4
	la $a0, quotient
	syscall
	
	div $a0, $s0, $s1
	li $v0, 1
	syscall
	
#Task 3
	#Check if equal, if equal, jump to equal
	beq $s0, $s1, equal
	#If not equal, print out notSame
	li $v0, 4
	la $a0, notSame
	syscall
	#Go to label, exit
	j exit
	
	
	#If equal, print out same
equal:
	li $v0, 4
	la $a0, same
	syscall

exit:	
	#Exit program
	li $v0, 10
	syscall