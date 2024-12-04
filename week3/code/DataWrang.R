#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
# Script: DataWrang.R
# Description: This script loads, inspects, transposes, and wrangles the Pound Hill dataset. It demonstrates data cleaning, reshaping, and initial exploration using the tidyverse.
# Arguments: None
# Date: Oct 2024

# Usage:
# This script loads a dataset without proper headers, wrangles it to handle missing values, reshapes it to long format, and performs data exploration.
#
# To run the script:
# Rscript DataWrang.R
#
# No arguments are required.


################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# Load the dataset as a matrix since the raw data do not have proper headers
MyData <- as.matrix(read.csv("../data/PoundHillData.csv", header = FALSE))
head(MyData)
# Load metadata with headers (specified in the CSV), using ';' as the separator
MyMetaData <- read.csv("../data/PoundHillMetaData.csv", header = TRUE, sep = ";")

############# Inspect the dataset ###############
# Display the first few rows of the dataset to get a quick look at its contents
head(MyData)

# Check the dimensions (number of rows and columns) of the dataset
dim(MyData)

# Display the structure of the dataset, including data types of columns
str(MyData)

# Open an interactive editor to view and possibly edit the dataset
fix(MyData)  # Similarly, this command can be used to inspect and edit the data
fix(MyMetaData)

############# Transpose ###############
# Transpose the data so that species are in columns and treatments are in rows
MyData <- t(MyData)

# Reinspect the first few rows of the transposed data
head(MyData)

# Check the new dimensions of the transposed dataset
dim(MyData)

############# Replace species absences with zeros ###############
# Replace any empty strings (indicating absence of species) in the dataset with zeros
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############
# Convert the matrix (excluding the first row) to a data frame, while ensuring that strings are not converted to factors
TempData <- as.data.frame(MyData[-1,], stringsAsFactors = FALSE)

# Set the column names of the new data frame using the first row of the original matrix (which contains the species names)
colnames(TempData) <- MyData[1,]

############# Convert from wide to long format ###############
# Load the reshape2 package to use the melt function for reshaping the data
require(reshape2)

# Use the melt function to convert the data from wide format (species in columns) to long format
# 'Cultivation', 'Block', 'Plot', and 'Quadrat' remain as identifiers; 'Species' becomes a variable
# 'Count' stores the respective values of the species counts
MyWrangledData <- melt(TempData, id = c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")

# Convert several columns to factors for categorical analysis
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])

# Convert the 'Count' column to integer type as it represents numerical species counts
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

# Check the structure of the wrangled dataset to verify data types and organization
str(MyWrangledData)

# Inspect the first few rows of the wrangled dataset
head(MyWrangledData)

# Verify the dimensions of the wrangled dataset (number of rows and columns)
dim(MyWrangledData)

############# Exploring the data (extend the script below)  ###############

# Check the column names of the transposed data matrix (for comparison or debugging purposes)
colnames(MyData)

# Recreate the temporary data frame from the transposed matrix (without column headers)
TempData <- as.data.frame(MyData[-1,], stringsAsFactors = FALSE)

# Inspect the first few rows of the recreated temporary data frame
head(TempData)

#:: allows you to load a desired function from a specific package
MyWrangledData <- dplyr::as_tibble(MyWrangledData) 
MyWrangledData

require(tidyverse) #activates packages for use
tidyverse_packages(include_self = TRUE) # the include_self = TRUE means list "tidyverse" as well 

#is the same as: 
MyWrangledData <- as_tibble(MyWrangledData) 
class(MyWrangledData)

glimpse(MyWrangledData) #like str() , but nicer

filter(MyWrangledData, Count>100) #like subset(), but nicer!

slice(MyWrangledData, 10:15) #look at a particular range of data rows

#pipe operator allows you to create a compact sequence of manipulations with your dataset
MyWrangledData %>%
  group_by(Species) %>%
  summarise(avg = mean(Count))

#is the same as 
aggregate(MyWrangledData$Count, list(MyWrangledData$Species), FUN=mean) 


