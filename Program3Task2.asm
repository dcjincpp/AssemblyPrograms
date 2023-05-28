#Name: David Jin
#Date: April 29, 2023
#Objectives:
# -Takes in program-defined filename

.data
file: .asciiz "practiceFile.txt"
buffer: .space 301

.text
main:
	li $v0, 13 #load open file into syscall
	la $a0, file #load name of file
	li $a1, 0 #read only
	li $a2, 0 #gets ignored
	syscall
	move $t1, $v0 #move opened file into register $t1
	
	li $v0, 14 #load read file into syscall
	move $a0, $t1 #move file into register $a0
	la $a1, buffer #whatever is read from file will be stored in buffer label
	li $a2, 300 #maximum nuber of characters to read is 300
	syscall
	
	li $v0, 4 #load print string into syscall
	la $a0, buffer #load contents read from file into $a0
	syscall
	
	li $v0, 16 #close file
	move $a0, $t1 #load file into register $a0
	syscall
#exit program
exit:
	li $v0, 10
	syscall
