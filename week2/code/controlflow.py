#!/usr/bin/env python3

"""Some functions exemplifying the use of control statements"""

__appname__ = '[controlflow.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'




########################Importing Modules ########################
import sys


##################################################################

def even_or_odd(x=0):
    """
    Check if a number is even or odd.

    Parameters:
        x (int): The number to check (default is 0).

    Returns:
        str: A message indicating whether the number is even or odd.

    Example:
        >>> even_or_odd(3)
        '3 is Odd!'
    """
    if x % 2 == 0:  # Check if x is divisible by 2
        return f"{x} is Even!"
    return f"{x} is Odd!"



def largest_divisor_five(x=120):
    """
    Find the largest divisor of x among 2, 3, 4, and 5.

    The function checks if x is divisible by 5, 4, 3, or 2 (in that order)
    and returns the largest divisor. If none of these numbers divide x,
    it returns a message indicating no divisor was found.

    Parameters:
        x (int): The number to check (default is 120).

    Returns:
        str: A message indicating the largest divisor of x, or that no divisor was found.

    Example:
        >>> largest_divisor_five(120)
        'The largest divisor of 120 is 5'

        >>> largest_divisor_five(7)
        'No divisor found for 7!'
    """
    largest = 0
    if x % 5 == 0:
        largest = 5
    elif x % 4 == 0:  # means "else if"
        largest = 4
    elif x % 3 == 0:
        largest = 3
    elif x % 2 == 0:
        largest = 2
    else:  # When all other (if, elif) conditions are not met
        return f"No divisor found for {x}!"  # Each function can return a value or a variable.
    return f"The largest divisor of {x} is {largest}"


def is_prime(x=70):
    """
    Determine whether a given integer is a prime number.
    This function checks if the input integer `x` meets this
    criterion.

    Parameters:
        x (int): The number to check (default is 70).

    Returns:
        bool: True if `x` is a prime number, False otherwise.

    Examples:
        >>> is_prime(11)
        11 is a prime!
        True

        >>> is_prime(12)
        12 is not a prime: 2 is a divisor
        False
    """
    if x <= 1:  # Prime numbers must be greater than 1
        print(f"{x} is not a prime: it is less than or equal to 1")
        return False

    # Check divisors up to the square root of x for efficiency
    for i in range(2, int(x**0.5) + 1):  
        if x % i == 0:
            print(f"{x} is not a prime: {i} is a divisor")
            return False
    print(f"{x} is a prime!")
    return True


def find_all_primes(x=22):
    """
    Find all prime numbers up to a given number `x`.

    This function generates a list of all prime numbers between 2 and `x` (inclusive)
    by using the `is_prime` function to check for primality.

    Parameters:
        x (int): The upper limit for finding primes (default is 22).

    Returns:
        list: A list of all prime numbers between 2 and `x`.

    Example:
        >>> find_all_primes(10)
        There are 4 primes between 2 and 10
        [2, 3, 5, 7]
    """
    allprimes = []
    for i in range(2, x + 1):
        if is_prime(i):
            allprimes.append(i)
    print(f"There are {len(allprimes)} primes between 2 and {x}")
    return allprimes

      
def main(argv):
    """
    Main function to demonstrate the functionality of utility functions.

    This function calls and displays the results of various utility functions:
    - Checking if numbers are even or odd.
    - Finding the largest divisor of a number among 2, 3, 4, and 5.
    - Determining if numbers are prime.
    - Finding all prime numbers up to a specified limit.

    Parameters:
        argv (list): Command-line arguments (not used in this implementation).

    Returns:
        int: 0 to indicate successful execution.

    Examples:
        >>> main([])
        22 is Even!
        33 is Odd!
        The largest divisor of 120 is 5
        No divisor found for 121!
        60 is not a prime: 2 is a divisor
        False
        59 is a prime!
        True
        There are 25 primes between 2 and 100
        [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
        0
    """
    # Demonstrating the utility functions
    print(even_or_odd(22))  # Check if 22 is even or odd
    print(even_or_odd(33))  # Check if 33 is even or odd

    print(largest_divisor_five(120))  # Find the largest divisor of 120
    print(largest_divisor_five(121))  # Find the largest divisor of 121

    print(is_prime(60))  # Check if 60 is a prime number
    print(is_prime(59))  # Check if 59 is a prime number

    print(find_all_primes(100))  # Find all primes up to 100

    return 0

if (__name__ == "__main__"):    #entry point for the script
    status = main(sys.argv) #ensures the main function is only executed when the script is run directly (not imported as a module)
    sys.exit(status) #It passes command-line arguments to `main` and exits with the return status.  Example Usage: $ python script_name.py