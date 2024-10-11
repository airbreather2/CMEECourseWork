#!/bin/bash
# Script: countlines.sh
#Author: Sebastian Dohne (sed24@ic.ac.uk)
# Description: Counts the number of lines in a specified file and prints the result
#
# Arguments: 1 -> input file (any format)
# Output: prints the number of lines in the specified file to the console
# Date: Oct 2024


# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then 
  echo "Error: You need to provide exactly 1 file"
  exit 1  # Script ends here if condition is true
fi

NumLines=`wc -l < $1` #causes the line count command to run using data from variable
echo "The file $1 has $NumLines lines"
echo
