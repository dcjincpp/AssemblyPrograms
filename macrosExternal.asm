.macro getArr(%jinx)
la $s0, %jinx
lw $s3, 8($s0)
addi $s4, $s3, 1
li $v0, 1
move $a0, $s4
syscall
.end_macro

.macro getInput
li $v0, 8
la $a0, userInput
li $a1, 63
syscall
move $t1, $a0
.end_macro

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
