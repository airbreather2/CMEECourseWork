#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: sample.R
# Description: This script demonstrates various methods for sampling from a population, including loops with and without preallocation, and vectorized functions `sapply` and `lapply`.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines functions that run a sampling experiment multiple times on a population, then compares the time taken by different methods.
#
# To run the script:
# Rscript sample.R
#
# No arguments are required.

######### Functions ##########

#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: sample.R
# Description: This script demonstrates various methods for sampling from a population, including loops with and without preallocation, and vectorized functions `sapply` and `lapply`.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines functions that run a sampling experiment multiple times on a population, then compares the time taken by different methods.
#
# To run the script:
# Rscript sample.R
#
# No arguments are required.

######### Functions ##########

## A function to take a sample of size n from a population "popn" and return its mean
myexperiment <- function(popn, n) {
  pop_sample <- sample(popn, n, replace = FALSE)  # Sample `n` items from `popn` without replacement
  return(mean(pop_sample))  # Return the mean of the sampled values
}

## Calculate means using a FOR loop on a vector without preallocation:
loopy_sample1 <- function(popn, n, num) {
  result1 <- vector()  # Initialize an empty vector
  for(i in 1:num) {
    result1 <- c(result1, myexperiment(popn, n))  # Append each mean to `result1`, resizing each time
    # NOTE: This method is less efficient as the vector grows with each iteration,
    # requiring memory reallocation and copying. This can significantly slow down execution.
  }
  return(result1)  # Return all calculated means
}

## To run "num" iterations of the experiment using a FOR loop on a vector with preallocation:
loopy_sample2 <- function(popn, n, num) {
  result2 <- vector(, num)  # Preallocate vector with expected size `num`
  for(i in 1:num) {
    result2[i] <- myexperiment(popn, n)  # Store each mean at index `i`
    # NOTE: Preallocating the vector avoids repeated memory reallocation, improving performance.
  }
  return(result2)
}

## To run "num" iterations of the experiment using a FOR loop on a list with preallocation:
loopy_sample3 <- function(popn, n, num) {
  result3 <- vector("list", num)  # Preallocate a list of length `num`
  for(i in 1:num) {
    result3[[i]] <- myexperiment(popn, n)  # Store each mean in the list at index `i`
    # NOTE: Preallocating a list can be useful for storing non-homogeneous data structures,
    # although it may use slightly more memory compared to vectors.
  }
  return(result3)
}

## To run "num" iterations of the experiment using vectorization with lapply:
lapply_sample <- function(popn, n, num) {
  result4 <- lapply(1:num, function(i) myexperiment(popn, n))  # Apply `myexperiment` function `num` times
  # NOTE: `lapply` avoids explicit loops, leveraging R's internal optimizations to handle iteration.
  return(result4)
}

## To run "num" iterations of the experiment using vectorization with sapply:
sapply_sample <- function(popn, n, num) {
  result5 <- sapply(1:num, function(i) myexperiment(popn, n))  # Same as lapply but simplifies output to a vector
  # NOTE: `sapply` attempts to simplify the output, making it more compact and efficient for homogeneous data.
  return(result5)
}

# Set random seed for reproducibility
set.seed(12345)
popn <- rnorm(10000)  # Generate a population of 10,000 random values from a normal distribution
hist(popn)  # Plot histogram of population

n <- 100 # Sample size for each experiment
num <- 1000  # Number of times to repeat the experiment

# Measure and print time taken by each method
print("Using loops without preallocation on a vector took:")
print(system.time(loopy_sample1(popn, n, num)))
# NOTE: This is expected to be the slowest method due to repeated memory reallocation.

print("Using loops with preallocation on a vector took:")
print(system.time(loopy_sample2(popn, n, num)))
# NOTE: This method is significantly faster than the previous one due to preallocation.

print("Using loops with preallocation on a list took:")
print(system.time(loopy_sample3(popn, n, num)))
# NOTE: Similar to vector preallocation, but suitable for more complex data types.

print("Using the vectorized sapply function (on a list) took:")
print(system.time(sapply_sample(popn, n, num)))
# NOTE: Vectorized methods like `sapply` are usually faster than explicit loops,
# as they leverage R's optimized internal implementation.

print("Using the vectorized lapply function (on a list) took:")
print(system.time(lapply_sample(popn, n, num)))
# NOTE: `lapply` is similar to `sapply`, but does not simplify the output.
# It is more flexible for heterogeneous data but slightly slower in some cases.
