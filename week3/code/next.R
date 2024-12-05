#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: next.R
# Description: This script demonstrates the use of the 'next' statement within a for loop to skip iterations when a condition is met.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script showcases how the 'next' statement can be used to skip over iterations in a for loop in R. useful if you require odd numbers.
# 
# To run the script:
# Rscript next.R
#
# No arguments are required.

# Example of a for loop with 'next' to skip even numbers
for (i in 1:10) {
  if ((i %% 2) == 0)  # Check if the number is even
    next  # Skip to the next iteration if the number is even
  print(i)  # Print the odd numbers
}

# The 'next' statement skips over an iteration if a condition is met (in this case, if the number is even)

