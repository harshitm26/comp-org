.text
.globl main

main:
	li $v0, 4
	la $a0, welcomeMessage
	syscall			#Printing the welcome message

	li $s0, 0
	li $v0, 5
	syscall			#Receiving m
	move $s1, $v0		#and storing it in $s1
	bltz $s1, mNegative

	li $v0, 5
	syscall			#Receiving n
	move $s2, $v0		#and storing it in $s2
	bltz $s2, nNegative
	
	subu $sp, $sp, 8	#Building main stack
	sw $ra, 0($sp)		#Storing the return address
	
	move $a0, $s1
	move $a1, $s2
	jal recurse		#Initial call to the recursive function recurse

	move $a0, $v0
	li $v0, 1
	syscall			#Printing the return value of recurse

	li $v0, 4
	la $a0, newline
	syscall
	
	move $a0, $s0
	li $v0, 1
	syscall			#Printing the number of calls to recurse

	lw $ra, 0($sp)
	addu $sp, $sp, 8	#Popping the stack
	jr $ra			#Exitting
mNegative:
	li $v0, 4
	la $a0, stringMNegative
	syscall			#Printing error if m is negative
	jr $ra			#Exitting
nNegative:
	li $v0, 4
	la $a0, stringNNegative
	syscall			#Printing error if n is negative
	jr $ra			#Exitting
recurse:
	subu $sp, $sp, 16	#Building the stack
	sw $s1, 0($sp)		#Storing the caller's saved registers
	sw $s2, 4($sp)
	sw $ra, 8($sp)		#And the return address

	move $s1, $a0		#Receiving the arguments
	move $s2, $a1
	addu $s0, $s0, 1	#Adding one to the number of calls to recurse

	beqz $s1, mZero		#Base case of m=0
	beqz $s2, nZero		#Case of n=0
	
	move $a0, $s1
	subu $a1, $s2, 1
	jal recurse		#Getting A(m,n-1)

	move $a1, $v0
	subu $a0, $s1, 1
	jal recurse		#Getting A(m-1, A(m,n-1)
	j endRecurse	


mZero:
	addu $v0, $s2, 1	#Base case of m=0, returning n+1
	j endRecurse

nZero:
	li $a1, 1
	subu $a0, $s1, 1	#Case of n=0, returning A(m-1,1)
	jal recurse
	
endRecurse:
	lw $ra, 8($sp)
	lw $s2, 4($sp)
	lw $s1, 0($sp)		#Restoring caller-saved registers
	addu $sp, $sp, 16	#Popping out stack
	jr $ra			#Returning to the caller
	
.data
	welcomeMessage: .asciiz "Enter m and n:\n"
	newline: .asciiz "\n"
	stringMNegative: .asciiz "Error: m is negative\n"
	stringNNegative: .asciiz "Error: n is negative\n"
