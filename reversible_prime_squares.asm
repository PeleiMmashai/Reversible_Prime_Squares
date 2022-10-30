.data
	ans:	.space	40		#for 10 elements in an array
	prompt: .asciiz "Enter number of reversible prime squares: "
	line:	.asciiz	"...............................................\n"
	value: .asciiz "\nValue: "
	newLine: .asciiz "\n"
	
.text
.globl main

#========================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int n
#========================================================================  
	main:
		li $a1, 0						#int n = 0
		
		li $v0, 4						#ask the user to enter the number of square primes requested
		la $a0, prompt
		syscall
		
		li $v0, 5						#Prompt the user to enter the number
		syscall
		move $a1, $v0					#Move the user input from $v0, to $t0
		
		print:
			beqz $a1, Not_Applicable		#If no numbers is input or zero is inputed dont print reversible square primes
			
			addi $sp, $sp, -4				#allocate memory in the stack for one register
			sw $a1, 0($sp)					#Store the a registers in the stack
				jal main_loop					#Call the main_loop procedure
			lw $a1, 0($sp)					#Load the a registers from the stack
			addi $sp, $sp, 4				#Deallocate memory from the stack	
		Not_Applicable:
		
		li $v0, 10						#End the program
		syscall
		
# A L L  T H E  P R O C E D U R E S  I N  T H E  C O D E
#==============================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a2 -> int n; argument for the procedure
# $t0 -> int counter
# $t1 -> int i
# $t2 -> n%i
# $v1 -> return value; true(1) or false(0)
#============================================================================== 
	isPrime:
	#This procedure is a Callee by main_loop; store the s registers
		
		li $t0, 0						#int counter = 0
		li $t1, 1						#int i = 1
		
		while_isPrime:
			beq $t1, $a2, stop			#If i == n, stop loop
			
			div $a2, $t1				#n%i
			mfhi $t2
			skip:
				bnez $t2, yes			#if n%i != 0, skip the counter
				
				addi $t0, $t0, 1		#counter++
			yes:
			
			addi $t1, $t1, 1			#i++
			
			j while_isPrime
		stop_isPrime:
		
		li $v1, 0						#bool isPrime -> false
		
		True:
			bne $t0, 1, False			#if counter != 1; return false
			
			addi $v1, $v1, 1			#bool isprime -> true
		False:
		
		jr $ra
		
#================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int n; argument for the procedure
# $t0 -> int reminder
# $s0 -> const 10
# $v1 -> return value for the procedure, int result
#================================================================================
	reverse:
	#This procedure is a Calle by main_loop and palindrome; store the s registers
		addi $sp, $sp, -4				#Allocate memory in the stack for 1 register
		sw $s0, 0($sp)					#Store the s register in the stack
	
		li $t0, 0						#int reminder = 0
		li $s0, 10						#const 10
		li $v1, 0						#Set the return value as 0
		
		beqz $a1, return_reverse		#If int n == 0; return 0
		
		div $a1, $s0					
		mfhi $t0						#n%10
		mflo $a1						#n/10
		while_reverse:
			bltz $a1, stop_reverse		#if n < 0, stop loop
			
			mult $v1, s0				#result * 10
			mflo $v1
			
			add $v1, $v1, $t0			#result = 10(result) + reminder
			
			div $a1, $s0					
			mfhi $t0					#n%10
			mflo $a1					#n/10
		
			j while_reverse
		stop_reverse:
		
		return_reverse:					#if n != 0; then n shall be reversed
		
		lw $s0, 0($sp)					#Load the s register from the stack
		addi $sp, $sp, 4				#Deallocate memory in the stack
		
		jr $ra
		
#================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int n; argument for the procedure
# $t0 -> return value for the reverse procedure
# $v1 -> return value for the procedure; true(1) or false(0)
#================================================================================
	palindrome:
	#This procedure is a Callee by main_loop; store the s and ra registers
	#This procedure is a Caller to reverse;	store the t, a and v registers
		addi $sp, $sp, -4				#Allocate memory in the stack for one register
		sw $ra, 0($sp)					#Store the return address for the procedure
		
		addi $sp, $sp, -4				#Allocate memory in the stack for one register
		sw $a1, 0($sp)					#Store the a register in the stack
			jal reverse						#Call the reverse procedure; type int
			move $t0, $v1					#Move return value to t register
		lw $a1, 0($sp)					#Load the a register from the stack
		addi $sp, $sp, 4				#Deallocate memory from the stack
		
		li $v1, 0						#Set the return value to false(0)
		
		if_palindrome:
			bne $a1, $t0, return_palindrome		#If n != reverse(n); return false(0)
		
			addi $v1, v1, 1						#return true(1)
		return_palindrome:
		
		lw $ra, 0($sp)					#Load the return address for the procedure
		addi $sp, $sp, 4				#Deallocate memory in the stack
		
		jr $ra
	
#================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int n; argument for the procedure
# $t0 -> 
# $v1 -> 
#================================================================================
	squareNumber:
	#This procedure is a Callee by main_loop; store the s register

		$t2=power($t0^$t1)
		li $t2,1                                #$t2=result=1
		beq $t1,$zero,exit_pow                  #if(n==0)

		while:
			mul $t2,$t2,$t0                 #x=x*x
			addi $t1,$t1,-1                 #n--
			bne $t1,$zero,while             #while(n>0)
		exit_pow:
	
	
	jr $ra
	
#C O M E  B A C K  H E R E
#================================================================================
# R E G I S T E R - V A R I A B L E  M A P P I N G
# $a1 -> int n; argument for the procedure, for reverse, palindrome, squareNumber
# $a2 -> argument for isprime
# $t1 -> int counter
# $t2 -> return value for isPrime procedure
#================================================================================
	main_loop:
	#This procedure is a Callee by main; store the s and ra registers
	#This procedure is a Caller to: isPrime, reverse, palindrome, squareNumber; store the t, a and v registers
		addi $sp, $sp, -4					#Allocate memory in the stack for one register
		sw $ra, 0($sp)						#Store the ra register
		
		li $a2, 1							#int itr = 1
		li $t1, 0							#int counter = 0
		
		while_main_loop:
			beq $t1, $a1, stop_main_loop		#if counter == n, stop loop
		
			li $v0, 4
			la $a0, line						#Draw a line
			syscall
			
			li $v0, 4
			la $a0, value
			syscall
		
			li $v0, 1
			add $a0, $a2, $zero					#Display value
			syscall
			
			addi $sp, $sp, -12					#Allocate memory for 3 registers in the stack
			sw $a1, 0($sp)						#Store the a register
			sw $a2, 4($sp)						
			sw $t1, 8($sp)						#Store the t register
				jal isPrime							#Call the isPrime procedure
				move $t2, $v1						#Move return value from $v1 to $t2
			lw $t1, 8($sp)						#Store the t register
			lw $a2, 4($sp)						
			lw $a1, 0($sp)						#Store the a register
			addi $sp, $sp, 12					#Deallocate memory in the stack
			
# C O M E  B A C K  T O  H E R E
		
			j while_main_loop
		stop_main_loop:
		
		lw $ra, 0($sp)						#Load the ra register
		addi $sp, $sp, 4					#Deallocate memory in the stack
		
		jr $ra