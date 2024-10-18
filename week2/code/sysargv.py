#!/usr/bin/env python3

"""
Description: This script demonstrates the usage of `sys.argv`, which is used to 
access command-line arguments in Python. It prints:
- The name of the script.
- The number of arguments passed to the script.
- The list of arguments themselves.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""
__appname__ = '[sysargv.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


#argv is the argument variable it is the variable that holds the arguments you pass to your Python script
#when you run it like $var in shell scripts
#sys.argv is an object created by the sys module that contains the names of the argument variables in the current script

import sys
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: " , str(sys.argv))

#run sysargv.py
#Output: 
#This is the name of the script:  sysargv.py
#Number of arguments:  1
#The arguments are:  ['sysargv.py']

#run sysargv.py var1 var2
#Output: 
#This is the name of the script:  sysargv.py
#Number of arguments:  3
#The arguments are:  ['sysargv.py', 'var1','var2']

#run sysargv.py 1 2 var37
#This is the name of the script:  sysargv.py
#Number of arguments:  4
#The arguments are:  ['sysargv.py', '1', '2', 'var3']

