#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: boilerplate.R
# Description: A boilerplate R script demonstrating how to create and test a simple function that accepts two arguments and prints their types.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines a simple function `MyFunction` that takes two arguments, prints their types, and returns them as a vector.
# 
# To run the script:
# Rscript boilerplate.R
#
# No arguments are required.

# Define a function that prints argument types and returns them
MyFunction <- function(Arg1, Arg2) {
  
  # Statements involving Arg1, Arg2:
  print(paste("Argument", as.character(Arg1), "is a", class(Arg1))) # Print Arg1's type
  print(paste("Argument", as.character(Arg2), "is a", class(Arg2))) # Print Arg2's type
  
  return(c(Arg1, Arg2)) # Return both arguments as a vector (optional but useful)
}

# Test the function with numerical arguments
MyFunction(1, 2)

# Test the function with character arguments
MyFunction("Riki", "Tiki")

# List functions starting with "MyFun"
ls(pattern = "MyFun*")

# Check the class of MyFunction
class(MyFunction)
