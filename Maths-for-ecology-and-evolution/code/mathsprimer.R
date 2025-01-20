#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>
#desc- contains the answers for questions in the primer and supplementary that require usage of r

#question 2 
x <- seq(0, 100, by = 0.5)
y <- x^1.84
plot(x,y,xlab = "stem diameter", ylab = "leaf area")
#leaf area increases 

b <- seq(0, 100, by = 0.5)
a <- b^-0.49
plot(b,a,xlab = "leaf thickness", ylab = "spongy mesophyll volume")
#spongy mesophyll decreases

#question 4
x <- seq(-2 * pi, 2 * pi, length.out = 1000)
#1
y <- sin(x)
z <- cos(x)
plot(x,y) # sin wave 
plot(x,z) #cos wave 
#2
y <- 2*sin(x)
z <- 4*sin(x)
plot(x,y) #  higher
plot(x,z) 
#3
y <- cos(2*x)
z <- cos(4*x)
plot(x,y) #squished
plot(x,z)
#4 
y <- cos(x + (pi/4))
z <- cos(x + (pi/2))
plot(x,y) #shifted to the left
plot(x,z)
