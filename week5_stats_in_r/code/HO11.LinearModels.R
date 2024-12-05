#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

rm(list=ls())
daphnia <- read.delim("../data/daphnia.txt")
summary(daphnia)
head(daphnia)

par(mfrow = c(1, 2))
plot(Growth.rate ~ as.factor(Detergent), data=daphnia)
plot(Growth.rate ~ as.factor(Daphnia), data = daphnia)
#no outliers found

#lets check for homogeneity of variances
#A rule of thumb (for ANOVA) is that the ratio between the largest
#and smallest variance should not be much more than 4 (this is a conservative estimate).

require(dplyr)
daphnia %>%
group_by(Detergent) %>%
summarise (variance=var(Growth.rate))

#daphnia variance 
daphnia %>%
  group_by(Daphnia) %>%
  summarise (variance=var(Growth.rate))

dev.off()
#This is to tell R to not plot again in the same multi-plot frame as we set u
#p before.

hist(daphnia$Growth.rate)
