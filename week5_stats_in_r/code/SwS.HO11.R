#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

daphnia <- read.delim("../data/daphnia.txt")
summary(daphnia)

head(daphnia)

str(daphnia)

##########check for potential outliers ###############
par(mfrow = c(1, 2))
plot(Growth.rate ~ as.factor(Detergent), data=daphnia)
plot(Growth.rate ~ as.factor(Daphnia), data = daphnia)

##########check for homogeneity of variances ###########
require(dplyr)

#important in ANOVAS we need to make sure variances in each group are similair
daphnia %>% # finds variance of growth rate in dataset
  group_by(Detergent) %>%
  summarise (variance=var(Growth.rate))

daphnia %>% 
  group_by(Daphnia) %>%
  summarise (variance=var(Growth.rate))

#summarise(variance = var(Growth.rate)): For each group created by group_by, this command calculates the variance of the Growth.rate column and labels it as variance
#rule of thumb is that the ratio between the smallest variance should not be much bigger than 4
#might bias the least squares estimators

######check for normality ##########
dev.off()
#This is to tell R to not plot again in the same multi-plot frame as we set u
#p before.
hist(daphnia$Growth.rate)
#no excessive amount of zeroes
#What we could do is check if all combinations are represented and if so, if there is any correlation
#Visually inspect relationships (did this with the boxplots) 
#consider interactions?


#######model Daphnia ##########
# We can also use our superior plotting skills to create barplots showing the means and
# standard errors of the mean for both clonal genotype and detergent presence

#lets use tapply to get means and standard deviations of each of the two explanatory variables
seFun <- function(x) {
  sqrt(var(x)/length(x))
}
detergentMean <- with(daphnia, tapply(Growth.rate, INDEX = Detergent,
                                      FUN = mean))
detergentSEM <- with(daphnia, tapply(Growth.rate, INDEX = Detergent,
                                     FUN = seFun))
cloneMean <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = mean))
cloneSEM <- with(daphnia, tapply(Growth.rate, INDEX = Daphnia, FUN = seFun))



#now plot this
par(mfrow=c(2,1),mar=c(4,4,1,1))
barMids <- barplot(detergentMean, xlab = "Detergent type", ylab = "Population
growth rate",
                   ylim = c(0, 5))
arrows(barMids, detergentMean - detergentSEM, barMids, detergentMean +
         detergentSEM, code = 3, angle = 90)
#plot barplot of Daph clone to detergent type
barMids <- barplot(cloneMean, xlab = "Daphnia clone", ylab = "Population grow
th rate",
                   ylim = c(0, 5))
#plot error bars
arrows(barMids, cloneMean - cloneSEM, barMids, cloneMean + cloneSEM,
       code = 3 , angle = 90) 

daphniaMod <- lm(Growth.rate ~ Detergent + Daphnia, data = daphnia)
summary(daphniaMod)

detergentMean - detergentMean[1]

cloneMean - cloneMean[1]

