import csv
import sys

def is_an_oak(name):
    """ 
    Returns True if the name starts with 'quercus '  

    Examples:
    >>> is_an_oak('Fagus sylvatica') 
    False

    >>> is_an_oak('Quercus sylvatica'')
    True

    >>> is_an_oak('Quercuss sylvatica') 
    False
    """
    
    return name.lower().startswith('quercus ') #space ensures only input accepted is quercus

print(str(is_an_oak('Quercuss sylvatica')) + " test complete" + '\n')
#gives false


def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    next(taxa)
    oaks = set()
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