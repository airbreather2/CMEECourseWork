
#!/usr/bin/env python3

"""
Description: This script demonstrates how to write data to a file in Python. 
It includes:
- Saving the elements of a list (range 0 to 99) to a text file using with open.
- Writing each element on a new line in the output file.

Author: Sebastian Dohne (sed24@ic.ac.uk)
"""

__appname__ = '[basic_io2.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'

#############################
# FILE OUTPUT
#############################
# Save the elements of a list to a file
list_to_save = range(100)

try:
    with open('../sandbox/testout.txt','w') as file: #w stands for write mode, if file exists, contents will be overwritten, if not, contents created 
        for i in list_to_save:
            file.write(str(i) + '\n') ## Add a new line at the end
    #this tring of text created a txt file goin from 0 to 99 where each number is written on a new line
    print("done! elements of the list (range 0 to 99) saved to a text file")
except FileNotFoundError:
    print("File not found")  # Handle missing file error
except OSError:
    print("File may be corrupted or you lack permission to read it.")  # Handle other file errors

