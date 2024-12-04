#!/usr/bin/env python3

"""
Description: This script contains a function `buggyfunc` that attempts to 
perform division in a loop, catching errors such as division by zero. It demonstrates 
the use of try-except blocks for error handling in Python, and prints the progress 
and errors encountered during the execution of the function.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = '[debugme.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


def buggyfunc(x):
    """
    Demonstrates handling of exceptions in a loop that performs division.

    This function iterates from 0 to `x - 1`, decrementing `y` at each step and attempting 
    to compute `z = x / y`. It handles potential `ZeroDivisionError` exceptions and 
    prints debugging information for other errors.

    Parameters:
        x (int): The starting value for `y` and the numerator in the division.

    Returns:
        float: The last successfully computed value of `z` (x / y).
    """
    y = x
    for i in range(x):
        try:
            y = y - 1
            z = x / y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work;{x = }; {y = }")
        else:
            print(f"OK; {x = }; {y = }, {z = };")
    return z


buggyfunc(20)

#ipdb in python : runs in debugging python shell 