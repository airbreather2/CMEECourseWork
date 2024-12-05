#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

rm(list=ls())
d<-read.table("../data/SparrowSize.txt", header=TRUE)
d1<-subset(d, d$Tarsus!="NA") #This creates a new dataframe d1 that excludes any rows where the Tarsus column has an "NA" (missing) value.
seTarsus<-sqrt(var(d1$Tarsus)/length(d1$Tarsus))
seTarsus

d12001<-subset(d1, d1$Year==2001)
seTarsus2001<-sqrt(var(d12001$Tarsus)/length(d12001$Tarsus))
seTarsus2001

d2<-subset(d, d$Mass!="NA") #Se of mass
seMass<-sqrt(var(d2$Mass)/length(d2$Mass))
seMass

d22001<-subset(d2, d2$Year==2001)
seMass2001<-sqrt(var(d22001$Mass)/length(d12001$Mass))
seMass2001

mean(d2$Mass)

massttest <- t.test(d2$Mass)
massttest

#se is measurement of precision, it is five times higher in 2001 dataset

#find true mean with self gen dataset
rm(list=ls())
TailLength<-rnorm(500,mean=3.8, sd=2)
summary(TailLength)

length(TailLength)
## [1] 500
var(TailLength)
## [1] 4.284017
sd(TailLength)
## [1] 2.069787
hist(TailLength)

# Creates a sequence x from 1 to the length of TailLength
x <- 1:length(TailLength)

# Sets y to be a constant vector, the mean of TailLength, to match the length of TailLength
y <- mean(TailLength) + 0 * x

# Computes the minimum value of TailLength, though this is not assigned to any variable
min(TailLength)

# Creates an initial plot with x vs y, defining axis limits and labels
plot(x, y, cex = 0.03, ylim = c(2, 5), xlim = c(0, 500), 
     xlab = "Sample size n", ylab = "Mean of tail length ±SE (m)", col = "red")

# Initializes vectors to store standard errors (SE) and means (mu)
SE <- c(1)
mu <- c(1)

# Loops through values from 1 to the length of TailLength
for (n in 1:length(TailLength)) {
  # Samples n values from TailLength without replacement
  d <- sample(TailLength, n, replace = FALSE)
  # Computes the mean of the sampled data
  mu[n] <- mean(TailLength)
  # Calculates the standard error based on the sample size n
  SE[n] <- sd(TailLength) / sqrt(n)
}

# Computes upper and lower limits for confidence intervals
up <- mu + SE
down <- mu - SE
x <- 1:length(SE)

# Draws vertical lines for each x position representing ±SE around the mean
segments(x, up, x1 = x, y1 = down, lty = 1)

# Clears all objects from the environment
rm(list = ls())

# Creates new data for TailLength, a random sample from a normal distribution
TailLength <- rnorm(201, mean = 3.8, sd = 2)
length(TailLength)

# Sets up x and y for the plot using new TailLength data
x <- 1:201
y <- mean(TailLength) + 0 * x

# Plots x vs y with updated limits and labels
plot(x, y, cex = 0.03, ylim = c(3, 4.5), xlim = c(0, 201), 
     xlab = "Sample size n", ylab = "Mean of tail length ±SE (m)", col = "red")

# Creates a sequence of sample sizes (n) in steps of 10
n <- seq(from = 1, to = 201, by = 10)

# Reinitializes vectors to store SE and mu for selected sample sizes
SE <- c(1)
mu <- c(1)

# Loops over each sample size in n
for (i in 1:length(n)) {
  # Samples n[i] values from TailLength without replacement
  d <- sample(TailLength, n[i], replace = FALSE)
  # Stores mean and standard error for each sample size in n
  mu[i] <- mean(TailLength)
  SE[i] <- sd(TailLength) / sqrt(n[i])
}

# Computes confidence intervals for the means
up <- mu + SE
down <- mu - SE
length(up)

# Adds final plot annotations
plot(x, y, cex = 0.03, ylim = c(3, 4.5), xlim = c(0, 201), 
     xlab = "Sample size n", ylab = "Mean of tail length ±SE (m)", col = "red")
points(n, mu, cex = 0.3, col = "red")
segments(n, up, x1 = n, y1 = down, lty = 1)
