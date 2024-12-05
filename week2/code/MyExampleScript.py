#!/usr/bin/env python3

"""
Description: This script demonstrates a simple function `foo` that multiplies 
a number by itself and prints the result. The script also includes instructions 
on how to run it using different Python interpreters in the terminal.

"""

__appname__ = '[MyExampleScript.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'

def foo(x):
    """
    Multiply a number by itself and print the result.

    Parameters:
        x (int or float): The number to be squared.

    Returns:
        None
    """
    x *= x  # Multiply x by itself (same as x = x * x)
    print(x)  # Print the result of x*x


foo(2)  # Call the function foo with argument 2; should print 4

# You can run a Python script from the command line (bash) in several ways:

# Using Python 3:
# python3 MyExampleScript.py

# Using IPython 3:
# ipython3 MyExampleScript.py

# In an interactive IPython session, you can run scripts with the %run magic command:
# %run MyExampleScript.py

