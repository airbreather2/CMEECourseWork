name <- "Sebastian Dohne"
preferred_name <- "Seb"
email <- "sed24@ic.ac.uk"
username <- "sed24"

library(neuralnet)
library(NeuralNetTools)


# Intro to predicting continuous data with artificial neural networks (ANNs)
# ANNs are often over-hyped but can be powerful predictors despite their complexity.
# Their inner workings are hard to interpret; model performance is best evaluated by testing predictive power.

# Basic ANN structure:
# - Input layer: Nodes represent explanatory variables.
# - Hidden layers: Process data through interconnected nodes with weighted connections and activation functions.
# - Output layer: Provides predictions (focus on univariate regression here).

# Activation functions:
# - Crucial for introducing non-linearity; otherwise, ANNs behave like standard regression models.
# - Weights control the magnitude and direction of effects between nodes.

# Training process (backpropagation):
# 1. Feedforward step: Compare predicted output with actual data.
# 2. Error is propagated backward, adjusting weights based on contribution to error.
# 3. Gradient descent optimization: Iteratively adjusts weights to minimize error.

# Important note:
# - Input data and response variables must be normalized for the model to work effectively.



###############Fitting a Nerual network ########################################

# Generate 1000 random numbers from a normal distribution
x <- rnorm(1000)

# Create y as the negative of x (perfectly negatively correlated)
y <- -x

# Combine x and y into a data frame and scale both variables (mean = 0, sd = 1)
data <- data.frame(scale(cbind(x, y)))

# Train a neural network with no hidden layers to predict y from x
model <- neuralnet(y ~ x, hidden = 0, data = data)

# Plot the structure of the trained neural network
plot(model)


#simulate some complicated data: 

# Generate a data frame with 10 predictor variables (explanatory variables)
# Each variable is a random normal distribution with 400 observations
explanatory <- data.frame(replicate(10, rnorm(400)))

# Assign column names to the explanatory variables using the first 10 letters of the alphabet
names(explanatory) <- letters[1:10]

# Create the response variable using a mathematical function of some explanatory variables
response <- with(explanatory, 
                 a * 2        # Variable 'a' contributes positively, multiplied by 2
                 - 0.5 * b    # Variable 'b' has a negative influence, scaled by -0.5
                 - i * j      # Interaction effect: product of 'i' and 'j' reduces the response
                 + exp(abs(c)) # Exponential transformation of absolute 'c', making it always positive
)

# Combine the explanatory variables and response variable into a single data frame
# Scale all variables (mean = 0, standard deviation = 1) to normalize data
data <- data.frame(scale(cbind(explanatory, response)))

# Randomly select 50% of the dataset for training
# `sample(nrow(data), nrow(data)/2)` randomly chooses half of the row indices from `data`
training <- sample(nrow(data), nrow(data) / 2)

# Train a neural network model using the `neuralnet` package
# The formula `response ~ a + b + c + d + e + f + g + h + i + j` specifies that 
# 'response' is the target variable, while 'a' to 'j' are predictor variables.
# `data[training, ]` uses only the training subset of the dataset.
# `hidden=5` sets the number of neurons in the hidden layer (a single hidden layer with 5 neurons).
model <- neuralnet(response ~ a + b + c + d + e + f + g + h + i + j,
                   data = data[training, ], 
                   hidden = 5)

# Compute predictions for the test dataset (remaining 50% of the data)
# `compute(model, data[-training, 1:10])` applies the trained model to new data (excluding the training indices).
# `$net.result[,1]` extracts the predicted response values from the model output.
predictions <- compute(model, data[-training, 1:10])$net.result[, 1]

# Evaluate the performance of the model using correlation between actual and predicted responses
# `cor.test()` calculates the Pearson correlation coefficient to assess how well the model's predictions
# align with the actual response values in the test dataset.
cor.test(predictions, data$response[-training])

# Visualize the trained neural network model
plot(model)

#Garson test can be used to what explanatory variables are important

library(NeuralNetTools)
garson(model, bar_plot=FALSE)
garson(model)

