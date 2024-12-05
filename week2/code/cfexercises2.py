#!/usr/bin/env python3

"""
Description: This script demonstrates several functions that print "hello" 
based on different conditions using for loops and while loops.
"""

__appname__ = '[cfexercises2.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'



######################## 
# For every value from 1 - 12, if the value is divisible by 3, print 'hello', and print a blank space at the end.
def hello_1(x):
    """
    Prints 'hello' for every value from 0 to x-1 if the value is divisible by 3.

    Args:
        x (int): The upper limit (exclusive) for the range of values to check.

    Behavior:
        - Iterates through all integers from 0 to x-1.
        - Checks if each number is divisible by 3 (i.e., remainder is 0 when divided by 3).
        - If divisible, prints the word 'hello'.
        - After completing the loop, prints a blank line for separation.

    Example:
        >>> hello_1(12)
        hello
        hello
        hello
        hello
        
        (Blank line at the end)
    """
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')  # Prints a blank space after the loop.

# Example usage
hello_1(12)



######################## 

def hello_2(x):
    """
    Prints 'hello' for every value from 0 to x-1 if the number gives a remainder 
    of 3 when divided by either 5 or 4.

    Args:
        x (int): The upper limit (exclusive) for the range of values to check.

    Behavior:
        - Iterates through all integers from 0 to x-1.
        - Checks two conditions for each number:
          1. If the number gives a remainder of 3 when divided by 5.
          2. If the number gives a remainder of 3 when divided by 4.
        - If either condition is satisfied, prints 'hello'.
        - After completing the loop, prints a blank line for separation.

    Example:
        >>> hello_2(12)
        hello
        hello
        hello
        hello
        hello

        (Blank line at the end)
    """
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')  # Prints a blank space after the loop.

# Example usage
hello_2(12)



######################## 
# Prints 'hello' for every integer between the range of 3 to 17.
def hello_3(x, y):
    """
    Prints 'hello' for each integer between x (inclusive) and y (exclusive).

    Args:
        x (int): The starting integer (inclusive) of the range.
        y (int): The ending integer (exclusive) of the range.

    Behavior:
        - Iterates through all integers from x to y-1.
        - For each integer in the range, prints the word 'hello'.
        - After completing the loop, prints a blank line for separation.

    Example:
        >>> hello_3(3, 7)
        hello
        hello
        hello
        hello

        (Blank line at the end)
    """
    for i in range(x, y):
        print('hello')
    print(' ')  # Prints a blank space after the loop.

# Example usage
hello_3(3, 17)



######################## 
# While x is not equal to 15, print 'hello' then add 3 to x.
def hello_4(x):
    """
    Prints 'hello' repeatedly, incrementing x by 3 until x equals 15.

    Args:
        x (int): The starting value for the loop.

    Behavior:
        - Continuously increments x by 3 in each iteration.
        - Prints the word 'hello' during each iteration.
        - Stops the loop once x equals 15.
        - After completing the loop, prints a blank line for separation.

    Example:
        >>> hello_4(0)
        hello
        hello
        hello
        hello
        hello

        (Blank line at the end)
    """
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')  # Prints a blank space after the loop.

# Example usage
hello_4(0)



######################## 
# Prints 'hello' once when x == 18 and 'hello' 7 times when x == 31, won't print anything if x is below 31.

def hello_5(x):
    """
    Prints 'hello' based on specific conditions for the value of x:
    
    - Prints 'hello' once if x equals 18.
    - Prints 'hello' seven times consecutively if x equals 31.
    - Continues to increment x by 1 until it reaches 100.

    Args:
        x (int): The starting value for the loop.

    Behavior:
        - The loop iterates as long as x is less than 100.
        - Checks specific conditions:
          1. If x equals 18, prints 'hello' once.
          2. If x equals 31, prints 'hello' seven times in a row.
        - Increments x by 1 during each iteration.
        - Prints a blank line at the end for separation.

    Example:
        >>> hello_5(12)
        hello
        hello
        hello
        hello
        hello
        hello
        hello

        (Blank line at the end)
    """
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')  # Prints a blank space after the loop.

# Example usage
hello_5(12)



######################## 
# WHILE loop with BREAK: prints the string 'hello!' followed by a number until y == 6 is reached, if x is set as True.
def hello_6(x, y):
    """
    Prints 'hello!' followed by the value of y, incrementing y by 1 in each iteration.
    Stops when y equals 6, breaking the loop.

    Args:
        x (bool): A boolean value. The loop continues as long as x is True.
        y (int): The starting value to be incremented and printed.

    Behavior:
        - Continuously prints 'hello!' followed by the current value of y.
        - Increments y by 1 in each iteration.
        - Breaks the loop when y equals 6.
        - Prints a blank line for separation after exiting the loop.

    Example:
        >>> hello_6(True, 0)
        hello! 0
        hello! 1
        hello! 2
        hello! 3
        hello! 4
        hello! 5

        (Blank line at the end)
    """
    while x:  # while x is True
        print("hello! " + str(y))  # Prints 'hello!' followed by the current value of y.
        y += 1  # Increment y by 1.
        if y == 6:
            break  # Exit the loop when y equals 6.
    print(' ')  # Prints a blank space after the loop.

# Example usage
hello_6(True, 0)


