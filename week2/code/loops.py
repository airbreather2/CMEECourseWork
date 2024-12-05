#!/usr/bin/env python3

"""
Description: This script demonstrates basic examples of using loops in Python. 
It includes:
- A FOR loop to iterate over a range of numbers.
- A FOR loop to iterate over a list of mixed data types.
- A FOR loop that sums values in a list.
- A WHILE loop that increments a variable until a condition is met.

"""
__appname__ = '[loops.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'

# Simple for loop that iterates over a range of numbers from 0 to 4
for i in range(5):
    print(i)  # Prints each number in the range

# Iterating over elements in a list of mixed data types
my_list = [0, 2, "geronimo!", 3.0, True, False]
for k in my_list:
    print(k)  # Prints each element in the list `my_list`

# Summing values in a list
total = 0  # Initialize total to 0
summands = [0, 1, 11, 111, 1111]
for s in summands:
    total = total + s  # Add each element in `summands` to `total`
    print(total)       # Print the running total after each addition

# WHILE loop

# Loop that increments `z` until it reaches 100
z = 0  # Initialize z to 0
while z < 100:
    z = z + 1  # Increment z by 1 in each iteration
    print(z)   # Print the value of z each time



