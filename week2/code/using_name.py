#!/usr/bin/env python3

"""
Description: This script demonstrates how the `__name__` variable works in Python.
It checks whether the script is being run directly or imported as a module and prints
an appropriate message based on that. It also displays the module's name.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = 'using_name.py'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# Check if the script is being run directly or imported


if __name__ == '__main__':
    print('This program is being run by itself!') 
else:
    print('I am being imported from another script/program/module!')

print("This module's name is: " + __name__)

#doing: %run using_name.py
#This program is being run by itself!
#This module's name is: __main__

#doing import using_name
#I am being imported from another script/program/module!
#This module's name is: using_name

