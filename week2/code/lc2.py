#!/usr/bin/env python3

"""
Description: This script analyzes the average UK rainfall for the year 1910 by month, 
using both list comprehensions and conventional loops. It performs the following tasks:
- Creates a list of month and rainfall tuples where rainfall exceeds 100 mm.
- Creates a list of month names where rainfall is less than 50 mm.
- Recreates both tasks using conventional loops.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = '[lc2.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.

over_100 = [(i[0], i[1]) for i in rainfall if i[1] > 100] # list of tuples is created  for every element of rainfall where the the second element in each tuple is over 100
print(over_100)


# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

under_50 = [i[0] for i in rainfall if i[1] < 50]
print(under_50)


# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

over_100 = []
for i in rainfall:
    if i[1] > 100:
        over_100.append((i[0], i[1]))
print(over_100)

under_50 = []
for i in rainfall:
    if i[1] < 50:
        under_50.append(i[0])
print(under_50)

# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

