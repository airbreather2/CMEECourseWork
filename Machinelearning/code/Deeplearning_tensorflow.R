name <- "Sebastian Dohne"
preferred_name <- "Seb"
email <- "sed24@ic.ac.uk"
username <- "sed24"

#modules: 
library(tidyverse)

use_condaenv("r-tensorflow", required = TRUE)
install_keras()

conda_create("r-tensorflow")
conda_install("r-tensorflow", "tensorflow")

# In TensorFlow, everything is treated as a “tensor,” which you can think of as a 
# generalization of scalars and vectors to any number of dimensions (or “directions”). 
#
# - A scalar (rank-0 tensor) has just a single magnitude, like the length of a ruler.
# - A vector (rank-1 tensor) has a magnitude AND a single direction, like the velocity 
#   of a ruler flying through the air (speed plus direction).
# - A matrix (rank-2 tensor) can be seen as a magnitude with TWO directions 
#   (for instance, rows and columns).
# - Higher-rank tensors (rank-3, rank-4, etc.) extend this idea to more directions.
#
# In practice, a rank-3 tensor might look like a stack of matrices (e.g., an image with 
# multiple color channels), and so on. TensorFlow accelerates calculations on these 
# tensors (scalars, vectors, matrices, or higher-rank arrays) to efficiently handle 
# large-scale machine learning tasks.


# Tensors are a formal way to describe how data is “moved” or transformed according 
# to its magnitude and direction. For example, a vector (1,3) can be seen as “go up 
# one unit on the x-axis and three units on the y-axis.” In physics and engineering, 
# tensors help model things like stress and strain by showing how a system changes 
# when forces are applied. 
#
# TensorFlow treats all data as these “tables” (tensors) of numbers, each with a 
# certain rank (number of dimensions). There’s no real difference between the data 
# itself and the operations on it—everything is a tensor that can be combined, 
# transformed, or reduced (changing its rank). This view lets TensorFlow quickly 
# perform large-scale calculations in parallel (e.g., on GPUs) for machine learning 
# tasks.

#Lets test it out
#using original NN data, we can see its much faster.

# Simulate (this time adding noise to the response variable)
# Generate 10 predictor variables, each with 400 random values
exp <- replicate(10, rnorm(400))  

# Create the response variable with some interactions and added noise
resp <- exp[,1] * 2 - 0.5 * exp[,2] - exp[,7] * exp[,8] + exp(abs(exp[,3])) + rnorm(nrow(exp))

# Standardize predictors and response to have mean = 0 and standard deviation = 1
exp <- as.matrix(scale(exp))  
resp <- as.numeric(scale(resp))  

# Randomly select 50% of the data for training
training <- sample(nrow(exp), nrow(exp)/2)

#lets use keras. its easier than using tensorflow directly in r: 
# Get Keras ready
library(keras)
install_keras()

# Specific model
model <- keras_model_sequential()
model %>%
  layer_dense(units = 15, activation = 'relu', input_shape=10) %>%
  layer_dense(units = 15, activation = 'relu') %>%
  layer_dense(units = 1)


