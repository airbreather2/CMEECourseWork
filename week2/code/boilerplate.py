#!/usr/bin/env python3 
#the above shebang specifies the location to the python executable that the rest of the script needs to be interpreted with

"""Description of this program or application.
You can use several lines""" #docstrings allow you to describe an operation of the script or a function/module within it

__appname__ = '[boilerplate.py]'
__author__ = 'Sebastian Dohne (sed24@ic.ac.uk)'
__version__ = '3.12.3'



######################## imports ########################################
import sys # module to interface our program with the operating system

##########################################################################

## constants ##


## functions ##
def main(argv):
    """
    Main entry point of the program.
    
    Args:
        argv (list of str): Command-line arguments.
    
    Returns:
        int: Exit status (0 for success).
    """
    print('This is a boilerplate')  # NOTE: indented using two tabs or 4 spaces
    return 0

if __name__ == "__main__":
    """
    Executes the main function when the script is run directly.
    """
    status = main(sys.argv)
    sys.exit(status)

#sys.exit(status)
#this is how to terminate the python programme in an explicit manner returning an status code


    #This is the main function. Arguments obtained in the if (__name__ == "__main__"): part of the script are “fed” to 
    #this main function where the printing of the line “This is a boilerplate” happens.


