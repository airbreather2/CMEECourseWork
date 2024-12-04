# When vectors are of different lengths, R will recycle the shorter one to make a vector of the same length:

a <- c(1,5) + 2
a
#3.7

x <- c(1,2); y <- c(5,3,9,2)
x;y

#12
#5392

x + y 
#6-5-10-4
#1 and 2 got recyled for 9 and 2 to make 10 and 4
x + c(y,1)
#Warning message in x + c(y, 1):
#“longer object length is not a multiple of shorter object length”
#6-5-10-4-2
#1 is added to 1
#r dont like this 



