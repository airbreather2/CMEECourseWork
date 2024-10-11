
######################## for every value from 1 - 12 if the value is dividibe by 3 print hello, and prints a blank space at end
def hello_1(x):
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')

hello_1(12)

######################## #if the remainder of dividing by 5 is 3 or if divided by 4 is 3 print hello
def hello_2(x):
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')

hello_2(12)

######################## #prints hello for every integer between the range of 3 to 17 
def hello_3(x, y):
    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)

######################## #why x doesn't equal 15m print hello then add 3 to x
def hello_4(x):
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')

hello_4(0)

######################## #prints hello once when x == 18 and hello 7 times when x == 31, basically won't print anything if x is below 31 
def hello_5(x):
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')

hello_5(12)

# WHILE loop with BREAK #prints the string hello! followed by a number until the y == 6 is reached if x is set as true 
def hello_6(x, y):
    while x: # while x is True
        print("hello! " + str(y))
        y += 1 # increment y by 1 
        if y == 6:
            break
    print(' ')

hello_6 (True, 0)