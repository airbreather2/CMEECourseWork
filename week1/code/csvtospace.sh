#!/bin/sh
# Author: Your name sed24@ic.ac.uk
# Script: tabtospace.sh
# Description: Takes a comma-separated values file and converts it to a space-separated format
#
# Saves the output into a .txt file
# Arguments: 1 -> comma-separated input file (any extension, e.g., .csv)
# Output: a space-delimited .txt file
# Date: Oct 2024

echo "Creating a space-delimited version of $1 ..."

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then 
  echo "Error: You need to provide exactly 1 file"
  exit 1  # Script ends here if condition is true
fi

#Check if file provided is in csv format
if [[ "$1" != *.csv ]]; then
  echo "Error: The file provided is not a CSV file. Please provide a .csv file."
  exit 1  # Script ends here if the file is not a .csv
fi

# Check if the output file already exists
if [ -e "$1.txt" ]; then
    echo "Error: $1.txt already exists. Conversion aborted to avoid overwriting."
    exit 1
else
    # Convert the CSV file to space-delimited
    cat "$1" | tr "," " " >> "${1%.csv}_spacedelimited.txt"
fi

# Success message
echo "Done!"
echo "$1 converted to space-delimited file"

