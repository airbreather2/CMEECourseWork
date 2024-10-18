#!/usr/bin/env python3

"""
Description: This script demonstrates how to read from a file using Python. 
It includes:
- Reading and printing each line of a file.
- Skipping and ignoring blank lines when printing the content of a file.
- Using both manual file opening and the `with` statement for automatic file closure.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.2
License: License for this code/program
"""

__appname__ = '[basic_io1.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.2'
__license__ = "License for this code/program"

#############################
# FILE INPUT
#############################
# Open a file for reading
f = open('../sandbox/test.txt', 'r')
# use "implicit" for loop:
# if the object is a file, python will cycle over lines
for line in f:
    print(line)

# close the file
f.close()

# Same example, skip blank lines
f = open('../sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0: #gets rid of empty lines: returns length of string after it has been stripped of white spaces 
        print(line)


#############################
# FILE INPUT
#############################
# Open a file for reading
with open('../sandbox/test.txt', 'r') as s:
    # use "implicit" for loop:
    # if the object is a file, python will cycle over lines
    for line in s:
        print(line)

# Once you drop out of the with, the file is automatically closed

# Same example, skip blank lines
with open('../sandbox/test.txt', 'r') as l:
    for line in l:
        if len(line.strip()) > 0:
            print(line)
            
f.close()#ensure the file is closed, data saved correctly and no longer used by programme 

