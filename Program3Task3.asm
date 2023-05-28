#Name: David Jin
#Date: April 29, 2023
#Objectives:
# -Takes practiceFile.txt and appends to it
# -Answer the following prompt with your file append: "What have you enjoyed most about the class so far?"
# -bonus: file name and content is taken from user input (+1 point)

.macro printString(%string)
li $v0, 4
la $a0, %string
syscall
.end_macro

.data
fileName: .asciiz "practiceFile.txt"
append: .asciiz "I like the programming assignments"

.text
main:

	#open file in fileName
	li $v0, 13 #load open file into syscall
	la $a0, fileName
	li $a1, 9 #flag to write and append existing file
	li $a2, 0 #gets ignored
	syscall
	move $t0, $v0 #move file obtained from syscall to $t0
	
	#append to file
	li $v0, 15 #load write to file into syscall
	move $a0, $t0 #move file stored in $t0 to $a0
	la $a1, append #load appending to be appended to file
	li $a2, 80 #maximum amount of characters to write
	syscall
	
	#close file
	li $v0, 16 #load close file into syscall
	move $a0, $t0 #move file from $t0 to $a0
	syscall
	
#exit program
exit:
	li $v0, 10
	syscall