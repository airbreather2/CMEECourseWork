#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>


rm(list=ls())

d<-read.table("../data/SparrowSize.txt", header=TRUE)
str(d)
summary(d)
names(d)
head(d)

# Aim: Explore variance in tarsus and wing measurements among and between individuals and cohorts in house sparrows
# Prediction: Both traits (tarsus and wing) are repeatable; variance between individuals > variance within individuals
# Hypothesis: BirdID will explain substantial variance, cohort may also explain variance due to shared growth conditions
# Action: Remove NAs as data contains missing values
# Correction: Account for sex differences as they impact size-related traits
# Method: Use a range of linear models, including bivariate models, to test hypotheses

dat <- d[!is.na(d$Tarsus) & !is.na(d$Wing) & !is.na(d$Sex) & !is.na(d$Cohort), ]
#removes nas, d to include columns that do not have NAs

#this is a different way of subsetting - we can give multiple conditions at
#once, and combine them with a logical operator &, which means AND. We could
#also use | which means OR.
d1<-data.frame(d$Tarsus,d$Wing,d$Sex)
pairs(d1, pch=19, cex=0.7)#below/above is x and left/right is y 


cor.test(dat$Wing,dat$Tarsus)



#########missing the data in the handout ########################