#!/bin/sh
#!/bin/sh
# Author: Your name sed24@ic.ac.uk
# Script: variables.sh
# Desc: Illustrates the use of variables in multiple ways
# Date: Oct 2024

# Usage: 
# This script demonstrates the use of variables in a shell script.
# It showcases special variables, how to assign variables, and how to take user input.
#
# To run the script:
# ./variables.sh [arg1] [arg2]
# arg1: The first argument passed to the script (optional)
# arg2: The second argument passed to the script (optional)
#
# Example:
# variables.sh "hello" "world"
# This will print the first and second arguments as "hello" and "world" respectively.
#
# The script will also prompt the user to enter a string and two numbers to demonstrate variable assignment and simple arithmetic operations.

# Special variables


# Special variables

echo "This script was called with $# parameters" #prints number of parameters passed to script
echo "The script's name is $0" #prints the name of the script
echo "The arguments are $@" #lists the number of arguments passed to script as a string
echo "The first argument is $1" #Prints first argument passed to the script 
echo "The second argument is $2" #Prints second argument passed to the script

# Assigned Variables; Explicit declaration:
MY_VAR='some string' #assigns variable with a string value 'some string'
echo 'the current value of the variable is:' $MY_VAR #prints current value of the variable
echo
echo 'Please enter a new string'
read MY_VAR  
#read allows one to enter a new string
echo
echo 'the current value of the variable is:' $MY_VAR 
echo

## Assigned Variables; Reading (multiple values) from user input:
echo 'Enter two numbers separated by space(s)' 
read a b
#allows user to input 2 numbers and for them to be summed
echo
echo 'you entered' $a 'and' $b '; Their sum is:'

## Assigned Variables; Command substitution
MY_SUM=$(($a + $b))
echo $MY_SUM
