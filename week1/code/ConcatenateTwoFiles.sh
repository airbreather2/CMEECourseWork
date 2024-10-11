#!/bin/bash
# Author: Your name sed24@ic.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: Concatenate Two inputed files into an existing third file
#
# Arguments: 2 -> tab delimited file
# Date: Oct 2024

# Check if 2 arguments are provided
if [ "$#" -ne 3 ]; then 
  echo "Error: You need to provide exactly 3 arguments"
  exit 1  # Script ends here if condition is true
fi

cat $1 > $3 #overwrites content of 3 with 1 
cat $2 >> $3 #appends variable 2 to 3
echo "Merged File is"
cat $3 #outputs the merged content of 2 and 3
