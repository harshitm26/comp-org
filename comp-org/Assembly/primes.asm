.text
.globl main
main:
	li $v0, 4		#Printing the Welcome message
	la $a0, welcomeMessage
	syscall
	subu $sp, $sp, 8	#Building main stack
	sw $ra, 0($sp)
	li $v0,5		#Receiving n
	syscall
	move $s0,$v0		#n is stored in $s0
	li $v0, 4
	la $a0, resultMessage
	syscall			#Printing the result message
	li $s1,2		#We start checking primality from 2 onwards
primeCheckerLoop:
	bgt $s1, $s0, endPrimeCheck	#End if all numbers from 2 to n have been checked
	move $a0, $s1
	jal isPrime			#Check whether number in $a0 is prime
	beq $v0,0,notPrime		#$v0 is 0 if $a0 is not prime i.e. composite
	li $v0, 1
	syscall				#Prints $a0 if $v0 is 1
	li $v0, 4
	la $a0, newline
	syscall				#Prints a newline chatacter
notPrime:
	addu $s1, $s1, 1		#Both prime and not-prime case fall through to incrementing $s1 to the next number to be checked
	j primeCheckerLoop
	
endPrimeCheck:
	lw $ra, 0($sp)			#Restoring return address
	addu $sp,$sp,8			#Popping out stack
	li $v0, 10			#Preparing for exit
	syscall				#Exitting

isPrime:
	li $t0,2			#We check for factors of $a0 from 2 onwards
isPrimeLoop:
	beq $t0,$a0, prime		#$a0 is prime if no factor was found from 2 to ($a0)-1
	divu $a0,$t0			#Divide $a0 by $t0
	mfhi $t1			#Receiving remainder in $t1
	beqz $t1, composite		#Remainder =0 => Not prime or Composite
	addu $t0,$t0,1			#Else we check whether the next number is a factor
	j isPrimeLoop
prime:
	li $v0,1			#Return 1 if prime
	jr $ra
composite:
	li $v0,0			#0 otherwise
	jr $ra
.data
newline: .asciiz "\n"
welcomeMessage: .asciiz "Enter n: \n"
resultMessage: .asciiz "The required primes are: \n"
