my_iterable = [1,2,3]   

type(my_iterable)
#list

my_iterator = iter(my_iterable)

type(my_iterator)
# list iterator

next(my_iterator) # same as my_iterator.__next__()
#1

next(my_iterator) # same as my_iterator.__next__()
#2
#and so on until 3 
next(my_iterator) 
#3
#Once you've raised all items in an iterator and no more data is available a stop iteration is raised

#difference between iterator and generator
#Every iterator is not a generator, but every generator is an iterator

# FOR loops
for i in range(5):
    print(i)
#prints 0 to 4
my_list = [0, 2, "geronimo!", 3.0, True, False]
for k in my_list:
    print(k)
#prints all items individually
total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands:
    total = total + s
    print(total)
#adds everything together in the list in sequence
# WHILE loop
z = 0
while z < 100:
    z = z + 1
    print(z)
#prints up to 100

