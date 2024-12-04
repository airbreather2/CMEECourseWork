#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: Tautocorr.R
# Description: This script performs a statistical analysis to calculate and test the temporal autocorrelation of annual mean temperatures in Key West. It calculates the observed correlation coefficient for consecutive years, performs a permutation test to assess the statistical significance, and visualizes the results with a histogram of permuted correlation coefficients.
# Arguments: None
# Date: Oct 2024

# Usage:
# 
# 
# To run the script:
# Rscript Tautocorr.R
#
# No arguments are required for running this script.

#setting seed for repeatability
set.seed(12345)

rm(list=ls())

load("../data/KeyWestAnnualMeanTemperature.RData")
ls()

class(ats)
head(ats)

plot(ats)


# Step 1: Calculate the observed correlation coefficient
observed_cor <- cor(ats$Temp[-1], ats$Temp[-length(ats$Temp)])
observed_cor

# Step 2: Perform permutation testing
n_permutations <- 10000  # Define the number of permutations
permuted_cors <- numeric(n_permutations)  # To store correlation coefficients from permutations

for (i in 1:n_permutations) {
  # Randomly permute the temperature values
  permuted_temps <- sample(ats$Temp) 
  # Calculate correlation for the permuted time series
  permuted_cors[i] <- cor(permuted_temps[-1], permuted_temps[-length(permuted_temps)])
}

# Step 3: Calculate the approximate p-value
p_value <- sum(permuted_cors >= observed_cor) / n_permutations
p_value


# Display results
cat("Observed correlation coefficient:", observed_cor, "\n")
cat("Approximate p-value:", p_value, "\n")


# Plot histogram of permuted correlations
output_dir <- "../results" # Define the results directory
if (!dir.exists(output_dir)) dir.create(output_dir, recursive = TRUE) # Create directory if it doesn't exist

pdf(file = file.path(output_dir, "Coefficients.pdf"), width = 8, height = 6) # Save the plot as PDF

# Generate the plot
hist(permuted_cors, breaks = 30, col = "lightblue", main = "",
     xlab = "Random correlation coefficients between successive years")
abline(v = observed_cor, col = "red", lwd = 2, lty = 2)
legend("topleft", legend = c("Observed Correlation"), col = "red", lty = 2, lwd = 2)
text(x = max(permuted_cors) - 0.2, 
     y = max(hist(permuted_cors, breaks = 30, plot = FALSE)$counts) * 0.8, 
     labels = expression(italic(p) == "4 × 10"^-4), 
     pos = 4, cex = 1.2)

dev.off()
