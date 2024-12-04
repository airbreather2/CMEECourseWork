#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: Mybars.R
# Description: This script generates a bar plot with multiple lineranges from a data file and saves the plot as a PDF.
# Dependencies: tidyverse
# Arguments: None
# Date: Oct 2024

# Create the results directory if it does not exist
if (!dir.exists("../results")) { 
  dir.create("../results") # Create a directory named 'results' if it doesn’t already exist
}

pdf("../results/MyBars.pdf", # Open a blank PDF to save the plot in 'results'
    20, 13) # Set page dimensions (width x height) in inches

# Read the data from Results.txt, which is assumed to be a table with column headers
a <- read.table("../data/Results.txt", header = TRUE)

head(a) # Display the first few rows of the data frame to inspect its structure

require(tidyverse) # Load the tidyverse package for data manipulation and plotting functions

a$ymin <- rep(0, dim(a)[1]) # Append a new column 'ymin' filled with 0s, of the same length as the number of rows in 'a'

# Initialize a ggplot object and create the first linerange (orange)
p <- ggplot(a)
p <- p + geom_linerange(data = a, aes(
  x = x,              # x-axis uses the 'x' column from data frame 'a'
  ymin = ymin,        # ymin (starting point of line) is set to zero
  ymax = y1,          # ymax (ending point of line) is set to values in the 'y1' column
  size = (0.5)        # Set the width of the linerange
),
colour = "#E69F00",   # Set color to orange
alpha = 1/2,          # Set transparency of the line
show.legend = FALSE)  # Remove legend display for this line

# Create the second linerange (blue)
p <- p + geom_linerange(data = a, aes(
  x = x,
  ymin = ymin,
  ymax = y2,          # Set ending point of line to values in the 'y2' column
  size = (0.5)
),
colour = "#56B4E9",   # Set color to blue
alpha = 1/2, 
show.legend = FALSE)

# Create the third linerange (red)
p <- p + geom_linerange(data = a, aes(
  x = x,
  ymin = ymin,
  ymax = y3,          # Set ending point of line to values in the 'y3' column
  size = (0.5)
),
colour = "#D55E00",   # Set color to red
alpha = 1/2, 
show.legend = FALSE)

# Add text labels to each 'x' position
p <- p + geom_text(data = a, aes(x = x, y = -500, label = Label)) # Position text labels below the x-axis (-500)

# Set x and y axis labels, specify breaks, and apply a black-and-white theme
p <- p + scale_x_continuous("My x axis",         # Label for x-axis
                            breaks = seq(3, 5, by = 0.05)) + # Define tick marks on x-axis
  scale_y_continuous("My y axis") +              # Label for y-axis
  theme_bw() +                                   # Apply a black-and-white theme
  theme(legend.position = "none")                # Remove any legend from the plot

print(p) # Render the plot to the PDF

graphics.off()  # Close the PDF device to save the plot in MyBars.pdf

