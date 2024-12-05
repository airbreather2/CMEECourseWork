#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: R_conditionals.R
# Description: This script contains three functions to check if a number is even, a power of 2, or a prime number.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines three functions:
# 1. `is.even`: Checks if a number is even.
# 2. `is.power2`: Checks if a number is a power of 2.
# 3. `is.prime`: Checks if a number is a prime.
#
# To run the script:
# Rscript R_conditionals.R
#
# No arguments are required for running this script.



# Function to check if a number is even
# Arguments:
#   n: A numeric value to check for evenness.
# Returns:
#   A string indicating whether the number is even or odd.

# Function to check if a number is even
is.even <- function(n = 2) {
  if (n %% 2 == 0) {
    return(paste(n, 'is even!'))
  } else {
    return(paste(n, 'is odd!'))
  }
}

# Test the function
print(is.even(6))

# Function to check if a number is a power of 2
# Arguments:
#   n: A numeric value to check if it is a power of 2.
# Returns:
#   A string indicating whether the number is a power of 2.
is.power2 <- function(n = 2) {
  if (log2(n) %% 1 == 0) {
    return(paste(n, 'is a power of 2!'))
  } else {
    return(paste(n, 'is not a power of 2!'))
  }
}

# Test the function
print(is.power2(8))

# Function to check if a number is prime
# Arguments:
#   n: A numeric value to check for primality.
# Returns:
#   A string indicating whether the number is prime or composite, or a specific case for 0 and 1.
is.prime <- function(n) {
  if (n == 0) {
    return(paste(n, 'is zero!'))  # Statement to signify 0
  } else if (n == 1) {
    return(paste(n, 'is just a unit!'))  # Statement for 1
  }
  
  ints <- 2:(n-1)  # Creates a range from 2 to n-1
  
  if (all(n %% ints != 0)) {  # Checks if n is divisible by any number in the range
    return(paste(n, 'is a prime!'))
  } else {
    return(paste(n, 'is a composite!'))
  }
}

# Test the function
print(is.prime(14))




