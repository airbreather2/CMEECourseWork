#!/bin/sh
# Author: Your name sed24@ic.ac.uk
# Script: MyExampleScript.sh
# Description: The script greets the user running the script twice, using both a combination of variables.
# Date: Oct 2024

# Usage Instructions:
# This script prints a greeting to the user running the script using the environment variable $USER.
# 
# To run the script:
# MyExampleScript.sh
#
# No arguments are required. The script will automatically retrieve and use the current system username.


MSG1="Hello"
MSG2=$USER #uses user as a variable
echo "$MSG1 $MSG2"
echo "Hello $USER"
echo	

