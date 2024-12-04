#!/bin/bash
#!/bin/sh
# Author: Your name sed24@ic.ac.uk
# Script: tiff2png.sh
# Description: This script converts all .tif files in the current directory to .png format.
# Date: Oct 2024

# Usage Instructions:
# This script converts all .tif files in the current directory to .png format using the `convert` command.
#
# Requirements:
# - ImageMagick (or similar tool providing the `convert` command) must be installed.
# 
# To run the script:
# 1. Navigate to the directory containing the .tif files.
# 2. Run the script using: tiff2png.sh
#
# The script will check if any .tif files are present before proceeding with the conversion.

# Check if there are any .tif files using compgen
if compgen -G "*.tif" > /dev/null; then
    # Conversion code here
    for f in *.tif; 
    do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).png"; # Converts tif to png using ImageMagick's convert command
    done
else
    echo "No .tif files found in the current directory. Exiting."
fi

