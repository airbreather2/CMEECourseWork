#!/bin/bash
#!/bin/sh
# Author: Your name sed24@ic.ac.uk
# Script: MyExampleScript.sh
# Description: This script converts all .tif files in the current directory to .png format.
# Date: Oct 2024

# Check if every file in the current directory has a .tif extension

for file in *; do
  if [[ "$file" != *.tif ]]; then
    echo "Error: At least one file in the directory is not a .tif file. Please check directory."
    exit 1  # Exit if a non-.tif file is found
  fi
done


# Loop through each.tif file in the current directory
for f in *.tif; 
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).png"; #converts tif to png 
    done
