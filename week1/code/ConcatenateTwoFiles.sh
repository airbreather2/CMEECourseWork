#!/bin/bash
# Author: Your name sed24@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: Concatenate two input files into an existing third file
#
# Arguments: 3 -> Two input files and one existing output file
# Date: Oct 2024
#
# Usage:
#   ./ConcatenateTwoFiles.sh file1.txt file2.txt outputfile.txt
# 
# The script concatenates the contents of file1.txt and file2.txt into outputfile.txt.
# - The contents of file1.txt will overwrite the contents of outputfile.txt.
# - The contents of file2.txt will then be appended to outputfile.txt.
# 
# Ensure that all three arguments (input files and output file) are provided.

# Check if 2 arguments are provided
if [ "$#" -ne 3 ]; then 
  echo "Error: You need to provide exactly 3 arguments"
  exit 1  # Script ends here if condition is true
fi

# Check if the output file exists
if [ -e "$3" ]; then
  # Ask for user confirmation before overwriting
  read -p "Warning: $3 already exists. Do you want to overwrite it? (y/n): " choice
  if [ "$choice" != "y" ]; then
    echo "Operation canceled."
    exit 1  # Exit if the user chooses not to overwrite
  fi
fi

cat $1 > $3 #overwrites content of 3 with 1 
cat $2 >> $3 #appends variable 2 to 3
echo "Merged File is"
cat $3 #outputs the merged content of 2 and 3
