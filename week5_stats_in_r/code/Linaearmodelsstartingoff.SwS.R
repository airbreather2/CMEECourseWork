rm(list=ls())
x<-c(1,2,3,4,8)
y<-c(4,3,5,7,9)
x

mean(x)
var(x)

mean(y)
var(y)

?lm

y~x #tilde to signify y is the response variable

model1 <- (lm(y~x))
model1 #shows coefficients and intercepts
summary(model1)# It tells us the residuals. Then the coefficients, and their standard errors, and associated t-
#values and p-values

coefficients(model1)

resid(model1)             
var(resid(model1))

plot(y~x, pch=19)

#adding cartesian coordiantes
plot(y~x, pch=19, xlim=c(0,8.5), ylim=c(0,9.5))
segments(0,-30,0,30, lty=3)
segments(-30,0,30,0,lty=3)
coefficients(model1)
#use these for abline
abline(coefficients(model1))

x<-seq(from=-10, to=10, by=0.2)
x

y<- 7.1-0.2 * x
y

summary(lm(y~x)) #r squared shows fit is essentially perfect but get odd error

plot(y~x)

y<- 7.1-0.2 * x + runif(length(x))
#y<- 7.1-0.2 * x + runif(length(x), min= 0, max= 50) #same equation as last time but this time use random number generator to add uncertainty (default runif adds nubers between 0-1)
summary(lm(y~x))

?lm

require(graphics)

## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)
lm.D9 <- lm(weight ~ group)
lm.D90 <- lm(weight ~ group - 1) # omitting intercept

anova(lm.D9)
summary(lm.D90)

opar <- par(mfrow = c(2,2), oma = c(0, 0, 1.1, 0))
plot(lm.D9, las = 1)      # Residuals, Fitted, ...
par(opar)

