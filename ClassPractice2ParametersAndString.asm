#Name: David jin
#Date: April  17, 2023
#Objectives:
#Task 1
# -Macros can take in multiple parameters
# -Takes in two parameters
# -An int and a string
# -Doubles the int
# -Calls another macro to print the string
# -Define the int and string in the program
#Task 2
# -Using the 'aString' macro
# -Print string 3 times
# -Use loop

.macro aString(%strings)
li $v0, 4
.data
inputString: .asciiz %strings
.text
la $a0, inputString
syscall
.end_macro

.macro parameters(%int, %string)
#double the int
la $t1, %int
add $t1, $t1, $t1
li $v0, 1
move $a0, $t1
syscall
#call another macro to print the word/string
aString(%string)
.end_macro

.data
#data

.text
main:
	move $t1, $zero
loop:
	aString("Hello\n")
	addi $t1, $t1, 1
	beq $t1, 3, task2
	j loop
	
task2:
	parameters(7, " Goodbye")
		
exit:
	li $v0, 10
	syscall
