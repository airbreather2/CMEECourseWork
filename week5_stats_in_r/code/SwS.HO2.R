d<-read.table("../data/SparrowSize.txt", header=TRUE)
str(d)

names(d) #colnames
head(d) 
length(d$Tarsus)

hist(d$Tarsus)

#centrality, mean median and mode
mean(d$Tarsus)
mean(d$Tarsus, na.rm = TRUE) #need to remove the NAs

median(d$Tarsus, na.rm = TRUE)

mode(d$Tarsus) #gives numeric, because continous variable

#dist seems to change with more breaks
par(mfrow = c(2, 2))
hist(d$Tarsus, breaks = 3, col="grey")
hist(d$Tarsus, breaks = 10, col="grey")
hist(d$Tarsus, breaks = 30, col="grey")
hist(d$Tarsus, breaks = 100, col="grey")

#we should round to one deimal place

d$Tarsus.rounded<-round(d$Tarsus, digits=1)
head(d$Tarsus.rounded)

require(dplyr)
TarsusTally <- d %>% count(Tarsus.rounded, sort=TRUE) #counts frequency of each value
TarsusTally

d2<-subset(d, d$Tarsus!="NA") #best to remove nas
length(d$Tarsus)-length(d2$Tarsus) #nas removed as number is same as tally count

TarsusTally <- d2 %>% count(Tarsus.rounded, sort=TRUE)

TarsusTally[1] #frist column extracted

TarsusTally[[1]] #This gives us a normal vector (takes away the wrapping and naming of the column). Now I
#can simply access the first element by adding [

TarsusTally[[1]][1]


range(d$Tarsus, na.rm = TRUE)
## [1] 15.0 21.1
range(d2$Tarsus, na.rm = TRUE)
## [1] 15.0 21.1
var(d$Tarsus, na.rm = TRUE)
## [1] 0.7404059
var(d2$Tarsus, na.rm = TRUE)
## [1] 0.7404059

#calculating variance
sum((d2$Tarsus - mean(d2$Tarsus))^2)/(length(d2$Tarsus) - 1) #is the same as
var(d2$Tarsus)
sqrt(var(d2$Tarsus)) #is the same as 
sd(d2$Tarsus)

#caculating z score
zTarsus <- (d2$Tarsus - mean(d2$Tarsus))/sd(d2$Tarsus)
var(zTarsus)
hist(zTarsus)

znormal <- rnorm(1e+06)
hist(znormal, breaks = 100)
summary(znormal)
#theres a function for this in r


qnorm(c(0.025, 0.975)) #find the extremes of the probability dist 
pnorm(.Last.value) #returns first few values 


#look at this 


# Set up plotting area with 1 row and 2 columns for side-by-side plots
par(mfrow = c(1, 2))

# Plot a histogram of `znormal` with 100 bins
hist(znormal, breaks = 100)

# Add solid vertical lines at the 25th, 50th (median), and 75th percentiles of the normal distribution
abline(v = qnorm(c(0.25, 0.5, 0.75)), lwd = 2)

# Add dashed vertical lines at the 2.5th and 97.5th percentiles for a 95% confidence interval
abline(v = qnorm(c(0.025, 0.975)), lwd = 2, lty = "dashed")

# Plot the density (smoothed histogram) of `znormal` on the second subplot
plot(density(znormal))

# Add gray vertical lines at the 25th, 50th (median), and 75th percentiles on the density plot
abline(v = qnorm(c(0.25, 0.5, 0.75)), col = "gray")

# Add dotted black vertical lines at the 2.5th and 97.5th percentiles for a 95% confidence interval
abline(v = qnorm(c(0.025, 0.975)), lty = "dotted", col = "black")

# Add a solid horizontal line at y = 0 to the density plot
abline(h = 0, lwd = 3, col = "blue")

# Add a label "1.96" near the 97.5th percentile line on the density plot
text(2, 0.3, "1.96", col = "red", adj = 0)

# Add a label "-1.96" near the 2.5th percentile line on the density plot
text(-2, 0.3, "-1.96", col = "red", adj = 1)


#tarsus length betwen 2 sparrows
boxplot(d$Tarsus~d$Sex.1, col = c("red", "blue"), ylab="Tarsus length (mm)")

