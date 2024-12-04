#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: preallocate.R
# Description: This script compares the time efficiency of a non-preallocated vector approach with a preallocated vector approach in R, demonstrating the impact of preallocation on performance.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines two functions:
# 1. `NoPreallocFun`: A function that grows a vector within a loop without preallocation.
# 2. `PreallocFun`: A function that grows a vector with preallocation.
#
# To run the script:
# Rscript preallocate.R
#
# No arguments are required for running this script.

# Inbuilt sum function is about 100 times faster as it is built in a lower-level language.

# Below is a loop function that repeatedly resizes a vector, making it slow.

NoPreallocFun <- function(x) {
  a <- vector()  # Initialize an empty vector
  for (i in 1:x) {
    a <- c(a, i)  # Concatenate elements to `a` (resizing each iteration)
    print(a)  # Print current state of the vector
    print(object.size(a))  # Print the size of the object in memory
  }
}

# Measure time taken by the non-preallocated function
system.time(NoPreallocFun(1000))

# Preallocation of vectors speeds this up by avoiding repeated resizing.
PreallocFun <- function(x) {
  a <- rep(NA, x)  # Pre-allocate a vector of length `x`
  for (i in 1:x) {
    a[i] <- i  # Assign each element to the preallocated vector
    print(a)  # Print current state of the vector
    print(object.size(a))  # Print the size of the object in memory
  }
}

# Measure time taken by the preallocated function, which is much faster
system.time(PreallocFun(1000))





