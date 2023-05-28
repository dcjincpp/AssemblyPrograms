#Name: David Jin
#Date: April 16, 2023
#Assignment: Program 2: Practice with Conditionals and Loops, Task 1: Return a Letter Grade from User Input
#Goals: Write an Assembly program that will return a letter grade given a Decimal int from the user.
#Objectives:
# -A user menu
# -A main label, a looping label, and exit label
# -A way for the user to continue getting letter grades or choose to exit
# -Invalid input handling (do NOT just print an error message and exit the program; re-prompt the user until a correct input is entered)

#macro to quickly print the wanted strings in .data field
.macro stringPrint(%aString) #macro name and parameters
li $v0, 4 #load code for print string into syscall service
la $a0, %aString #load address of label inputted into parameter %aString into register $a0
syscall #activate loaded syscall service
.end_macro

.data
menu: .asciiz "\n\n~~~~~~~~~~~~~~~MAIN MENU~~~~~~~~~~~~~~~\n(1)Get Letter Grade\n(2)Exit Program\n\nEnter '1' or '2' for your selection: "
score: .asciiz "\n\n------------------------------------------\n\nPlease enter a score as an integer value: "
aPlus: .asciiz "\nThe grade is: A+"
a: .asciiz "\nThe grade is: A"
be: .asciiz "\nThe grade is: B"
c: .asciiz "\nThe grade is: C"
d: .asciiz "\nThe grade is: D"
f: .asciiz "\nThe grade is: F"
new: .asciiz "\n------------------------------------------\n\nWould you like to enter a new score?\n(Y)Yes  (N)N0\n\nEnter 'Y' or 'N' for your selection: "
error: .asciiz "\n///////////////ENTERED NUMBER IS NOT AN AVAILABLE OPTION, TRY AGAIN///////////////"
buffer: .space 3
.text
main:
#Main menu with option 1 to enter a score or option 2 to exit the program, reprompts with error message if input does not equal 1 or 2
looping:
	stringPrint(menu) #macro prints menu label
	li $v0, 5 #load code for read integer into syscall service
	syscall #activate loaded syscall service
	move $t1, $v0 #move user input stored in $v0 from the syscall into register $t1
	beq $t1, 1, enterScore #if the user input in register $t1 equals 1, jump to enterScore label
	beq $t1, 2, exit #if the user input in register $t1 equals 2, jump to exit label
	stringPrint(error) #if the user input stored in register $t1 does not equal 1 or 2, macro prints error label
	j looping #jump to looping label

#Prompts user to enter a score and give them the letter grade as a result
enterScore:
	stringPrint(score) #macro prints score label
	li $v0, 5 #load code for read integer into syscall service
	syscall #activate loaded syscall service
	move $t1, $v0 #move user input stored in $v0 from the syscall into register $t1
	bgt $t1, 100, APlus #if the user input stored in register $t1 is greater than 100, jump to APlus label
	bge $t1, 90, A #if the user input stored in register $t1 is greater than or equal to 90, jump to A label
	bge $t1, 80, B #if the user input stored in register $t1 is greater than or equal to 80, jump to B label
	bge $t1, 70, C #if the user input stored in register $t1 is greater than or equal to 70, jump to C label
	bge $t1, 60, D #if the user input stored in register $t1 is greater than or equal to 60, jump to D label
	bge $t1, 0, F #if the user input stored in register $t1 is greater than or equal to 0, jump to F label
	tlti $t1, 0
	j enterScore #jump to enterScore label
	
#prints the letter grade and jumps to again label
APlus:
	stringPrint(aPlus) #macro prints aPlus label
	j again #jump to again label
A:
	stringPrint(a) #macro prints A label
	j again #jump to again label
B:
	stringPrint(be) #macro prints be label
	j again #jump to again label
C:
	stringPrint(c) #macro prints c label
	j again #jump to again label
D:
	stringPrint(d) #macro prints d label
	j again #jump to again label
F:
	stringPrint(f) #macro prints f label
	
#asks user if they want to enter another grade or not
again:
	stringPrint(new) #macro prints new label
	li $v0, 12 #load code for read char into syscall
	syscall #activate loadded syscall service
	move $t1, $v0 #move user input stored in $v0 from the syscall into register $t1
	li $t2, 'Y' #load character Y into register $t2
	li $t3, 'N' #load character N into register $t3
	beq $t1, $t2, enterScore #if the user input stored in register $t1 equals the character Y stored in register $t2, jump to enterScore label
	beq $t1, $t3, looping #if the user input stored in register $t1 equals the character N stored in register $t3, jump to the looping label
	stringPrint(error) #if the user input stored in register $t1 does not equal the character N or Y, macro prints error label
	j again #jump to again label
	
#exit program
exit:
	li $v0, 10 #load code for exit into syscall
	syscall #activate loaded syscall service

# Trap handler in the standard MIPS32 kernel text segment

   .ktext 0x80000180
   move $k0,$v0   # Save $v0 value
   move $k1,$a0   # Save $a0 value
   la   $a0, error  # address of string to print
   li   $v0, 4    # Print String service
   syscall
   move $v0,$k0   # Restore $v0
   move $a0,$k1   # Restore $a0
   mfc0 $k0,$14   # Coprocessor 0 register $14 has address of trapping instruction
   addi $k0,$k0,4 # Add 4 to point to next instruction
   mtc0 $k0,$14   # Store new address back into $14
   eret           # Error return; set PC to value in $14
   .kdata	
msg:   
   .asciiz "Trap generated"
