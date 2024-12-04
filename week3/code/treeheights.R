#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: treeheights.R
# Description: This script contains a function to calculate the height of a tree given the distance from its base and the angle of elevation to its top.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script defines the `TreeHeight` function, which calculates the height of a tree using the distance and angle of elevation. it loads in trees.csv(a list of trees with headers: Species Distance.m Angle.degrees) and
# creates an output file containing the first two rows of trees with the heights attached as a new column (Species Distance.m Angle.degrees Tree.Height.m)
# 
# To run the script:
# Rscript treeheights.R
#
# No arguments are required for running this script.

# Function to calculate the height of a tree
trees<- read.csv("../data/trees.csv", stringsAsFactors = T)


TreeHeight <- function(degrees, distance) {
  radians <- degrees * pi / 180  # Convert angle from degrees to radians
  height <- distance * tan(radians)  # Calculate height using trigonometric formula
  print(paste("Tree height is:", height))  # Print the height of the tree
  
  return(height)  # Return the calculated height
}


# apply function to data and attach to dataset
trees <- cbind(trees,TreeHeight(trees$Angle.degrees, trees$Distance.m))

#rename column
colnames(trees)[4] <- "Tree.Height.m"

#keep selected rows and headers
final <- trees[c(1:2), ]

print(final)

#save output file
write.csv(final, "../results/TreeHts.csv")

