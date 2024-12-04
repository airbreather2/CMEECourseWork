MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF) #check the size of the data frame you loaded


boxplot(log10(MyDF$Predator.mass), xlab = "Location", ylab = "log10(Predator Mass)", main = "Predator mass")

#run this block
boxplot(log(MyDF$Predator.mass) ~ MyDF$Location, # Why the tilde?  This is to tell R to subdivide or categorize your analysis and plot by the “Factor” location
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by location")

#run this block
boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction,
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by feeding interaction type")

