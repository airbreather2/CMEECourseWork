#!/bin/sh
# Author: Your name sed24@ic.ac.uk
# Script: csvtotsv.sh
# Description: Converts a CSV file to a tab-delimited format.
#
# Saves the output into a .txt file
# Arguments: 1 -> tab delimited file
# Date: Oct 2024


echo "Creating a tab-delimited version of $1 ..."


# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then 
  echo "Error: You need to provide exactly 1 file"
  exit 1  # Script ends here if condition is true
fi

if [[ "$1" != *.csv ]]; then
  echo "Error: The file provided is not a CSV file. Please provide a .csv file."
  exit 1  # Script ends here if the file is not a .csv
fi

# Convert the CVS file to tab-delimited
cat $1 | tr -s "," "\t" > $1.txt

echo "Done!"
echo "$1 converted to tab-delimited file"
exit
#appends turns the so all commas are replaced with tabs then echos done!
