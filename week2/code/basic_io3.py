#!/usr/bin/env python3

"""
Description: This script demonstrates how to store and retrieve Python objects 
using the `pickle` module. It includes:
- Saving a dictionary to a file using `pickle`.
- Loading the dictionary back from the file for further use.

Author: Sebastian Dohne (sed24@ic.ac.uk)
"""

__appname__ = '[basic_io3.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'

##############Importing Modules#############

import pickle  # Imports the pickle module for serializing and deserializing Python objects

############################################



#############################
# STORING OBJECTS
#############################
# To save an object (even complex) for later use
my_dictionary = {"a key": 10, "another key": 11}  # Creates a dictionary with two key-value pairs

# Save the dictionary to a file
with open('../sandbox/testp.p', 'wb') as file:  # 'wb' mode for write-binary
    pickle.dump(my_dictionary, file)  # Serializes my_dictionary and writes it to the file

# Load the data again
with open('../sandbox/testp.p', 'rb') as file:  # 'rb' mode for read-binary
    another_dictionary = pickle.load(file)  # Deserializes the data from file

print(another_dictionary)  # Prints another_dictionary to verify it matches the original dictionary

