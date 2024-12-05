#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>


rm(list = ls())
# create three data sets y with different variances (1, 10, 100)
# rnorm() requires sample size (20), mean and sd
y1<-rnorm(10, mean=0, sd=sqrt(1))
var(y1)
#0.7653411
y2<-rnorm(10, mean=0, sd=sqrt(10))
var(y2)
#8.370879
y3<-rnorm(10, mean=0, sd=sqrt(100))
var(y3)
#163.2501
x<-rep(0,10) #repeat 0 ten times

par(mfrow = c(1, 3))
plot(x, y1, xlim=c(-0.1,0.1), ylim=c(-12,12), pch=19, cex=0.8, col="red")
abline(v=0)
abline(h=0)
plot(x, y2, xlim=c(-0.1,0.1), ylim=c(-12,12), pch=19, cex=0.8, col="blue")
abline(v=0)
abline(h=0)
plot(x, y3, xlim=c(-0.1,0.1), ylim=c(-12,12), pch=19, cex=0.8,, col="darkgreen")
abline(v=0)
abline(h=0)

?polygon() #polygon draws the polygons whose vertices are given in x and y. we will use this to visualise the sum of squares
par(mfrow = c(1, 3))
plot(x, y1, xlim=c(-12,12), ylim=c(-12,12) ,pch=19, cex=0.8, col="red")
abline(v=0)
abline(h=0)
for (i in 1:length(y1)) {
  polygon(x=c(0,0,y1[i],y1[i]),y=c(0,y1[i],y1[i],0), col=rgb(0, 0, 1,0.2))
}

plot(x, y2, xlim=c(-12,12), ylim=c(-12,12), pch=19, cex=0.8, col="blue")
abline(v=0)
abline(h=0)
for (i in 1:length(y2)) {
  polygon(x=c(0,0,y2[i],y2[i]),y=c(0,y2[i],y2[i],0), col=rgb(0, 0, 1,0.2))
}

plot(x, y3, xlim=c(-12,12), ylim=c(-12,12), pch=19, cex=0.8,, col="darkgreen"
)
abline(v=0)
abline(h=0)
for (i in 1:length(y3)) {
  polygon(x=c(0,0,y3[i],y3[i]),y=c(0,y3[i],y3[i],0), col=rgb(0, 1, 0,0.2))
}

#lets show x and y are related
rm(list = ls())
par(mfrow = c(1, 3))
x<-c(-10:10)
var(x)
## [1] 38.5
y1<-x*1 + rnorm(21, mean=0, sd=sqrt(1))
# here the association is 1:1
cov(x, y1)
## [1] 37.85298
plot(x, y1, xlim=c(-10,10), ylim=c(-20, 20), col="red", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y1),digits=2)))
y2<-rnorm(21, mean=0, sd=sqrt(1))
# Here, there is no association
cov(x, y2)
## [1] 1.572258
plot(x, y2, xlim=c(-10,10), ylim=c(-20, 20), col="blue", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y2),digits=2)))
y3<- x* (-1) +rnorm(21, mean=0, sd=sqrt(1))
# Here, the association is negative
cov(x, y3)
## [1] -34.6899
plot(x, y3, xlim=c(-10,10), ylim=c(-20, 20), col="darkgreen", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y3),digits=2)))

#covariance itelf isn't super useful, modifying it allows us to find correlation
cov(x,y1)
cor(x, y1)
cov(x,y2)
cor(x,y2)
cov(x,y3)
cor(x,y3)

#what happens if we introduce variation in y 
rm(list = ls())
par(mfrow = c(1, 3))
x<-c(-10:10)
var(x)
## [1] 38.5
y1<-x*1 + rnorm(21, mean=0, sd=sqrt(1))
# here the association is 1:1, with low variance in y
cov(x, y1)
## [1] 37.31275
plot(x, y1, xlim=c(-10,10), ylim=c(-20, 20), col="red", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y1),digits=2)," Cor=",round(cor(x,y1),digits=2)))
y2<-x*1 + rnorm(21, mean=0, sd=sqrt(10))
# The association remains 1:1, but higher variance in y
cov(x, y2)
## [1] 39.81266
plot(x, y2, xlim=c(-10,10), ylim=c(-20, 20), col="blue", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y2),digits=2)," Cor=",round(cor(x,y2),digits=2)))
y3<- x*1 + rnorm(21, mean=0, sd=sqrt(100))
cov(x, y3)
## [1] 34.8734
plot(x, y3, xlim=c(-10,10), ylim=c(-20, 20), col="darkgreen", pch=19, cex=0.8, main=paste("Cov=",round(cov(x,y3),digits=2)," Cor=",round(cor(x,y3),digits=
                                                                   2)))

