rm(list = ls())
# create three data sets y with different variances (1, 10, 100)
# rnorm() requires sample size (20), mean and sd
y1<-rnorm(10, mean=0, sd=sqrt(1))
var(y1)
## [1] 1.277436
y2<-rnorm(10, mean=0, sd=sqrt(10))
var(y2)
## [1] 14.31409
y3<-rnorm(10, mean=0, sd=sqrt(100))
var(y3)
## [1] 68.8384
# create x variable for plotting
x<-rep(0,10)
# making a 1x3 plot using mfrow() (look it up if you don't know what that doe
s)
par(mfrow = c(1, 3))
plot(x, y1, xlim=c(-0.1,0.1), ylim=c(-12,12), pch=19, cex=0.8, col="red")
abline(v=0)
abline(h=0)
plot(x, y2, xlim=c(-0.1,0.1), ylim=c(-12,12), pch=19, cex=0.8, col="blue")
abline(v=0)
abline(h=0)
plot(x, y3, xlim=c(-0.1,0.1), ylim=c(-12,12), pch=19, cex=0.8,, col="darkgree
n")
abline(v=0)
abline(h=0)

