MyDF <- read.csv("../../data/EcolArchives-E089-51-D1.csv")
dim(MyDF) #check the size of the data frame you loaded

#data is skewed
hist(MyDF$Predator.mass)

#trying with log unskews it
hist(log10(MyDF$Predator.mass), xlab = "log10(Predator Mass (g))", ylab = "Count") # include labels

hist(log10(MyDF$Predator.mass),xlab="log10(Predator Mass (g))",ylab="Count", 
     col = "lightblue", border = "pink") # Change bar and borders colors 

#run this block
par(mfcol=c(2,1)) #initialize multi-paneled plot
par(mfg = c(1,1)) # specify which sub-plot to use first 
hist(log10(MyDF$Predator.mass),
     xlab = "log10(Predator Mass (g))", ylab = "Count", col = "lightblue", border = "pink", 
     main = 'Predator') # Add title
par(mfg = c(2,1)) # Second sub-plot
hist(log10(MyDF$Prey.mass), xlab="log10(Prey Mass (g))",ylab="Count", col = "lightgreen", border = "pink", main = 'prey')

#The par() function can set multiple graphics parameters (not just multi-panel plots), including figure margins, axis labels, and more.

#run this block
hist(log10(MyDF$Predator.mass), # Predator histogram
     xlab="log10(Body Mass (g))", ylab="Count", 
     col = rgb(1, 0, 0, 0.5), # Note 'rgb', fourth value is transparency
     main = "Predator-prey size Overlap") 
hist(log10(MyDF$Prey.mass), col = rgb(0, 0, 1, 0.5), add = T) # Plot prey
legend('topleft',c('Predators','Prey'),   # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) # Define legend colors
