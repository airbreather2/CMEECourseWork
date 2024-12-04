#!/bin/sh
# Author: Your name sed24@ic.ac.uk
# Script: tabtocsv.sh
# Description: Converts a tab-delimited file to a comma-separated file (CSV format) 
# by replacing all tabs with commas.
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2024


echo "Creating a comma-delimited version of $1 ..."

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then 
  echo "Error: You need to provide exactly 1 file"
  exit 1  # Script ends here if condition is true
fi

#check provided file is txt file
if [[ "$1" != *.txt  ]]; then
  echo "Error: Only tab-delimited files with .txt extensions are accepted."
  exit 1  # Script ends here if the file is not a .csv
fi

# Check if the output CSV file already exists
if [ -e "$1.csv" ]; then
    echo "Error: $1.csv already exists. Conversion aborted to avoid overwriting."
    exit 1
else
    # Convert the tab-delimited file to comma-delimited CSV format
    cat "$1" | tr -s "$(printf '\t')" "," >> "$1.csv"
    echo "Conversion successful: $1.csv has been created."
fi
