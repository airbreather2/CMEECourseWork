#!/usr/bin/env python3
# Filename: using_name.py

if __name__ == '__main__':
    print('This program is being run by itself!') 
else:
    print('I am being imported from another script/program/module!')

print("This module's name is: " + __name__)

#doing: %run using_name.py
#This program is being run by itself!
#This module's name is: __main__

#doing import using_name
#I am being imported from another script/program/module!
#This module's name is: using_name

