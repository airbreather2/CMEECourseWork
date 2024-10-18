#!/usr/bin/env python3

"""
Description: This script demonstrates the use of list comprehensions and loops 
to extract specific information from a tuple of bird species. The script performs the following:
- Creates lists of latin names, common names, and body masses using list comprehensions.
- Recreates the same lists using conventional loops.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = '[lc1.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"

# Tuple containing information about birds: latin name, common name, and mean body mass (in grams)

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. The if z > my_best_score condition means that when a new alignment has the same score as the current one, 
# the current one will be kept and the new one discarded. As a result, multiple alignments with the same score will be lost even if they are 
# all equally good alignments (highly likely in longer sequences), with only the first one retained.


latin_names = [i[0] for i in birds]
print(latin_names)

common_names = [i[1] for i in birds]
print(common_names)

body_mass = [i[2] for i in birds]
print(body_mass)


# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). latin_names = [i for i[0] in birds]

latin_names = []
for i in birds: # implicit loop
    latin_names.append(i[0])
print(latin_names)

common_names = []
for i in birds: 
    common_names.append(i[1])
print(common_names)

body_mass = []
for i in birds: 
    body_mass.append(i[2])
print(body_mass)

# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 