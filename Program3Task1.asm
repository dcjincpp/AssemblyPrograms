#Name: David Jin
#Date: April 29, 2023
#Objectives:
# -A main, looping, and exit label
# -A loop counter
# -A separate case for grades above 100(i.e. prints out "A with Extra Credit")
# -Your name prined out after all the grades are read (and bfore the program exits)

.macro printLabel(%string)
li $v0, 4
la $a0, %string
syscall
.end_macro

.macro printGrade(%int)
li $v0, 11
li $a0, %int
syscall
.end_macro

.data
scores: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82
name: .asciiz "\nDavid Jin"
grade: .asciiz "\nThe grade for "
is: .asciiz " is: "
extraCredit: .asciiz "A with Extra Credit"
.text
main:
	move $t7, $zero #initialize loop counter
	la $t0, scores #load scores array into $t0
	
loop:
	lw $t1, 0($t0) #load word of address into $t1
	printLabel(grade) #print grade label
	li $v0, 1 #load print int syscall
	move $a0, $t1 #move element in $t1 into $a0
	syscall
	printLabel(is) #print is label
	#check to see what letter grade goes with the score
	bgt $t1, 100, Extra
	bgt $t1, 89, A
	bgt $t1, 79, B
	bgt $t1, 69, C
	bgt $t1, 59, D
	bge $t1, 0, F
got:
	addi $t0, $t0, 4 #add 4 to address of scores array
	addi $t7, $t7, 1 #add 1 to loop counter
	beq $t7, 10, next #if loop counter equals 9, go to next label
	j loop
	
#print the grade and jump back into loop through got label
Extra:
	printLabel(extraCredit)
	j got
	
A:
	printGrade(65)
	j got

B:
	printGrade(66)
	j got
	
C:
	printGrade(67)
	j got
	
D:
	printGrade(68)
	j got

F:
	printGrade(70)
	j got
	
next:
	printLabel(name) #print name label

#Exit program
exit:
	li $v0, 10
	syscall