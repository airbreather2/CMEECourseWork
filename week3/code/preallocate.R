

#inbuilt sum function is about 100 times faster as it is built in lower level language

#below is a loop function that makes r resize a vector repeatedly making it slow

NoPreallocFun <- function(x) {
  a <- vector() # empty vector
  for (i in 1:x) {
    a <- c(a, i) # concatenate
    print(a)
    print(object.size(a))
  }
}

system.time(NoPreallocFun(1000))


#preallocation of vectors speeds this up
PreallocFun <- function(x) {
  a <- rep(NA, x) # pre-allocated vector
  for (i in 1:x) {
    a[i] <- i # assign
    print(a)
    print(object.size(a))
  }
}

system.time(PreallocFun(1000)) #much faster





