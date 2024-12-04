#!/bin/bash
# Script: countlines.sh
# Author: Sebastian Dohne (sed24@ic.ac.uk)
# Description: Counts the number of lines in a specified file and prints the result
#
# Arguments: 
#   1 -> input file (any format)
# Output: 
#   Prints the number of lines in the specified file to the console
# Date: Oct 2024
#
# Usage:
#   ./countlines.sh <filename>
#
#   - <filename>: The name of the file you want to count lines for. The file can be in any format (e.g., .txt, .csv, etc.).
#
# Example:
#   ./countlines.sh myfile.txt
#
#   This will print the number of lines in "myfile.txt". If the file does not exist or if more than one argument is provided, the script will show an error message.


# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then 
  echo "Error: You need to provide exactly 1 file"
  exit 1  # Script ends here if condition is true
fi

if [ ! -e "$1" ]; then
    echo "File provided does not exist"
    exit 1
fi

NumLines=`wc -l < $1` #causes the line count command to run using data from variable
echo "The file $1 has $NumLines lines"
echo
