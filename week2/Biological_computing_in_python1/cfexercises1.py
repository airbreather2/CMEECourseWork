
def foo_1(x):
    return x ** 0.5

def foo_2(x, y):
    if x > y:
        return x
    return y

def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo_4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i #the result is resaved and multiplied by the next number in the iteration
    return result

def foo_5(x): # a recursive function that calculates the factorial of x
    if x == 1:
        return 1
    return x * foo_5(x - 1)
     
def foo_6(x): # Calculate the factorial of x in a different way; no if statement involved
    facto = 1
    while x >= 1: # this conditions stops it from being multiplied by 0
        facto = facto * x
        x = x - 1
    return facto

foo_1(5)
foo_2(5 ,3)
foo_3(5, 3, 2) 
foo_4(5) 
foo_5(5) # 
foo_6(5)