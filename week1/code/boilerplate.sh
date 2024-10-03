#!/bin/sh
# Author: Your Name your.login@imperial.ac.uk
# Script: boilerplate.sh
# Desc: simple boilerplate for shell scripts
# Arguments: none
# Date: Oct 2019

echo -e "\nThis is a shell script! \n"

#exit

echo "the arguments are $#" 
echo "the arguments are $0"
echo "the arguments are $@"
echo "the arguments are $1"
echo "the arguments are $2"    

MY_VAR='SOME STRING'
echo 'the current value of the variable is:' $MY_VAR
echo
echo 'Please enter a new string' 
MY_VAR='POOPDECK'
read MY_VAR
echo
echo 'the current value of the variable is:' $MY_VAR
echo
