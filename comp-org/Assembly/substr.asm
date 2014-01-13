.text
.globl main

main:
	li $v0, 4
	la $a0, welcomeMessageA
	syscall				#Printing welcome message to enter string A

	la $a0, stringA
	li $a1, 256
	li $v0, 8
	syscall				#Receiving string A
	
	li $v0, 4
	la $a0, welcomeMessageB
	syscall				#Printing welcome message to enter string B

	la $a0, stringB
	li $a1, 256
	li $v0, 8
	syscall				#Receiving string B
	
	la $s0, stringA			#$s0 is initialised with the starting address of string A
masterLoop:
	la $t0, stringB
	lb $t1, 0($s0)			#Pick next character of A
	beq $t1, 10, checkCompleted	#If this is the end of A, we are done
	lb $t2, 0($t0)			#Pick first character of B
	beq $t1, $t2, substringCheck	#Check for probable substring occurence, if the character of A matches the first character of B
resume:
	addu $s0, $s0, 1		#Otherwise move to the next character
	b masterLoop

checkCompleted:
	li $v0, 4
	la $a0, resultMessage		#Printing result message
	syscall

	li $v0, 4
	la $a0, stringA
	syscall				#Printing the filtered string A
	jr $ra				#Exitting

substringCheck:
	move $t3, $s0
substringCheckLoop:
	addu $t3, $t3, 1		#$t3 points to the current position in A being checked
	addu $t0, $t0, 1		#$t0 points to the current position in B being checked
	lb $t1, 0($t3)			#Load the current character of A
	lb $t2, 0($t0)			#Load the current character of B
	beq $t2, 10, removeSubstring	#If we reach end of B, then B does occur in A at position $s0; remove it
	beq $t1, 10, resume		#If we reach end of A, we're done
	bne $t1, $t2, resume		#If there is a mismatch on the way, then B cannot occur in this case
	b substringCheckLoop

removeSubstring:
	move $t3, $s0
	la $t0, stringB
	lb $t4, 0($t0)
lengthLoop:				#Finding the position in A just after the occurence of B
	beq $t4, 10, endLengthLoop	#If we reach the end of B, the position has been found
	addu $t3, $t3, 1
	addu $t0, $t0, 1
	lb $t4, 0($t0)
	b lengthLoop
endLengthLoop:
	move $t0, $s0
	lb $t4, 0($t3)
substringRemover:
	beq $t4, 10, endSubstringRemover#Do this until all B-characters have been overwritten by the A-characters after them
	sb $t4, 0($t0)			#Copy the character just after the occurence of B, from $s0
	addu $t0, $t0, 1
	addu $t3, $t3, 1
	lb $t4, 0($t3)
	b substringRemover
endSubstringRemover:
	li $t2, 0
	sb $t2, 0($t0)			#Null-terminate after the last character of A
	b masterLoop
	
.data
welcomeMessageA: .asciiz "\nEnter string A: \n"
welcomeMessageB: .asciiz "\nEnter string B: \n"
resultMessage: .asciiz "\nThe filtered substring is: \n"
stringA: .space 256
stringB: .space 256
