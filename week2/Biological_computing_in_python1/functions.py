#set the variable
def foo(x):
    x *= x # same as x = x*x
    print (x)
    #return x
# call the function 
foo(7)

y = foo(2)
type(y)
#gives back 4, int

def foo(x):
    x *= x # same as x = x*x
    print (x)
    # return x   

y = foo(2)
type(y) # commenting out return will mean that function no longer returns the computed value, 4 will be printed but varible y will hold none

