#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

rm(list=ls())
d<-read.table("../data/SparrowSize.txt", header=TRUE)

plot(d$Mass~d$Tarsus, ylab="Mass (g)", xlab="Tarsus (mm)", pch=19, cex=0.4)

#quickly plot a linear model
x<-c(1:1000)
a<-0.5
b<-1.5
y<-b*x+a
plot(x,y, xlim=c(0,100), ylim=c(0,100), pch=19, cex=1)

head(d$Mass)#find the first value
d$Mass[1] #first value

length(d$Mass) #find last value

d$Mass[1770] #last value

plot(d$Mass~d$Tarsus, ylab="Mass (g)", xlab="Tarsus (mm)", pch=19, cex=0.4, ylim=c(-5,38), xlim=c(0,22))

plot(d$Mass~d$Tarsus, ylab="Mass (g)", xlab="Tarsus (mm)", pch=19, cex=0.4)
#Scaling down to 1mm Tarsus, that gives a change in mass of 10/5 = 2g
#thus y i = 5 + 1.6𝑥i + 𝜀i
# e is the error around the line

#find sum of least squares and plot the linear model
d1<-subset(d, d$Mass!="NA")
d2<-subset(d1, d1$Tarsus!="NA")
length(d2$Tarsus)

model1<-lm(Mass~Tarsus, data=d2)
summary(model1)

#access the residuals
hist(model1$residuals)
head(model1$residuals)

model2<-lm(y~x)
summary(model2)

#lets standardise the covariate
d2$z.Tarsus<-scale(d2$Tarsus)
model3<-lm(Mass~z.Tarsus, data=d2)
summary(model3)

plot(d2$Mass~d2$z.Tarsus, pch=19, cex=0.4)
abline(v = 0, lty = "dotted")

head(d)
str(d)


d$Sex<-as.numeric(d$Sex)
plot(d$Wing ~ d$Sex, xlab="Sex", xlim=c(-0.1,1.1), ylab="")
abline(lm(d$Wing ~ d$Sex), lwd = 2)
text(0.15, 76, "intercept")
text(0.9, 77.5, "slope", col = "red")

d4<-subset(d, d$Wing!="NA")
m4<-lm(Wing~Sex, data=d4)
t4<-t.test(d4$Wing~d4$Sex, var.equal=TRUE)
summary(m4)

#check if the residuals are normally distributed
par(mfrow=c(2,2))
plot(model3)


#comapre these with the model 4 plot
par(mfrow=c(2,2))
plot(m4)
