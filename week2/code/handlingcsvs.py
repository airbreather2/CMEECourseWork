#!/usr/bin/env python3

"""
Description: This script demonstrates how to read and write CSV files using Python's 
`csv` module. It includes functionality to:
- Read data from an input CSV file containing species and their taxonomic details.
- Convert each row of the input CSV into a tuple and store it in a list.
- Print each row and the corresponding species name to the console.
- Write a new CSV file that includes only species names and their body mass.

The script is designed for processing taxonomic data and demonstrates basic file I/O operations.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = '[handlingcsvs].py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

## Imports
import csv

####

import csv

# Open the CSV file
with open('../data/testcsv.csv', 'r') as f:
    csvread = csv.reader(f)  # Initialize the CSV reader
    
    next(csvread)  # Skip the first row (header row)
    
    temp = []
    for row in csvread:
        temp.append(tuple(row))  # Add the row as a tuple to the temp list
        print(row)  # Print the row
        print("The species is", row[0])  # Print the first column (species)


# Write a file containing only species name and Body mass
with open('../data/testcsv.csv', 'r') as f:
    with open('../Results/bodymass.csv', 'w') as g:

        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row)
            print("Species name and mass for each row are:", [row[0], row[4]]) #prints species name and mass for each row
            csvwrite.writerow([row[0], row[4]])  # Writes species and body mass
