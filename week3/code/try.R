#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: try.R
# Description: This script demonstrates handling errors in R when calculating the mean of a sample from a population. The `try` function is used to continue running even when errors occur due to insufficient unique values in a sample.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines a function `doit` to calculate the mean of a sampled population if the sample size is sufficient. 
# It demonstrates handling errors by applying `doit` with `lapply` and capturing errors using `try`.
#
# To run the script:
# Rscript try.R
#
# No arguments are required.

# Define a function that samples a population and calculates the mean if sample has more than 30 unique values
doit <- function(x) {
  temp_x <- sample(x, replace = TRUE)
  if(length(unique(temp_x)) > 30) {  # Only take the mean if sample has sufficient unique values
    print(paste("Mean of this sample was:", as.character(mean(temp_x))))
  } 
  else {
    stop("Couldn't calculate mean: too few unique values!")  # Raise an error if insufficient unique values
  }
}

# Set a seed for reproducibility
set.seed(1345)

# Generate a population of 50 random values from a normal distribution
popn <- rnorm(50)
hist(popn)

# Attempt to calculate means for multiple samples with insufficient unique values
# Uncomment the line below to see error messages due to insufficient unique values
# lapply(1:15, function(i) doit(popn))

# Use `try` to suppress errors and capture them in the result
result <- lapply(1:15, function(i) try(doit(popn), FALSE))

# Check the class of `result` to confirm it includes both successful results and errors
class(result)

# Print the result to inspect successes and stored errors
result

# Store the results in a manually initialized list
result <- vector("list", 15)  # Preallocate list for results
for(i in 1:15) {
  result[[i]] <- try(doit(popn), FALSE)  # Store each attempt with error handling
}

