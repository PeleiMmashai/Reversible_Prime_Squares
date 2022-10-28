# Reversible_Prime_Squares
The program outputs the desired number of reversible prime squares by the user


#================================================
# @writer: 'Mashai Pelei
# @aim   : to check for reversible prime squares.
# @date  : October 2022
#@email  : mayshaypeley99@gmail.com
#===============================================



#firstly, Allow me to explain the algorithm used:

# 1. First step  is to check for prime numbers from a set of natural numbers
# 2. If the number is a prime number the program will square it 
# 3. Then check if the squared primes are palindromes using a palindrom checker
# 4. If the square is not a palindrome it will then be reversed
# 5. The reversed square will then be checked if its a square using the power function because the sqrt function(easier to use) is not in the library of the MIPS assembly
# 6. If the reversed is indeed a square a prime checker is then used to find if the root is a prime number
# 7. If the root is a prime number then the reversible prime square will be printed out,thank you!!
# the program will only print out the desired number of reversible prime squares by the user, compilation might take time but please be patient.
#================================================

The first function used in this program is the prime checker function and I would like to explain why it was used;
the main aim of this program to print out reversible prime squares, that means any number printed out is a prime number meaning the universal set in this case is a set of prime numbers.  
