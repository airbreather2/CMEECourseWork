rm(list=ls())

install.packages("WebPower")
require(WebPower)
?WebPower

0.3/1.2 #cohens d
#we want to detect an effect size 1/4 the size of the standard deviation

y<-rnorm(51, mean=1, sd=1.3) 
x<-seq(from=0, to=5, by=0.1) #generates numbers numbers from one to 5 in increments of 0.1

plot(hist(y, breaks=10))

mean(y)
sd(y)

segments(x0=(mean(y)), y0=(0), x1=(mean(y)), y1=40, lty=1, col="blue")
