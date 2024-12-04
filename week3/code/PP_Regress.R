#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: PP_Regress.R.
# Description: This code generates multiple plots containing linear regressions of the masses between predator and prey by lifestage and feeding type. then finding the coefficients for the linear regressions and saving these to a dataframe  
# Arguments: None
# Date: Oct 2024
#dependencies: ggplot2, dpylr, broom, purrr
# Usage:
# 
# 
# To run the script:
# Rscript PP_Regress.R
#
# No arguments are required for running this script.

library(ggplot2) 
library(dplyr)
library(broom)
library(purrr)

rm(list=ls())

#setting seed for repeatability
set.seed(12345)


data <- read.csv("../data/EcolArchives-E089-51-D1.csv")

# Combine all feeding types into one dataset and log transform predator and prey mass
data_combined <- data %>%
  mutate(
    LogPreyMass = log10(Prey.mass),
    LogPredatorMass = log10(Predator.mass)
  )

# find which groups have fewer than 3 points, these will show up as NA when calculating lm coefficients  
data_combined %>%
  group_by(Type.of.feeding.interaction, Predator.lifestage) %>%
  summarize(count = n())


######creating linear feeding type regression plot matrix 
combined_plot <- ggplot(data_combined, aes(x = Prey.mass, y = Predator.mass, color = Predator.lifestage)) + 
  geom_point(shape = 3) +
  geom_smooth(method = "lm", se = TRUE, fullrange=TRUE) +
  facet_wrap(~Type.of.feeding.interaction, ncol = 1, strip.position = "right") + #creates seperate plots for different feeding interaction types
  scale_x_log10() +  # Keep the log scale, no explicit limits
  scale_y_log10() +   # Keep the log scale, no explicit limits 
  theme_bw() +  # Start with a clean black-and-white theme
  theme(
    legend.position = "bottom",  # Move legend to bottom
    legend.title = element_text(size = 7, face = "bold"), 
    legend.text = element_text(size = 7)
  ) +
  guides(color = guide_legend(nrow = 1)) + # Set the number of rows in the legend 
  labs(
    x = "Prey Mass in grams (log scale)",
    y = "Predator Mass in grams (log scale)",
    color = "Predator Lifestage"
  )

# Display the combined plot
print(combined_plot)

#######saving the plot as a pdf

# Define the file path and dimensions
output_file <- "../results/test_Visualising_regression_analysis.pdf"  # Specify the file name

# Save the plot
ggsave(
  filename = output_file,        # File name
  plot = combined_plot,          # ggplot object to save
  width = 6,                    # Width of the image in inches
  height = 12,                   # Height of the image in inches
  dpi = 300                      # Resolution in dots per inch (high quality)
)

# Print confirmation
print(paste("Plot saved as", output_file))

####Performing the Linear Regression and creating a coefficient dataframe 

LM <- data_combined %>%
  # Select only relevant columns for analysis
  dplyr::select(Record.number, Predator.mass, Prey.mass, Predator.lifestage, Type.of.feeding.interaction) %>%
  
  # Group data by feeding interaction type and predator life stage
  group_by(Type.of.feeding.interaction, Predator.lifestage) %>%
  
  # Filter out groups with only one record (insufficient for regression)
  filter(n() > 1) %>%
  
  # Filter out groups with zero variance in Prey.mass (no meaningful regression possible)
  filter(sd(Prey.mass) > 0) %>%
  
  # Fit a linear model for each group (Predator.mass ~ Prey.mass)
  do(mod = lm(Predator.mass ~ Prey.mass, data = .)) %>%
  
  # Extract regression results (slope, intercept, R-squared, F-statistic, P-value)
  mutate(
    Regression.slope = summary(mod)$coefficients[2, 1],
    Regression.intercept = summary(mod)$coefficients[1, 1],
    R.squared = summary(mod)$adj.r.squared,
    Fstatistic = summary(mod)$fstatistic[1],
    P.value = summary(mod)$coefficients[2, 4]
  ) %>%
  
  # Remove the model object column to simplify the final output
  dplyr::select(-mod)



write.csv(LM, "../results/PP_Regress_Results.csv", row.names = FALSE)


####### TO DO LIST: 
#DO A SEPERATE SCRIPT THAT CREATES OUTPUT BY LOCATION







