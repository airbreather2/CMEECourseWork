#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

rm(list=ls())
require(WebPower)
?WebPower

0.3/1.2 # to find cohens d we find the difference in means between 2 groups and divide this by the standard deviation

y<-rnorm(51, mean=1, sd=1.3)
x<-seq(from=0, to=5, by=0.1)

length(x)
plot(hist(y, breaks=10))

mean(y)
sd(y)

segments(x0=(mean(y)), y0=(0), x1=(mean(y)), y1=40, lty=1, col="blue") #This code draws a solid blue vertical line on an existing plot, centered at the mean of y on the x-axis, extending from y = 0 to y = 40. This line often serves as a visual marker of the mean on a plot.
# and now 0.25 sd left of the mean (because females are larger)
segments(x0=(mean(y)+0.25*sd(y)), y0=(0), x1=(mean(y)+0.25*sd(y)), y1=40, lty
         =1, col="red") #draws a line 0.25 of a standard deviation further up as females are larger

?wp.t
wp.t(d=0.25, power=0.8, type="two.sample", alternative="two.sided") #default two sided test needs to be run because not enough data
#         n     d     alpha   power
#     252.1275 0.25  0.05   0.8

#a power curve could be used? shows the statistical power increase with increasing sample size
res.1<-wp.t(n1=seq(20,300,20), n2=seq(20,300,20), d=0.25, type="two.sample", alternative="two.sided")
res.1

plot(res.1) #shows how the power increases with sample size


