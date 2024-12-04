#apply a function to a dataframe using some factor to define the subsets

attach(iris)
iris

#run colMeans function
by(iris[,1:2], iris$Species, colMeans)
#finds column means for iris species in defined area

#Replicate
replicate(10, runif(5))

#you just generated 10 sets (columns) of 5 uniformly-distributed random numbers (a 10 
#x 5 matrix 


