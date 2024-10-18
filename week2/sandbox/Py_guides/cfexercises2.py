#!/usr/bin/env python3

"""
Description: This script demonstrates several functions that print "hello" 
based on different conditions using for loops and while loops.
"""

__appname__ = '[cfexercises2.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

######################## 
# For every value from 1 - 12, if the value is divisible by 3, print 'hello', and print a blank space at the end.
def hello_1(x):
    """
    Prints 'hello' for every value from 0 to x-1 if the value is divisible by 3.
    """
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')  # Prints a blank space after the loop.

hello_1(12)


######################## 
# If the remainder of dividing by 5 is 3 or if dividing by 4 is 3, print 'hello'.
def hello_2(x):
    """
    Prints 'hello' if the number gives a remainder of 3 when divided by 5 or 4.
    """
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')  # Prints a blank space after the loop.

hello_2(12)


######################## 
# Prints 'hello' for every integer between the range of 3 to 17.
def hello_3(x, y):
    """
    Prints 'hello' for each integer between x (inclusive) and y (exclusive).
    """
    for i in range(x, y):
        print('hello')
    print(' ')  # Prints a blank space after the loop.

hello_3(3, 17)


######################## 
# While x is not equal to 15, print 'hello' then add 3 to x.
def hello_4(x):
    """
    Prints 'hello' repeatedly, incrementing x by 3 until x equals 15.
    """
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')  # Prints a blank space after the loop.

hello_4(0)


######################## 
# Prints 'hello' once when x == 18 and 'hello' 7 times when x == 31, won't print anything if x is below 31.
def hello_5(x):
    """
    Prints 'hello' based on specific values of x:
    - Once when x equals 18.
    - Seven times when x equals 31.
    """
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')  # Prints a blank space after the loop.

hello_5(12)


######################## 
# WHILE loop with BREAK: prints the string 'hello!' followed by a number until y == 6 is reached, if x is set as True.
def hello_6(x, y):
    """
    Prints 'hello!' followed by y incremented by 1 until y equals 6, then breaks the loop.
    """
    while x:  # while x is True
        print("hello! " + str(y))  # Prints 'hello!' followed by the current value of y.
        y += 1  # Increment y by 1.
        if y == 6:
            break  # Exit the loop when y equals 6.
    print(' ')  # Prints a blank space after the loop.

hello_6(True, 0)

