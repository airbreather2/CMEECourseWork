a <- TRUE
if (a == TRUE) {
  print ("a is TRUE")
} else {
  print ("a is FALSE")
}

z <- runif(1) ## Generate a uniformly distributed random number
if (z <= 0.5) {print ("Less than a half")}


#for loops
for (i in 1:10) {
  j <- i * i
  print(paste(i, " squared is", j ))
}

#loop over 

for(species in c('Heliodoxa rubinoides', 
                 'Boissonneaua jardini', 
                 'Sula nebouxii')) {
  print(paste('The species is', species))
}


v1 <- c("a","bc","def")
for (i in v1) {
  print(i)
}


#while loops

i <- 0
while (i < 10) {
  i <- i+1
  print(i^2)
}

i <- 0
while (i < 10) {
  i <- i+1
  print(i^2)
}





