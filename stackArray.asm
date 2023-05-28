#Name: David Jin
#Date: May 1, 2023
#Objectives:
# -reverse the elements of the given array 5, 4, 3, 2, 1

.data
array: .word 5, 4, 3, 2, 1
arrString: .asciiz "The array is: "
original: .asciiz "Array elements are: "
output: .asciiz "\nNew array is: "
comma: .asciiz ", "
.text
main:
	#load address to register $t0
	la $t0, array
	#initialize 2 loop counters
	move $t7, $zero
	move $t6, $zero
	
	li $v0, 4
	la $a0, original
	syscall
loop:
	lw $t1, 0($t0) #load element of array into $t1
	sw $t1, 0($sp) #store element in $t1 into address at stack pointer
	li $v0, 1 #load print int into syscall
	move $a0, $t1 #move element in $t1 into $a0
	syscall
	addi $t7, $t7, 1 #add 1 to loop counter
	addi $t0, $t0, 4 #add 4 to address of array
	subi $sp, $sp, 4 #add 4 to address of stack pointer
	beq $t7, 5, done #if loop counter equals 5, jump to pop label
	#print comma
	li $v0, 4
	la $a0, comma
	syscall
	j loop
	
done:
	li $v0, 4
	la $a0, output
	syscall
pop:
	#pop the element
	lw $t1, 4($sp)
	#print popped element
	li $v0, 1
	move $a0, $t1
	syscall
	#increment loop by 1
	addi $t6, $t6, 1
	#increment address by 4
	addi $sp, $sp, 4
	#check if counter is equal to 5
	beq $t6, 5, exit
	#print comma
	li $v0, 4
	la $a0, comma
	syscall
	j pop
#exit program
exit:
	li $v0, 10
	syscall
