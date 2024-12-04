#basic if statement syntax
#if <expr>:
#    <statement>

x = 0; y = 2

if x < y: # "Truthy"
    print('yes')

if x: # no output because x is an integer. #if Y is truthy (not 0 or false or an empty string etc)
    print('yes')

if x==0:
    print('yes')

if y: #if Y is truthy (not 0 or false or an empty string etc)
    print('yes')

if y == 2:
    print('yes')

x = True # make x boolean

if x: # now it works
    print('yes')

if x == True:
    print('yes')