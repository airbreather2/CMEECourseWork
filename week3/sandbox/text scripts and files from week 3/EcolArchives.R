MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF) #check the size of the data frame you loaded

str(MyDF)

head(MyDF)

require(tidyverse)
glimpse(MyDF)

MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction) #turning it into a factor makes it a categorical variable
MyDF$Location <- as.factor(MyDF$Location)
str(MyDF)


plot(MyDF$Predator.mass,MyDF$Prey.mass)

#log makes the data make sense
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))

# now log 10, allows one to see things in order of magnitutude
plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass))

plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass),pch=20) # Change marker on plot


plot(log10(MyDF$Predator.mass),log10(MyDF$Prey.mass),pch=20, xlab = "Predator Mass (g)", ylab = "Prey Mass (g)") # Add labels
