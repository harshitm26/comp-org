.text
.globl main

main:
	li $v0, 4
	la $a0, welcomeMessage
	syscall			#Printing the welcome message

	subu $sp, $sp, 8	#Building the main stack
	sw $ra, 0($sp)
	
	li $v0, 5
	syscall
	move $s0, $v0		#Receiving n and storing in $s0
	
	li $v0, 4
	la $a0, resultMessage
	syscall
	
	li $a0, 1		#1,2,3  correspond to A,B,C; $a0 indicates the rod from the which the disks are to be moved
	li $a1, 3		#$a1 indicates the rod to which the disks are being moved
	move $a2, $s0		#$a2 stores the number of disks being moved
	jal solveHanoi		#Initial call to the recursive function solveHanoi
	
	lw $ra, 0($sp)
	addu $sp, $sp, 8	#Popping out stack
	jr $ra			#Exitting
	
solveHanoi:
	subu $sp, $sp, 16	#Building the stack and storing the caller's saved registers $s0 to $s2
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)		#and the return address $ra

	move $s0, $a0		#Receiving arguments
	move $s1, $a1
	move $s2, $a2	

	li $t0, 0
	beq $s2, $t0, endSolveHanoi
	li $t0, 1
	beq $s2, $t0, trivialCase	#when only one disk is to be moved
	li $t1, 1
	li $t2, 2
	li $t3, 3
	
	beq $s0, $t1, fromA	#$s0=1 => Disks are being moved from A
	beq $s0, $t2, fromB	#$s0=2 => Disks are being moved from B
	j fromC			#Otherwise from C
	
fromA:
	beq $s1, $t2, fromAToB	#$s1=2 => Disks are being moved from A to B
	j fromAToC		#Else from A to C
fromB:
	beq $s1, $t1, fromBToA	#from B to A
	j fromBToC		#Else from B to C
fromC:
	beq $s1, $t1, fromCToA	
	j fromCToB

fromAToB:
	li $a0, 1
	li $a1, 3
	subu $a2, $s2, 1
	jal solveHanoi		#Move n-1 disks from A to C
	
	li $a0, 1
	li $a1, 2
	li $a2, 1
	jal solveHanoi		#Move the lone disk from A to B
	
	li $a0, 3
	li $a1, 2
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from C to B
	j endSolveHanoi
	
fromAToC:
	li $a0, 1
	li $a1, 2
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from A to B
	
	li $a0, 1
	li $a1, 3
	li $a2, 1
	jal solveHanoi		#Move the lone disk from A to C
		
	li $a0, 2
	li $a1, 3
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from B to C
	j endSolveHanoi

fromBToA:
	li $a0, 2
	li $a1, 3
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from B to C
	
	li $a0, 2
	li $a1, 1
	li $a2, 1
	jal solveHanoi		#Move the lone disk from B to A
	
	li $a0, 3
	li $a1, 1
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from C to A
	j endSolveHanoi

fromBToC:
	li $a0, 2
	li $a1, 1
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from B to A
	
	li $a0, 2
	li $a1, 3
	li $a2, 1
	jal solveHanoi		#Move the lone disk from B to C
	
	li $a0, 1
	li $a1, 3
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from A to C
	j endSolveHanoi

fromCToA:
	li $a0, 3
	li $a1, 2
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disk from C to B
	
	li $a0, 3
	li $a1, 1
	li $a2, 1
	jal solveHanoi		#Move the lone disk from C to A
	
	li $a0, 2
	li $a1, 1
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from B to A
	j endSolveHanoi	

fromCToB:
	li $a0, 3
	li $a1, 1
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from C to A
	
	li $a0, 3
	li $a1, 2
	li $a2, 1
	jal solveHanoi		#Move the lone disk from C to B
	
	li $a0, 1
	li $a1, 2
	subu $a2, $s2, 1
	jal solveHanoi		#Move the n-1 disks from A to B
	j endSolveHanoi

trivialCase:			#Base case of moving only one disk
	jal print
	
endSolveHanoi:
	lw $ra, 12($sp)
	lw $s2, 8($sp)
	lw $s1, 4($sp)
	lw $s0, 0($sp)		#Restoring the caller's saved registers
	addu $sp, $sp, 16	#Popping out the stack
	jr $ra
	
print:		
	li $t1, 1	
	li $t2, 2
	li $t3, 3
	li $v0, 4
	
	beq $s0, $t1, caseFromA	#$s0=1 => Disk being moved from A
	beq $s0, $t2, caseFromB
	beq $s0, $t3, caseFromC
	
caseFromA:
	beq $s1, $t2, caseFromAToB	#$s1=2 => Disk being moved from A to B
	j caseFromAToC			#Otherwise from A to C
caseFromB:
	beq $s1, $t1, caseFromBToA
	j caseFromBToC
caseFromC:
	beq $s1, $t1, caseFromCToA
	j caseFromCToB
	
caseFromAToB:
	la $a0, stringFromAToB		#Printing the coresponding strings
	j endPrint
	
caseFromAToC:
	la $a0, stringFromAToC
	j endPrint
	
caseFromBToA:
	la $a0, stringFromBToA
	j endPrint
	
caseFromBToC:
	la $a0, stringFromBToC
	j endPrint
	
caseFromCToA:
	la $a0, stringFromCToA
	j endPrint
	
caseFromCToB:
	la $a0, stringFromCToB
	j endPrint
	
endPrint:
	syscall
	jr $ra
	
.data
stringFromAToB: .asciiz "Move from A to B\n"
stringFromAToC: .asciiz "Move from A to C\n"
stringFromBToA: .asciiz "Move from B to A\n"
stringFromBToC: .asciiz "Move from B to C\n"
stringFromCToA: .asciiz "Move from C to A\n"
stringFromCToB: .asciiz "Move from C to B\n"
welcomeMessage: .asciiz "Enter n: "
resultMessage: .asciiz "The disk movements are as follows:\n"
