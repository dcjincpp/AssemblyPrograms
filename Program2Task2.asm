#Name: David Jin
#Date: April 16, 2023
#Assignment: Program 2: Practice with Conditionals and Loops, Task 2: Advanced Math: x to the power of y
#Goals: Write a program in Assembly that takes in two ints from a user. One int will be 'x' and the other will be 'y'. Make sure that user will know which value is 'x' and 'y'. Find the result of 'x' to the power of 'y'. Output the result to the user.
#Objectives:
# -A main label, a looping label, and an exit label
# -A loop counter

#macro to quickly print the wanted strings in .data field
.macro stringPrint(%aString) #macro name and parameters
li $v0, 4 #load code for print string into syscall service
la $a0, %aString #load address of label inputted into parameter %aString into register $a0
syscall #activate loaded syscall service
.end_macro

.data
info: .asciiz "This program asks the user to input a value for 'x' and 'y'.\nThen, it finds the value of x to the power of y.\nFor example, 2 to the power 3 is 8.\n"
x: .asciiz "\n\nEnter a number for 'x': "
y: .asciiz "\nEnter a number for 'y': "
result: .asciiz "\n'x' to the power 'y' is: "
oneOver: .asciiz "1/"

.text
main:

	stringPrint(info) #macro prints info label
	stringPrint(x) #macro prints x label
	li $v0, 5 #load code for read integer into syscall service
	syscall #activate loaded syscall service
	move $t1, $v0 #move user input stored in $v0 from the syscall into register $t1
	move $t3, $v0 #move user input stored in $v0 from the syscall into register $t3
	
	stringPrint(y) #macro prints y label
	li $v0, 5 #load code for read integer into syscall service
	syscall #activate loaded syscall service
	move $t2, $v0 #move user input stored in $v0 from the syscall into register $t2
	
	move $s1, $zero #initialize loop counter to register $s1 by setting its value to 0
	
	beqz $t2, zero #if $t2 is equal to zero, jump to label zero
	bltz $t2, negative #if $t2 is less than 0, jump to label negative
	
#y is not 0 or negative scenario
loop:
	addi $s1, $s1, 1 #add 1 to $s1 and store the result in register $s1
	beq $s1, $t2, done #if $s1 is equal to register $t2, jump to label done
	mul $t3, $t3, $t1 #multiply $t3 by $t1 and store the result in register $t3
	j loop #jump to loop label
	
#y = 0 scenario
zero:
	stringPrint(result) #macro prints result label
	li $v0, 1 #load code for print integer into syscall service
	li $a0, 1 #load the value 1 into register $a0
	syscall #activate loaded syscall service
	j exit #jump to exit label

#y is a negative scenario
negative:
	subi $s1, $s1, 1 #subtract 1 from $s1 and store the result in $s1
	beq $s1, $t2, negativeDone #if $s1 is equal to $t2, jump to negativeDone label
	mul $t3, $t3, $t1 #multiply $t3 by $t1 and store the result in $t3
	j negative #jump to negative label

#result of y is a negative scenario
negativeDone:
	stringPrint(result) #macro prints result label
	stringPrint(oneOver) #macro prints oneOver label
	li $v0, 1 #load code for print integer into syscall service
	move $a0, $t3 #move value stored in $t3 into register $a0
	syscall #activate loaded syscall service
	j exit #jump to exit label

#result of y is not 0 or negative scenario
done:
	stringPrint(result) #macro prints result label
	li $v0, 1 #load code for print integer into syscall service
	move $a0, $t3 #move value stored in $t3 into register $a0
	syscall #activate loaded syscall service

#exit program
exit:
	li $v0, 10 #load code for exit into syscall
	syscall #activate loaded syscall service
	