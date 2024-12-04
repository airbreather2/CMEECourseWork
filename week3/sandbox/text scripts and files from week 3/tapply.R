#allows you to apply a function to subsets of a vector in a dataframe. 
#with the subsets defined by some other vector in the dataframe, usually a factor

x <- 1:20 # a vector
x

y <- factor(rep(letters[1:5], each = 4)) 
y

#aaaabbbbccccddddeeee


tapply(x, y, sum)

