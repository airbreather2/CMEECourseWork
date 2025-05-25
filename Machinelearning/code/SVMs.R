name <- "Sebastian Dohne"
preferred_name <- "Seb"
email <- "sed24@ic.ac.uk"
username <- "sed24"

#Modules
library(e1071)


# ------------------------------------------------------------------------------
# SIMPLIFIED SUMMARY OF SUPPORT VECTOR MACHINES (SVMs)
# ------------------------------------------------------------------------------
#
# 1. PURPOSE:
#    * SVMs are primarily used for classification: splitting data into groups.
#    * They can also be adapted for continuous outcomes or even "one-class"
#      tasks (e.g., predicting where a species might occur without knowing
#      where it doesn't occur).
#
# 2. BASIC IDEA:
#    * SVMs find a "separating hyperplane" (a line in 2D, a plane in 3D, etc.)
#      that divides two classes while maximizing the margin (distance from
#      the boundary to the closest points).
#    * Only the points on the boundary (the "support vectors") matter for
#      defining this hyperplane, which makes the method efficient even for
#      large datasets.
#
# 3. NON-LINEAR CLASSIFICATION:
#    * SVMs can use different "kernels" to fit more complex boundaries
#      (polynomial, radial, etc.), allowing them to handle complicated
#      data distributions.
#
# 4. WHEN TO USE:
#    * Whenever you need a robust classifier that can handle a variety of
#      data shapes and scales.
#    * One-class SVM variants are popular in ecology (e.g., species
#      distribution without absence data).
#
# 5. BOTTOM LINE:
#    * SVMs are powerful, flexible, and efficient.
#    * They require careful kernel selection and tuning.
#    * Deep theoretical understanding can be complex, but basic usage can
#      still offer strong performance in many classification tasks.

#################A Practical Example ###################################

#Simulate data: creating a dataset with 2 random variables and 2 points "in the middle" as somehow different

# 1. Create a data frame with 2 random variables:
#    * replicate(2, rnorm(1000)) generates 2 columns (x, X2),
#      each with 1000 random normal values.
data <- data.frame(replicate(2, rnorm(1000)))

# 2. Add a new column 'y' based on whether the sum of the two random columns
#    falls within a band around the median sum.
#    * rowSums(data) calculates x + X2 for each row.
#    * median(rowSums(data)) finds the median of those sums.
#    * We define 'y' as TRUE if the row sum is within ±1 of this median,
#      and FALSE otherwise.
data$y <- (rowSums(data) > (median(rowSums(data)) - 1)) &
  (rowSums(data) < (median(rowSums(data)) + 1))

# 3. Plot the first column of the data (named 'x') against its row index,
#    using different colors to indicate whether 'y' is TRUE or FALSE.
#    * pch=20 uses small solid dots.
#    * ifelse(y, "red", "black") sets point color to red for TRUE and black for FALSE.
with(data, plot(x,
                pch = 20,
                col = ifelse(y, "red", "black")))

data <- data.frame(replicate(2, rnorm(1000)))
data$y = (rowSums(data) > (median(rowSums(data)) - 1)) &
  (rowSums(data) < (median(rowSums(data)) + 1))
with(data, plot(x, pch=20, col=ifelse(y, "red", "black")))

#You could pretend, if you wanted, that the y variable here represented whether or not a particular species tends
#to be found in a particular climatic envelope. Pretend the x-axis in your plot represents the temperature of a
#series of sites, and the y-axis represents the humidity.

#finds the hyperplane by using support vectors with the lowest margin possible

#svms can be used on polynomial (left) and radial (right) kernals. 

training <- sample(nrow(data), nrow(data)/2)
model <- svm(y~., data=data[training,], type="C")
plot(model, data[training,])

#it fits our data well based on the output

#now to use independent data not used to train it 

table(predict(model, data[-training,]), data$y[-training])

# ------------------------------------------------------------------------------
# EXPLANATION: RESULTS OF OUR SVM MODEL AND IMPORTANT PARAMETERS
# ------------------------------------------------------------------------------
#
# * The contingency table shows we correctly classified most cases:
#   - We see large counts on the diagonal (TRUE predicted as TRUE,
#     FALSE predicted as FALSE).
#   - This suggests the model generalizes well, even to data
#     not used in training.
#

tune.svm(factor(y)~., data=data[-training,], gamma=c(.5,1,10), cost=c(1,10))
#
# * SVM PARAMETERS:
#   1. Cost (C):
#      - Governs how much error/misclassification the SVM
#        tolerates to maximize the margin.
#      - Higher cost forces fewer misclassifications but might overfit.
#
#   2. Gamma (γ):
#      - Controls the non-linearity of the kernel.
#      - Larger γ => More complex (non-linear) decision boundary.
#      - Risk of overfitting if the data isn’t actually that complex.
#
# * BEST PRACTICE:
#   - Always check performance on validation/test data to ensure your
#     choice of cost and γ generalizes beyond the training set.


# ------------------------------------------------------------------------------
# SVM EXTENSIONS: MULTICLASS & ONE-CLASS
# ------------------------------------------------------------------------------
#
# * Multiclass SVM:
#   1. One-vs-One: Fit pairwise classifications (class1 vs. class2, etc.).
#      Predict with the class winning most comparisons.
#   2. One-vs-All: Each class is vs. “the rest”; pick the class with
#      highest confidence.
#
# * One-Class SVM (common in ecology):
#   - Useful for “presence-only” data, e.g., species distributions without
#     reliable absence data.
#   - Often called niche modeling in ecological contexts.



