#Name: David Jin
#Date: March 13, 2023
#Objective: Working with memory

.data
string: .ascii "this is a string.\n"
location: .ascii "The memory location for the string is: "

.text
main:
#print String
li $v0, 4
la $a0, string
syscall

#print location string
li $v0, 4
la $a0, location
syscall

#printing the memory location for "string"
la $s1, string
li $v0, 1
move $a0, $s1
syscall

#write integer 32 into memory, 32 words from "string"
li $s2, 32
#32 * 4(bits for words) = 128
sw $s2, 128($s1)

#exit program
li $v0, 10
syscall
