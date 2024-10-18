"""
Description: This script filters species names in a CSV file, identifying those 
belonging to the Quercus genus (oak trees), and writes them to a new CSV file. 
It reads from an input file, processes the data, and saves the results to an output file.
Additionally, it includes a function with built-in tests using doctest.

Author: Sebastian Dohne (sed24@ic.ac.uk)
Version: 0.0.1
License: License for this code/program
"""

__appname__ = 'oaks_debugme.py'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"



import csv
import sys
import doctest


def is_an_oak(name):
    """ 
    Returns True if the name starts with 'quercus or Quercus'  

    Examples:
    >>> is_an_oak('Fagus sylvatica') 
    False

    >>> is_an_oak('Quercus sylvatica')
    True

    >>> is_an_oak('Quercuss sylvatica') 
    False
    """
    return name.split()[0] in ('quercus', 'Quercus') 

#print(str(is_an_oak('Quercuss sylvatica')) + " test complete" + '\n')
#gives false


    
def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../Results/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    
    next(taxa) #skips 'genus' and 'species' headers
    
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    
    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)
 

doctest.testmod()