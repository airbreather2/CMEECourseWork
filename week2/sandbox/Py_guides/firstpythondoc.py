2 == 2

2 != 2 

3 / 2

3 // 2

'hola, '  + 'me llamo Samraat'
#this will add the strings together
x = 5

x + 3
#8
y = 2 

y + x
#7
x = 'My string'

x + ' now has more stuff'
#a full sentence appears in termnial but original object has not been permenantly ammended 
x + y 

x  + str(y)
#converts y into string for the line
z = '88'

x + z
#My string88 
y + int(z)
#90

#difference between strings and tuples are () and []
MyList = [3,2.44,'green',True]

MyList[1]
#2.44
MyList[0]
#indexing starts at 0 : 3 

MyList[4]
#list index out of range: error

MyList[2] = 'blue'

MyList
#blue has replaced green

MyList.append('a new item')
#adds 'a new item' to list 
MyList

%whos
#gives breakdown of all variables in environment

MyTuple = ("a", "b" , "c")

print(MyTuple)
#prints the tuple

type(MyTuple)
#prints tuple


MyTuple[0]
#'a'

len(MyTuple)
#says the length of the tuple

FoodWeb=[('a','b'),('a','c'),('b','c'),('c','c')]
FoodWeb
#tuples are useful for when you have pairs or triples of items associated with each other that you want to store such that those associations cannot be modified

FoodWeb[0]
#prints ('a','b,')

FoodWeb[0][0]
#prints 'a' 

FoodWeb[0][0]="bbb"
#throws error as tuples are immutable

#however you can change a whole pairing
FoodWeb[0] = ("bbb","ccc")
FoodWeb[0]
#first item in list has been ammended

#tuples are useful as they are immutable
#they have no inbuilt method to append or extend (but can be appended with a bit of extra work)
#you cant remove elements from a tuple 
#take up less memory than lists

#you can however
#find elements in a tuple since it doesn't change it
#use the in operator to check if an element exists in it or iterate over them

a = (1, 2, [])
a
#tuples can be ammended like this

a[2].append(1000)
a
#prints (1,2,[1000])

a[2].append(1000)
a
#prints (1,2,[1000, 1000])

a[2].append((100,10))
a
#prints (1, 2, [1000, 1000, (100, 10)])

#tuples can be concatenated and slices and diced as long as they contain a single sequence or set of items; 

MyTuple = (1, 2, 3)
b = a +(4, 5, 6)
#(1,2,3,4,5,6)

c= b[1:]
c
(2, 3, 4, 5, 6)

c =b[1:]
c 

(2, 3, 4, 5, 6)

b= b[1:]
b
(2, 3, 4, 5, 6)

a = ("1", 2, True)
a

('1', 2, True)

a = [5,6,7,7,7,8,9,9]
b = set(a)
b

#{5, 6, 7, 8, 9}

c = set([3,4,5,6])

b & c #intersection
#output is what both 
#{5, 6}

b | c #union 
{3, 4, 5, 6, 7, 8, 9}

#Dictionaries
#are a set of values (any python object) indexed by keys (string or number). Are a bit like R lists

GenomeSize = {'Homo sapiens': 3200.0, 'Escherichia coli': 4.6, 'Arabidopsis thaliana': 157.0}
GenomeSize #gives
{'Homo sapiens': 3200.0,
 'Escherichia coli': 4.6,
 'Arabidopsis thaliana': 157.0}

GenomeSize['Arabidopsis thaliana']
#157.0

GenomeSize['Saccharomyces cerevisiae'] = 12.1

GenomeSize

GenomeSize['Escherichia coli'] = 4.6 

{'Homo sapiens': 3200.0,
 'Escherichia coli': 4.6,
 'Arabidopsis thaliana': 157.0,
 'Saccharomyces cerevisiae': 12.1}

 GenomeSize['Homo sapiens'] = 3201.1
#homo sapiens was ammended

{'Homo sapiens': 3201.1,
 'Escherichia coli': 4.6,
 'Arabidopsis thaliana': 157.0,
 'Saccharomyces cerevisiae': 12.1}


#copying mutable objects can be tricky because you only create a new variable based on an existing one, Python only creats a reference to the original

a = [1,2,3]

b = a

a.append(4)

print(a)
print(b)
#both [1,2,3,4]

a = [1, 2, 3]
b = a[:] #shallow copy, one level deep

a.append(4)
print(a)
print(b)

#[1,2,3,4]
#[1,2,3]

#complex lists
a = [[1, 2], [3, 4]]
b = a[:]
print(a)
print(b)

#[[1, 2], [3, 4]]
#[[1, 2], [3, 4]]

a[0][1] = 22 # Note how I accessed this 2D list
print(a)
print(b)

#[[1, 22], [3, 4]]
#[[1, 22], [3, 4]]

#b got modified

import copy



a = [[1, 2], [3, 4]]
b = copy.deepcopy(a) #
a[0][1] = 22
print(a)
print(b)

[[1, 22], [3, 4]]
[[1, 2], [3, 4]]





