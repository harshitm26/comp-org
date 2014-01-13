.text
.globl main
main:
	li $v0, 4			#Printing Welcome message
	la $a0, welcomeMessage
	syscall

	li $v0, 5			# Receiving n
	syscall
	
	move $s0, $v0			#n is stored in $s0

	li $v0, 4
	la $a0, resultMessage
	syscall				#Printing the result message

	beqz $s0, trivialCase		#n=0

	addu $a0, $s0, 1		
	mul $a0, $a0, 4			
	li $v0, 9			#We allocate 4(n+1) bytes for the global array by sbrk system call
	syscall

	move $s1, $v0			#And store the starting address of the array in $a1
	li $t0, 0
	sw $t0, 0($s1)			#F(0)=0
	li $t0, 1
	sw $t0, 4($s1)			#F(1)=1
	addu $t2, $s1, 8		#$t2 points to the element being calculated
	addu $t1, $s1, 4		#$t1 points to the predecessor of the element being calculated
	move $t0, $s1			#$t0 points to the predecessor of the predecessor of the element being calculated
	li $t3, 2			#$t3 stores the index of the element being calculated
fillingArray:
	bgt $t3, $s0, arrayFilled	#We stop after index reaches n
	lw $t4, 0($t1)			#$t4=F(i-1)
	lw $t5, 0($t0)			#$t5=F(i-2)
	addu $t6, $t4, $t5		#$t6=F(i-1)+F(i-2)
	sw $t6, 0($t2)			#F(i)=$t6
	addu $t2, $t2, 4		#Incrementing all addresses by one word i.e. 4 bytes
	addu $t1, $t1, 4
	addu $t0, $t0, 4
	addu $t3, $t3, 1		#And index by 1
	b fillingArray
arrayFilled:
	li $v0, 1
	lw $a0, 0($t1)
	syscall				#Printing the required Fibonacci number
	
	li $v0, 10
	syscall				#Exitting
trivialCase:
	li $v0, 1
	li $a0, 0
	syscall				#Printing 0

	li $v0, 10
	syscall				#Exitting

.data
	resultMessage: .asciiz "\nThe required Fibonacci number is: "
	welcomeMessage: .asciiz "\nEnter n: "
	
	
