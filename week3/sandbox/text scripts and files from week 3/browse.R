#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: browse.R
# Description: This script simulates exponential growth using a custom function and includes a debugging point with the `browser()` function.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines an exponential growth model with a debugging point inside a loop.
# Running this script will enter browser mode during the first iteration, allowing you to inspect variables.
#
# To run the script:
# Rscript browse.R
#
# No arguments are required.

# Define an exponential growth function
Exponential <- function(N0 = 1, r = 1, generations = 10) {
  # Runs a simulation of exponential growth
  # Returns a vector of length `generations`
  
  N <- rep(NA, generations)  # Creates a vector `N` of NA values for `generations` elements
  
  N[1] <- N0  # Initialize the first generation with `N0`
  for (t in 2:generations) {  # Loop through each generation starting from the second
    N[t] <- N[t-1] * exp(r)  # Calculate population size with exponential growth formula
    browser()  # Enter debugging mode, allowing inspection of variables at this point
  }
  return(N)  # Return the vector of population sizes across generations
}

# The script will run until the first iteration of the loop, then enter the browser mode for debugging

# Plot the results of the exponential growth model
plot(Exponential(), type="l", main="Exponential growth")
