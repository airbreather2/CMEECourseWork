
#!/usr/bin/env python3

"""
Description: This script demonstrates how to write data to a file in Python. 
It includes:
- Saving the elements of a list (range 0 to 99) to a text file.
- Writing each element on a new line in the output file.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = '[basic_io2.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

#############################
# FILE OUTPUT
#############################
# Save the elements of a list to a file
list_to_save = range(100)

f = open('../sandbox/testout.txt','w') #w stands for write mode, if file exists, contents will be overwritten, if not, contents created 
for i in list_to_save:
    f.write(str(i) + '\n') ## Add a new line at the end
#this tring of text created a txt file goin from 0 to 99 where each number is written on a new line
f.close() #ensure the file is closed, data saved correctly and no longer used by programme