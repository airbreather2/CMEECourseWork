# Load the data from a CSV file into a data frame
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

# Check the size of the data frame (number of rows and columns)
dim(MyDF) 

# Display the structure of the data frame, including variable types and examples
str(MyDF)

# Show the first six rows of the data frame to inspect the data
head(MyDF)

# Load the 'tidyverse' package for data manipulation and visualization
require(tidyverse)

# Provide a compact, horizontal summary of the data frame (alternative to str)
glimpse(MyDF)

# Convert 'Type.of.feeding.interaction' column to a factor (categorical variable)
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)

# Convert 'Location' column to a factor (categorical variable)
MyDF$Location <- as.factor(MyDF$Location)

# Check the structure of the data frame again to confirm factor conversion
str(MyDF)


plot(MyDF$Predator.mass,MyDF$Prey.mass)


#try log, as body sizes across species are usually log-normally distributed 



