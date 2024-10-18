#Generating random numbers

rnorm(10, m=0, sd=1)

#Draw 10 normal random numbers with mean=0 and standard deviation = 1

dnorm(x, m=0, sd=1)

#Density function

qnorm(x, m=0, sd=1)

#Cumulative density function

runif(20, min=0, max=2)

#Twenty random numbers from uniform [0,2]

rpois(20, lambda=10)

#Twenty random numbers from Poisson (with mean 
#)

#computers have seeds that practically form random number cominations but are replicable
set.seed(1234567)
rnorm(1)
#0.156703769128359

setwd()