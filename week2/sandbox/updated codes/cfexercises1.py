#!/usr/bin/env python3

"""
This program provides various mathematical utility functions, including:
- Calculating the square root of a number
- Finding the maximum of two numbers
- Sorting three numbers in ascending order
- Calculating the factorial of a number using different methods: 
  iteratively, recursively, and using a while loop.

Author: Sebastian Dohne  (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = '[cfexercises1.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"
# Imports

import sys  # module to interface our program with the operating system


def foo_1(x):
    """
    Calculates the square root of a given number.

    Parameters:
    x (float or int): The number to find the square root of.

    Returns:
    float: The square root of the number x.
    
    >>> foo_1(4)
    2.0
    >>> foo_1(9)
    3.0
    """
    return x ** 0.5

def foo_2(x, y):
    """
    Finds the larger of two numbers.

    Parameters:
    x (float or int): The first number.
    y (float or int): The second number.

    Returns:
    float or int: The larger of the two numbers x and y.
    
    >>> foo_2(5, 3)
    5
    >>> foo_2(2, 8)
    8
    >>> foo_2(7, 7)
    7
    """
    if x > y:
        return x
    return y

def foo_3(x, y, z):
    """
    Sorts three numbers in ascending order.

    Parameters:
    x (float or int): The first number.
    y (float or int): The second number.
    z (float or int): The third number.

    Returns:
    list: A list of the three numbers sorted in ascending order.
    
    >>> foo_3(5, 3, 2)
    [2, 3, 5]
    >>> foo_3(1, 2, 3)
    [1, 2, 3]
    >>> foo_3(7, 5, 6)
    [5, 6, 7]
    """
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    if x > y:
        tmp = y
        y = x
        x = tmp
    return [x, y, z]

def foo_4(x):
    """
    Calculates the factorial of a number iteratively.

    Parameters:
    x (int): The number to calculate the factorial of.

    Returns:
    int: The factorial of the number x.
    
    >>> foo_4(5)
    120
    >>> foo_4(0)
    1
    >>> foo_4(3)
    6
    """
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x): 
    """
    Recursively calculates the factorial of a number.

    Parameters:
    x (int): The number to calculate the factorial of.

    Returns:
    int: The factorial of the number x.
    
    >>> foo_5(5)
    120
    >>> foo_5(0)
    1
    >>> foo_5(3)
    6
    """
    if x == 0:
        return 1
    return x * foo_5(x - 1)
     
def foo_6(x): 
    """
    Calculates the factorial of a number using a while loop.

    Parameters:
    x (int): The number to calculate the factorial of.

    Returns:
    int: The factorial of the number x.
    
    >>> foo_6(5)
    120
    >>> foo_6(0)
    1
    >>> foo_6(3)
    6
    """
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main():
    """
    Runs test cases for each function and prints results.
    """
    print("foo_1(9):", foo_1(9))               # Example square root calculation
    print("foo_2(5, 3):", foo_2(5, 3))         # Example max of two numbers
    print("foo_3(5, 3, 2):", foo_3(5, 3, 2))   # Example sorting of three numbers
    print("foo_4(5):", foo_4(5))               # Example factorial calculation (iterative)
    print("foo_5(5):", foo_5(5))               # Example factorial calculation (recursive)
    print("foo_6(5):", foo_6(5))               # Example factorial calculation (while loop)
    
    print("\nAll test cases executed.")


if __name__ == "__main__": 
    import doctest 
    doctest.testmod() #runs doctest automatically
    main()

