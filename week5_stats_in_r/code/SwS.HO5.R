#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

rm(list=ls())
d<-read.table("../data/SparrowSize.txt", header=TRUE)

boxplot(d$Mass~d$Sex.1, col = c("red", "blue"), ylab="Body mass (g)") #males slightly heavier

t.test1 <- t.test(d$Mass~d$Sex.1) #sig diff as proven by may defrees of freedom
t.test1

#small data set less likely to be as significant

d1<-as.data.frame(head(d, 50)) #take lower sample size
length(d1$Mass)

t.test2 <- t.test(d1$Mass~d1$Sex) #no sig difference
t.test2

install.packages("pwr")
