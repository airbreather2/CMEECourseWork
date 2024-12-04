

#Getting a feel for the code used for linear models
#Exploring the structure of models, and the structure of model objects, in R
#Understanding how to access the different statistical parameters of models
#Starting to explore correlations and covariances linked with simple linear models

rm(list=ls())
x<-c(1,2,3,4,8)
y<-c(4,3,5,7,9)
x
mean(x)
var(x)

model1 <- (lm(y~x))
model1
#2.6164 + 0.8288
summary(model1)
coefficients(model1)
resid(model1)
mean(resid(model1))
var(resid(model1))
length(resid(model1))

summary(model1)

# I use the code y ~ x to denotate that y is the response variable, and x is the explanatory variable.
plot(y~x, pch=19)

plot(y~x, pch=19, xlim=c(0,8.5), ylim=c(0,9.5)) #range specified
segments(0,-30,0,30, lty=3) #cartesian coordinate axis plotted to better be bale to assess intercept
segments(-30,0,30,0,lty=3)

abline(2.62, 0.83)
coefficients(model1) 

