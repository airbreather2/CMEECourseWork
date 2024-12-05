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

while(i < Inf){  # Start a loop that will theoretically run forever, as Inf represents infinity.
  if (i == 10){  # Check if the current value of i is equal to 10.
    print("break reached, loop will exit")
    break  # If i is 10, exit the loop immediately.
  } else {
    # Print the current value of i with a message. The cat function is used for concatenation and printing.
    cat("i equals ", i , "\n")
    i <- i + 1  # Increment the value of i by 1 to move to the next iteration.
  }
}


# The script prints values of i from 0 to 9 until the break condition (i == 10) is met



