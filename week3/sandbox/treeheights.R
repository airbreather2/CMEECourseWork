#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: treeheights.R
# Description: This script contains a function to calculate the height of a tree given the distance from its base and the angle of elevation to its top.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines the `TreeHeight` function, which calculates the height of a tree using the distance and angle of elevation.
# 
# To run the script:
# Rscript treeheights.R
#
# No arguments are required for running this script.

# Function to calculate the height of a tree
TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180  # Convert angle from degrees to radians
  height <- distance * tan(radians)  # Calculate height using trigonometric formula
  print(paste("Tree height is:", height))  # Print the height of the tree
  
  return(height)  # Return the calculated height
}

trees <- read.table("../data/trees.csv", sep = ',', header = TRUE) #another way
head(trees)

# Test the function
TreeHeight(37, 40)


