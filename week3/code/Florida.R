#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: Florida.R
# Description: this code performs a permutation analysis on a temperature dataset from Florida Keywest, generating a distribution of 10000 random correlation coefficients and comparing the observed coefficient with these by generating a fraction which which acts as a p-value. 
# Arguments: None
# Date: Oct 2024

# Usage:
# 
# 
# To run the script:
# Rscript Florida.R
#
# No arguments are required for running this script.


rm(list=ls())

#setting seed for repeatability
set.seed(12345)

load("../data/KeyWestAnnualMeanTemperature.RData")
#list stuff in global environment
ls()
#show data class
class(ats)
#list first rows
head(ats)
#plot values on scatter graph

#saving plot 

png("../data/KeyWest_Temperature_vs_Year.png", width = 800, height = 600)


# Create a plot of Temp vs. Year
plot(ats$Year, ats$Temp, main = "Is Florida getting warmer? Key West Temperature vs Year", xlab = "Year", ylab = "Temperature")

# Fit a linear model
model <- lm(Temp ~ Year, data = ats)

# Add the regression line
abline(model, col = "red", lwd = 2)

# Close the PNG device to save the file
dev.off()

#get the coefficients of the linear model
summary(model)


#find the correlation between year and temp 
?cor
correlation <- cor(ats$Year, ats$Temp)
print(correlation)

#initialise list for storing random correlation values
random_list <- list()

?sample

#randomise the temperature values and find the random correlations 100000 times, appending these values to a list 
for (i in 1:10000) {
  random_i <- ats
  
  random_i$Temp <- sample(ats$Temp) #randomize temp column from ats dataset
  
  element <- cor(random_i$Year, random_i$Temp) #find random correlations 

  random_list <- c(random_list, element) #append these to the random list
}


#finds fraction of random correlation coefficients greater than observed correlation. giving asymptotic p-value
p_value <- mean(random_list > correlation)

print("p-value is")
print(p_value)



