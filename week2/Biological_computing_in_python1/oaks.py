## Finds just those taxa that are oak trees from a list of species

taxa = [ 'Quercus robur',
         'Fraxinus excelsior',
         'Pinus sylvestris',
         'Quercus cerris',
         'Quercus petraea',
       ]

def is_an_oak(name):
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