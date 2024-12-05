
#!/usr/bin/env python3

"""
Description: 
This script demonstrates how to work with file input in Python. It includes examples 
of reading a file line by line using the `with` statement to handle files safely, 
ensuring they are automatically closed after use. The script also illustrates 
skipping blank lines when processing a file.

Key Features:
- Reading a file line by line using an implicit loop.
- Safely handling file resources with the `with` statement.
- Filtering out blank lines during file processing.
"""

__appname__ = '[open.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'



#############################
# FILE INPUT
#############################
# Open a file for reading
with open('../sandbox/test.txt', 'r') as f:
    # use "implicit" for loop:
    # if the object is a file, python will cycle over lines
    for line in f:
        print(line)

# Once you drop out of the with, the file is automatically closed. With automatically safely closes the file, removes the need for f.close()

# Same example, skip blank lines
with open('../sandbox/test.txt', 'r') as f:
    for line in f:
        if len(line.strip()) > 0:
            print(line)
