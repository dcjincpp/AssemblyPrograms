#Name: CS 2640.02
#Date: March 22, 2023
#Objectives: 
# - get two numbers (ints) from a user
# - display a menu to a user
# - get user menu selection
# - complete arithmetic operation
# - display the result to the user
# Include objectives from Practice Input and Output II
# - error handling
# - reprompt user with menu for new input/invalid input

.data
num1: .asciiz "Please enter an int: "
num2: .asciiz "\nPlease enter another int: "
menu: .asciiz "\nOperation Menu \n1) addition\n2) subtraction\n3) multiplication\n4) division"
instruction: .asciiz "\nPlease enter an int between 1 and 4 to select your operation: "
invalidInput: .asciiz "\nInvalid input.\n"
newNums: .asciiz "\nDo you want to input new numbers? (1 for yes, 2 for no): "
# show operation symbols for user display
addSym: .asciiz " + "
subSym: .asciiz " - "
mulSym: .asciiz " x "
divSym: .asciiz " \ "
eqlSym: .asciiz " = "

.text
main: 
numbers: 
	#print out user num1 prompt
	li $v0, 4
	la $a0, num1
	syscall
	
	#get user num1
	li $v0, 5
	syscall
	move $t0, $v0	#user int1 stored in $t0

	#print out user num2 prompt
	li $v0, 4
	la $a0, num2
	syscall
	
	#get user num2
	li $v0, 5
	syscall
	move $t1, $v0	#user int2 stored in $t1	
	
	j MENU
	
MENU: 
	#print out menu string
	li $v0, 4
	la $a0, menu
	syscall
	
	#get user input
	li $v0, 4
	la $a0, instruction
	syscall
	
	li $v0, 5
	syscall
	move $t7, $v0	#user menu selection stored in $t7
	
	#conditional statement based off user selection
	# - check user input (if valid or invalid)
	# - if valid -> go to selected operation
	# - if invalid -> reprompt to select menu item
	
	#if $t7 less than 4
	# -> new label: check if value is less than 0, and between 0 and 4 
	#			invalid and valid branch
	
	blt $t7, 4, valid	#branch if less than 4

valid: 
	#check if less than 0 (if less than 0 go to invalid)
	blt $t7, 0, invalid
	#check each good input (1, 2, 3, and 4) and each will branch to operation
	beq $t7, 1, ADD

ADD: 
	#display the operation to the user
	#display num1 stored in $t0
	li $v0, 1
	move $a0, $t0
	syscall
	
	#display the operation symbol
	li $v0, 4
	la $a0, addSym
	syscall
	
	#display num2 stored in $t1
	li $v0, 1
	move $a0, $t1
	syscall
	
	#complete the operation (store result in $t2)
	add $t2, $t0, $t1
	
	#display result symbol
	li $v0, 4
	la $a0, eqlSym
	syscall
	
	#display result stored in $t2 to user
	li $v0, 1
	move $a0, $t2
	syscall
	
	#if new numbers, prompt (1 for yes, 2 for no)
	li $v0, 4
	la $a0, newNums
	syscall
	
	li $v0, 5
	syscall
	move $t4, $v0
	
	#compare user input if 1 or 2 for new numbers
	beq $t4, 1, numbers
	beq $t4, 2, MENU
	
	j exit
	
	j MENU

invalid: 
	#$t7 less than 0, $t7 is invalid input
	#print the menu and check user input 
	li $v0, 4
	la $a0, invalidInput
	syscall
	
	j MENU
	
exit: 
	li $v0, 10
	syscall	
	
