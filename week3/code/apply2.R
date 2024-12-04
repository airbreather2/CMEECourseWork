#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: apply2.R
# Description: This script demonstrates the use of `apply` with a custom function to modify matrix rows based on a condition.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines a custom function `SomeOperation`, which multiplies a vector by 100 if its sum is greater than zero.
# It then applies this function across each row of a 10x10 matrix of random numbers.
#
# To run the script:
# Rscript apply2.R
#
# No arguments are required.

# Define a custom function that checks the sum of the vector `v`
SomeOperation <- function(v) {  # Takes a vector `v` as input
  if (sum(v) > 0) {  # If the sum of the elements in `v` is positive
    return(v * 100)  # Multiply each element by 100
  } else {
    return(v)  # Otherwise, return `v` unchanged
  }
}

# Create a 10x10 matrix with random values from a standard normal distribution
M <- matrix(rnorm(100), 10, 10)

# Apply the custom function `SomeOperation` to each row of the matrix `M`
print(apply(M, 1, SomeOperation))
# The `apply` function passes each row (as a vector) to `SomeOperation`, and the result is printed.

