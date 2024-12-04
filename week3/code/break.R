#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: break.R
# Description: This script demonstrates a simple while loop that runs until a break condition is met.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script showcases how a while loop can be used in R, printing a value until a specific break condition is met.
# 
# To run the script:
# Rscript break.R
#
# No arguments are required.

# Example of a while loop that breaks when i reaches 10
i <- 0  # Initialize i

while(i < Inf){  # Loop until i reaches infinity (or until break)
  if (i == 10){
    break  # Exit the loop when i equals 10
  } else {
    # Print the value of i
    cat("i equals ", i , "\n")
    i <- i + 1  # Update i
  }
}

# The script prints values of i from 0 to 9 until the break condition (i == 10) is met



