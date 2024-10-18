v <- c(0, 1, 2, 3, 4)
v2 <- v*2 # multiply whole vector by 2
v2
# 0.2.4.6.8

v * v2 # element-wise product
# 0.2.8.18.32

t(v) # transpose the vector
# forms a matrix that goes from 0 1 2 3 4

v %*% t(v) # takes matrix/vector product and forms grid, rounding numbers down to closest integer

v3 <- 1:7 # assign using sequence
v3
# 1.2.3.4.5.6.7

v4 <- c(v2, v3) # concatenate vectors
v4
#0.2.4.6.8.1.2.3.4.5.6.7

