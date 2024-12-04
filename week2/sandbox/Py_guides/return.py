#arguments are passed to a function by assignment, for lists if a function modifies the mutable variable inside 
#the original variable outside the function remains unchanged
def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)

my_list = [1, 2, 3]

print('before, my_list =', my_list)
before, my_list = [1, 2, 3]

modify_list_1(my_list)
#got [1, 2, 3]
#set to [1, 2, 3, 4]

print('after, my_list =', my_list)
#after, my_list = [1, 2, 3]

#stays the same

def modify_list_2(some_list):
    print('got', some_list)
    some_list = [1, 2, 3, 4]
    print('set to', some_list)
    return some_list

my_list = modify_list_2(my_list)

#got [1, 2, 3]
#set to [1, 2, 3, 4]

print('after, my_list =', my_list)
#after, my_list = [1, 2, 3, 4]


#if we want to modify original list

def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4) # an actual modification of the list
    print('changed to', some_list)

my_list = [1, 2, 3]

print('before, my_list =', my_list)

#before, my_list = [1, 2, 3]

modify_list_3(my_list)

#got [1, 2, 3]
#changed to [1, 2, 3, 4]

print('after, my_list =', my_list)
#after, my_list = [1, 2, 3, 4]

