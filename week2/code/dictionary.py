#!/usr/bin/env python3

"""
Description: This script demonstrates how to populate a dictionary that maps 
taxonomic order names to sets of taxa (species). It uses both conventional loops and 
list comprehensions to achieve this. The script prints the resulting dictionary to the screen.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = '[dictionary.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


# List of tuples containing species and their taxonomic order
taxa = [
    ('Myotis lucifugus', 'Chiroptera'),
    ('Gerbillus henleyi', 'Rodentia'),
    ('Peromyscus crinitus', 'Rodentia'),
    ('Mus domesticus', 'Rodentia'),
    ('Cleithrionomys rutilus', 'Rodentia'),
    ('Microgale dobsoni', 'Afrosoricida'),
    ('Microgale talazaci', 'Afrosoricida'),
    ('Lyacon pictus', 'Carnivora'),
    ('Arctocephalus gazella', 'Carnivora'),
    ('Canis lupus', 'Carnivora')
]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. 
# OR, 
# 'Chiroptera': {'Myotis  lucifugus'} ... etc

#### Your solution here #### 

taxa_dic = {}

for species, order in taxa:  # Loop iterates over every tuple and unpacks each into species and order 
    if order in taxa_dic: 
        taxa_dic[order].append(species)  # Appends species to order if present in dictionary
    else:
        taxa_dic[order] = [species]  # If not, then a new list of species is created
print(taxa_dic)


# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  

taxa_dicc = {order: [species for species, ord in taxa if ord == order] for species, order in taxa}
# The dictionary comprehension maps orders to species lists
print(taxa_dicc)
