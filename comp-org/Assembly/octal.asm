.text
.globl main
main:
	li $v0, 4
	la $a0, welcomeMessage
	syscall				#Printing the welcome message

	la $a0, string
	li $a1, 256
	li $v0, 8
	syscall				#Receiving the octal string

	lb $t0, 0($a0)
	beq $t0, 10, notOctal		#trivial case of empty string

octalChecker:
	lb $t0, 0($a0)			#loading the character in $t0
	beq $t0, 10, isOctal		#The string is octal if we reach its end
	blt $t0, 0x30, notOctal		#ASCII value is less than that of '0'
	bgt $t0, 0x37, notOctal		#ASCII value is more than that of '7'
	addu $a0, $a0, 1		#Check the next character/byte
	b octalChecker

isOctal:
	la $a0, 1
	li $v0, 1
	syscall				#Return 1
	jr $ra
	
notOctal:
	la $a0, 0
	li $v0, 1
	syscall				#Return 0
	jr $ra

.data
string: .space 1024
welcomeMessage: .asciiz "Enter the string: \n"
