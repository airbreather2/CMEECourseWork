#!/usr/bin/env python3

"""
Description: This script demonstrates how to read from a file using Python. 
It includes:
- Reading and printing each line of a file.
- Skipping and ignoring blank lines when printing the content of a file.
- Using both manual file opening and the `with` statement for automatic file closure.

"""

__appname__ = '[basic_io1.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'

#############################
# FILE INPUT
#############################
# Open a file for reading
f = open('../sandbox/test.txt', 'r')  # Open the file in read mode

# Use "implicit" for loop:
# When a file object is used in a for loop, Python automatically reads each line
for line in f:
    print(line)  # Print each line as-is (including blank lines)

# Close the file after reading is complete
f.close()

# Same example, but this time, skip blank lines
f = open('../sandbox/test.txt', 'r')  # Reopen the file in read mode
for line in f:
    # Strip whitespace and check if line has content
    if len(line.strip()) > 0:  # Ignore lines that are only whitespace
        print(line)  # Print non-blank lines only

# Close the file after processing
f.close()

#############################
# FILE INPUT
#############################
# Open a file for reading, using the `with` statement

try:
    # `with` automatically closes the file after the block ends
    with open('../sandbox/test.txt', 'r') as file:
        # Read the entire content of the file and print it as a single string
        content = file.read()
        print(content)
except FileNotFoundError:
    print("File not found")  # Print an error if the file does not exist
except OSError:
    print("File Corrupted/you do not have permission to edit")  # Print an error if there’s a read or permission issue


# Open the file again with `with`, but skip blank lines this time
try:
    with open('../sandbox/test.txt', 'r') as file:
        # Loop over each line individually
        for line in file:
            # Strip whitespace and check if line has content
            if len(line.strip()) > 0:
                print(line.strip())  # Print only lines with content
except FileNotFoundError:
    print("File not found")  # Handle missing file error
except OSError:
    print("File may be corrupted or you lack permission to read it.")  # Handle other file errors


