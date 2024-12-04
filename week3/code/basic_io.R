#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: basic_io.R
# Description: A simple script to illustrate R input-output operations.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script demonstrates basic input-output functions in R.
# It reads data from a CSV file, writes it to another file, and performs various output manipulations such as appending data, writing with row names, and omitting column names.
#
# To run this script:
# 1. Make sure the working directory and file paths are correct.
# 2. Execute the script by running it in an R environment or using the command:
# Rscript basic_io.R.R
#
# Dependencies:
# This script requires an existing CSV file (../data/trees.csv) to be available in the specified location.
#
# Output:
# The script creates and modifies files in the ../results/ directory.

# Set working directory
setwd("./Documents/CMEECourseWork/week3/code")  # Relative to current working directory

# Read data from CSV file
MyData <- read.csv("../data/trees.csv", header = TRUE) # Import CSV with headers

# Write data to new CSV file
write.csv(MyData, "../results/MyData.csv") # Write data to a new file

# Append a specific row to the CSV file
write.table(MyData[1,], file = "../results/MyData.csv", append=TRUE) # Append the first row of MyData

# Write data with row names
write.csv(MyData, "../results/MyData.csv", row.names=TRUE) # Include row names in the output file

# Write data without column names
write.table(MyData, "../results/MyData.csv", col.names=FALSE) # Omit column names in the output file

# Print completion message
print("Script complete!")

# Command for running the script and creating an output file:
# R CMD BATCH IOR_Script.R MyResults.Rout
