#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: MyLinReg.R
# Description: This script generates a scatter plot with a linear regression line from a simulated dataset. The plot is saved as a PDF.
# Dependencies: tidyverse
# Arguments: None
# Date: October 2024

# Create the results directory if it does not exist
if (!dir.exists("../results")) { 
  dir.create("../results") # Create a directory named 'results' if it doesn’t already exist
}

# Load the tidyverse package for data manipulation and plotting functions
require(tidyverse)

# Open a blank PDF in the 'results' directory to save the plot
pdf("../results/MyLinReg.pdf", 
    20, 13) # Set page dimensions (width x height) in inches

# Generate a sequence of x values from 0 to 100 with increments of 0.1
x <- seq(0, 100, by = 0.1)

# Generate y values based on a linear relationship with x, adding random noise
y <- -4. + 0.25 * x + rnorm(length(x), mean = 0., sd = 2.5)

# Store x and y values in a data frame
my_data <- data.frame(x = x, y = y)

# Perform a linear regression of y on x and summarize the model
my_lm <- summary(lm(y ~ x, data = my_data))

# Plot the data with ggplot2, using the absolute residuals as color intensity
p <- ggplot(my_data, aes(x = x, y = y, colour = abs(my_lm$residual))) +
  geom_point() + # Scatter plot of data points
  scale_colour_gradient(low = "black", high = "red") + # Gradient color for residuals
  theme(legend.position = "none") + # Remove legend
  scale_x_continuous(expression(alpha^2 * pi / beta * sqrt(Theta))) # Custom x-axis label with expression

# Add the regression line to the plot
p <- p + geom_abline(
  intercept = my_lm$coefficients[1][1], # Intercept from the regression model
  slope = my_lm$coefficients[2][1],     # Slope from the regression model
  colour = "red")                       # Set line color to red

# Add a mathematical expression as a label to the plot at specified coordinates
p <- p + geom_text(aes(x = 60, y = 0, label = "sqrt(alpha) * 2* pi"), 
                   parse = TRUE, size = 6, colour = "blue") # Display the expression in blue

# Print the plot to the PDF
print(p)

# Close the PDF device to save the plot in 'MyLinReg.pdf'
graphics.off()
