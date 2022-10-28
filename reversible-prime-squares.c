/*#================================================
# @writer: 'Mashai Pelei
# @aim   : to check for reversible prime squares.
# @date  : October 2022
#@email  : mayshaypeley99@gmail.com
# Allow me to explain the algorithm used:
# 1.First check for prime numbers from a set of natural numbers
# 2. If the number is a prime number the program will square it 
# 3. Then check if the squared primes are palindromes using a palindrom checker
# 4. If the square is not a palindrome it will then be reversed
# 5. The reversed square will then be checked is its a square using the power function because the sqrt function(easier to use) is not in the library of the MIPS assembly
# 6. If the reversed is indeed a square a prime checker is used to find if the root is a prime number
# 7. If the root is a prime number then the reversible prime square will be printed out,thank you!!
# the program will only print out the desired number of reversible prime squares by the user, compilation might take time but please be patient.
#================================================*/


#include<stdio.h>
#include <math.h>
#include<stdbool.h>

bool isPrime(int n);

// Reverse
int reverse(int n);

// Palindrome
bool palindrome(int n);

// square number
bool squareNumber(float n);

// 
void main_loop(int n);

// Display
void display(long *result);

int main()
{
	int n = 0;
	printf("enter number of reversible prime squares> ");
	if(scanf("%d",&n)) {
		main_loop(n);
		
	}
	
	return 0;
}


// Primer checker
bool isPrime(int n)
{
	int counter = 0;
	
	for(int i = 1; i <= n; i++)
	{
		if(n%i == 0)
		{
			counter++;
		}
	}
	if(counter == 2){
		return true;
	}
	else{
		return false;
	}
}

// Reverse
int reverse(int n)
{
	int reminder = 0;
	int result = 0;
	
	if(n == 0){
		return 0;
	}
	while((n%10 > 0) || (n/10 > 0))
	{
		reminder = n%10;
		n = n/10;
		result = (result * 10) + reminder;
	}
	return result;
}

// Palindrome
bool palindrome(int n)
{
	if(n == reverse(n)){
		return true;
	}
	else {
		return false;
	}
}

// square number
bool squareNumber(float n)
{	
	float result = sqrt(n);
	
	if(ceil(result) == result){
		return true;
	}
	else{
		return false;
	}
}

// 
void main_loop(int n)
{
	long int itr = 1;
	
	long int rev;
	long int result;
	long int sqroot;
	
	long ans[10];
	int counter = 0;
	
	while(counter < n) 
	{
		printf("..................................................\n");
		printf("\nValue: ", "%d",itr);
		
		if(isPrime(itr))
		{
			result = pow(itr,2);
			rev = reverse(result);
			sqroot =pow(rev,0.5);
			
			if(palindrome(result)==false)
			{
				if(squareNumber(rev))
				{
					if(isPrime(sqroot))
					{
						printf("* Ans: %d",result);
						ans[counter++] = result;
					}
					else{
						printf("%d",itr," -> Sqrt of reversed square number not prime");
					}
				}
				else{
					printf("%d",itr,"-> Reversed square number is not a Square Number");
				}
			}
			else {
				printf("%d",itr,"-> Reversed square number is a palindrome");
			}
		}
		else{
			printf("%d",itr,"-> Not prime!");
		}
		printf("\n..................................................\n");
		itr++; 
	}
	for(int i = 0; i < counter; i++)
	{
		printf("\n[%d]%d\t",i,ans[i]);
	}
}

// Display
void display(long result[])
{
	
}