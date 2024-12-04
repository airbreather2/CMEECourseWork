#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: PP_Regress.R.
# Description: This code generates multiple plots containing linear regressions of the masses between predator and prey by lifestage and feeding type by location. then finding the coefficients for the linear regressions and saving these to a dataframe  
# Arguments: None
# Date: Oct 2024
# dependencies: ggplot2, dpylr, broom, purrr
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

#remove 
rm(list=ls())

#setting seed for repeatability
set.seed(12345)

#read data in
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

####Performing the Linear Regression coefficient dataframe 

LM <- data_combined %>%
  # Select only relevant columns for analysis
  dplyr::select(Record.number, Predator.mass, Prey.mass, Predator.lifestage, Type.of.feeding.interaction, Location) %>%
  
  # Group data by feeding interaction type and predator life stage
  group_by(Type.of.feeding.interaction, Predator.lifestage, Location) %>%
  
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


#save linear model coefficients output by location
write.csv(LM, "../results/PP_Regress_bylocation_Results.csv", row.names = FALSE)


####### TO DO LIST: 