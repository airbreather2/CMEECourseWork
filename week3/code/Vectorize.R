#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: Vectorise.R
# Description: This script compares the execution time of summing all elements in a matrix using a custom nested loop function vs. R's built-in vectorized sum function.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script generates a 1000x1000 matrix with random values and measures the time required to sum all elements using both a custom function and the built-in `sum()` function.
# 
# To run the script:
# Rscript Vectorise.R
#
# No arguments are required.

# Initialize a variable
a <- 1.0
class(a)
# R automatically assigns this as a float. In other languages, data types would need to be explicitly defined.
# R compartmentalizes code for efficiency, especially with numeric data types.

# Creating a 1000x1000 matrix with 1,000,000 random values between 0 and 1
M <- matrix(runif(1000000), 1000, 1000)

# Function to sum all elements of a matrix using nested loops
SumAllElements <- function(M) {
  Dimensions <- dim(M)  # Get the dimensions of the matrix (rows and columns)
  Tot <- 0  # Initialize the total sum
  for (i in 1:Dimensions[1]) {  # Loop over each row
    for (j in 1:Dimensions[2]) {  # Loop over each column
      Tot <- Tot + M[i, j]  # Add each element to the total sum
    }
  }
  return(Tot)  # Return the total sum
}

# Measure the time taken to sum all elements using the custom function with loops
print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))  # system.time measures the execution time

# Measure the time taken to sum all elements using R's built-in vectorized sum function
print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))  # The built-in sum function is optimized and generally faster

