x = [i for i in range(10)]
print(x)
#[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

#is the same as
x = []
for i in range(10):
    x.append(i)
print(x)

x = [i.lower() for i in ["LIST","COMPREHENSIONS","ARE","COOL"]]
print(x)
#prints: ['list', 'comprehensions', 'are', 'cool']

#is the same as

x = ["LIST","COMPREHENSIONS","ARE","COOL"]
for i in range(len(x)): # explicit loop (for every element in the range of the length of x (4))
    x[i] = x[i].lower()
print(x)

#below also works
x = ["LIST","COMPREHENSIONS","ARE","COOL"]
x_new = []
for i in x: # implicit loop
    x_new.append(i.lower())
print(x_new)

matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = []
for row in matrix: #for each row in the matrix 
    for n in row: # for every element in row
        flattened_matrix.append(n) #add every element in every row to the flattened matrix
print(flattened_matrix)
#[1, 2, 3, 4, 5, 6, 7, 8, 9]

#below does the same
matrix = [[1,2,3],[4,5,6],[7,8,9]]
flattened_matrix = [n for row in matrix for n in row]
print(flattened_matrix)

words = ["These", "are", "some", "words"]

first_letters = set()
for w in words:
    first_letters.add(w[0]) #as indicies start at 0 it adds the first letter of every word

print(first_letters)

type(first_letters)
#{'T', 'w', 's', 'a'} sets are unordered
#set

