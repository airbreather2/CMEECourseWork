#Variables created inside of functions are invisible outside of it and don't persist when function is returned
#they are local variables 

i = 1
x = 0
for i in range(10):
    x += 1
print(i)
print(x)

i, x # or print(i, x)
# (9, 10)
#they were saved to the main workspace because they exited outside of the loop

i = 1
x = 0
def a_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x
a_function(10)
print(i)
print(x)
# prints 1 and 0 as it is outside of the environment

i = 1
x = 0
def b_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x
#running this in the command line shows that b_function exists in workspace
b_function(10) # returns 10
#x however remains unchanged outside of the function

#to change it globally you must "catch it" doing this: 
# x = a_function(10)
#printing x gives 10 

i = 1
x = 0
def b_function(y):
    x = 0
    for i in range(y):
        x += 1
    return x,y

result = b_function(6)
print(result)
#prints 6,6