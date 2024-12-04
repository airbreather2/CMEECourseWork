#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: Girko_plot.R
# Description: This script generates a plot of eigenvalues overlaid on an ellipse, representing a circular distribution of eigenvalues. The plot is saved as a PDF.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script calculates eigenvalues of a random matrix, constructs an ellipse based on matrix size, and visualizes the results in a PDF plot.
# It creates a `results` directory (if it doesn't exist) and saves the output file as `Girko.pdf` in that directory.

# Dependencies:
# Requires the `tidyverse` package for data manipulation and plotting. Install it if not already installed:
# install.packages("tidyverse")

# To run the script:
# Rscript Girko.R
#
# The script will:
# 1. Create a `results` directory (if it does not exist).
# 2. Generate an ellipse and plot eigenvalues overlaid on it.
# 3. Save the plot as `Girko.pdf` in the `results` directory.

# Create the results directory if it does not exist
if (!dir.exists("../results")) {
  dir.create("../results")
}

pdf("../results/Girko.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches

require(tidyverse)

build_ellipse <- function(hradius, vradius) { # function that returns an ellipse
  npoints = 250 # Define the number of points for smoothness
  a <- seq(0, 2 * pi, length = npoints + 1) # Generate angles for ellipse points
  x <- hradius * cos(a) # Calculate x-coordinates
  y <- vradius * sin(a)  # Calculate y-coordinates
  return(data.frame(x = x, y = y)) # Return data frame of ellipse points
}

N <- 250 # Assign size of the matrix

M <- matrix(rnorm(N * N), N, N) # Generate an N x N matrix of random values

eigvals <- eigen(M)$values # Calculate the eigenvalues of matrix M

eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals)) # Build a data frame with real and imaginary parts

my_radius <- sqrt(N) # Set radius of the ellipse to sqrt(N)

ellDF <- build_ellipse(my_radius, my_radius) # Generate ellipse data with defined radius

names(ellDF) <- c("Real", "Imaginary") # Rename columns for ggplot compatibility

# plot the eigenvalues
p <- ggplot(eigDF, aes(x = Real, y = Imaginary))
p <- p +
  geom_point(shape = I(3)) + # Plot points representing eigenvalues
  theme(legend.position = "none") # Remove legend

# now add the vertical and horizontal line
p <- p + geom_hline(aes(yintercept = 0)) # Add horizontal line at y = 0
p <- p + geom_vline(aes(xintercept = 0)) # Add vertical line at x = 0

# finally, add the ellipse
p <- p + geom_polygon(data = ellDF, aes(x = Real, y = Imaginary, alpha = 1/20, fill = "red")) # Add red ellipse

print(p)  # Output plot to PDF

graphics.off()  # Close the PDF device to save file
