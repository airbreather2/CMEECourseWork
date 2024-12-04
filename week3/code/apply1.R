#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: apply1.R
# Description: This script creates a random matrix and demonstrates the use of the `apply` function to calculate row and column means and variances.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script generates a 10x10 matrix with random values and calculates:
# 1. The mean of each row.
# 2. The variance of each row.
# 3. The mean of each column.
#
# To run the script:
# Rscript apply1.R
#
# No arguments are required.

## Build a random matrix
M <- matrix(rnorm(100), 10, 10)
# Creates a 10x10 matrix `M` filled with 100 random numbers from a standard normal distribution (mean = 0, sd = 1).

## Take the mean of each row
RowMeans <- apply(M, 1, mean)
print(RowMeans)
# Uses `apply` to calculate the mean of each row in matrix `M`.
# The `1` argument specifies row-wise operation.
# Stores the row means in `RowMeans` and prints them.

## Now the variance
RowVars <- apply(M, 1, var)
print(RowVars)
# Uses `apply` to calculate the variance of each row in matrix `M`.
# The `1` argument specifies row-wise operation.
# Stores the row variances in `RowVars` and prints them.

## By column
ColMeans <- apply(M, 2, mean)
print(ColMeans)
# Uses `apply` to calculate the mean of each column in matrix `M`.
# The `2` argument specifies column-wise operation.
# Stores the column means in `ColMeans` and prints them.

