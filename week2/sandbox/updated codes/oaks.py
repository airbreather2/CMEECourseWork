#!/usr/bin/env python3

"""
Description: This script identifies oak species (those that start with 'Quercus ') 
from a given list of taxa using both for loops and list comprehensions. 
Additionally, it prints the oak species names in uppercase using both methods.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = '[oaks.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"



## Finds just those taxa that are oak trees from a list of species

taxa = [ 'Quercus robur',
         'Fraxinus excelsior',
         'Pinus sylvestris',
         'Quercus cerris',
         'Quercus petraea',
       ]

def is_an_oak(name):
    
    """
    Returns True if the given species name starts with 'quercus ' (case-insensitive).
    
    Parameters:
    name (str): The species name to check.

    Returns:
    bool: True if the name starts with 'quercus ', otherwise False.
    """
    
    return name.lower().startswith('quercus ')


##Using for loops
oaks_loops = set()
for species in taxa: # iterates over each species in taxa 
    if is_an_oak(species): #if identified as oak by function above 
        oaks_loops.add(species) #is added to oaks.loop set 
print(oaks_loops) 

##Using list comprehensions   
oaks_lc = set([species for species in taxa if is_an_oak(species)]) #expression (what u want to include in list) for item in iterable (iterates over each item in list) if condition is met
print(oaks_lc)

##Get names in UPPER CASE using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

##Get names in UPPER CASE using list comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)