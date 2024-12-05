#!/usr/bin/env python3

"""Some functions exemplifying the use of control statements"""

__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'
__appname__ = '[test_control_flow.py]'

import sys
import doctest # Import the doctest module

def even_or_odd(x=0):
    """
    Determines whether a number x is even or odd.

    Args:
        x (int, optional): The number to check. Defaults to 0.

    Returns:
        str: A string indicating whether x is "Even" or "Odd".

    Behavior:
        - Checks if the input number x is divisible by 2 (even) or not (odd).
        - Handles negative numbers by treating them as their positive equivalents.
        - Returns a formatted string indicating the result.

    Examples:
        >>> even_or_odd(10)
        '10 is Even!'
        
        >>> even_or_odd(5)
        '5 is Odd!'
        
        >>> even_or_odd(-2)
        '-2 is Even!'
    """
    if x % 2 == 0:
        return f"{x} is Even!"
    return f"{x} is Odd!"


def main(argv):
    """
    Main function to test the even_or_odd function.
    """
    print(even_or_odd(22))
    print(even_or_odd(33))
    return 0

if __name__ == "__main__":
    """
    Entry point of the script.
    """
    status = main(sys.argv)


doctest.testmod()   # To run with embedded tests