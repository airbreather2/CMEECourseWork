#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: Control_flow.R
# Description: This script demonstrates basic control flow structures in R such as conditional statements, for loops, and while loops. It also illustrates how to source another R script.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script showcases examples of conditional statements, for loops, while loops, and sourcing another script.
# 
# To run the script:
# Rscript Control_flow.R
#
# No arguments are required.

# Dependencies:
# Ensure the sourced file "Control_flow.R" exists in the working directory.

# Set working directory (modify the path as needed)
setwd("./Documents/CMEECourseWork/week3/code/")

# Example of a simple conditional statement
a <- TRUE
if (a == TRUE) {
  print ("a is TRUE")
} else {
  print ("a is FALSE")
}

# Conditional statement in a single line
z <- runif(1)  # Generate a uniformly distributed random number
if (z <= 0.5) {print ("Less than a half")}

# More readable format for conditional statement
z <- runif(1)
if (z <= 0.5) {
  print ("Less than a half")
}

# Loop over a range of numbers, squaring each, and printing the result
for (i in 1:10) {
  j <- i * i
  print(paste(i, " squared is", j))
}

# Loop over a vector of strings
for (species in c('Heliodoxa rubinoides', 
                  'Boissonneaua jardini', 
                  'Sula nebouxii')) {
  print(paste('The species is', species))
}

# Loop over a pre-existing vector
v1 <- c("a", "bc", "def")
for (i in v1) {
  print(i)
}

# Example of a while loop that runs until a condition is met
i <- 0
while (i < 10) {
  i <- i + 1
  print(i^2)
}

# Sourcing another script
# source("Control_flow.R")


