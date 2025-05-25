name <- "Sebastian Dohne"
preferred_name <- "Seb"
email <- "sed24@ic.ac.uk"
username <- "sed24"

#Modules

library(tree)
library(randomForest)
library(gbm)
library(lars)

########Notes on Chapter 4.4: Supervised Methods- trees, lassos and SVMS

######### Hands on with regression trees###########################

# ---------------------------------------------------------
# 1. DATA GENERATION
# ---------------------------------------------------------

# (1a) Create a data frame with all combinations of:
#      temperature, humidity, carbon, and herbivores.
#      The seq() function generates sequences; expand.grid() creates
#      every possible combination of those sequences.
data <- expand.grid(
  temperature = seq(0, 40, 4),   # 0, 4, 8, ... 40
  humidity    = seq(0, 100, 10), # 0, 10, 20, ... 100
  carbon      = seq(1, 10, 1),   # 1, 2, 3, ... 10
  herbivores  = seq(0, 20, 2)    # 0, 2, 4, ... 20
)

# (1b) Create a new column 'plants' initialized with random
#      uniform values between 3 and 5.
#      runif(n, min, max) generates 'n' random numbers in [min, max].
data$plants <- runif(nrow(data), 3, 5)

# (1c) Increase 'plants' proportionally to temperature:
#      For each row, plants += temperature * 0.1
data$plants <- with(data, plants + temperature * 0.1)

# (1d) If humidity > 50, increase 'plants' again by humidity * 0.05
data$plants[data$humidity > 50] <-
  with(data[data$humidity > 50, ], plants + humidity * 0.05)

# (1e) If carbon < 2, decrease 'plants' by carbon (i.e., plants -= carbon)
data$plants[data$carbon < 2] <-
  with(data[data$carbon < 2, ], plants - carbon)

# (1f) Increase 'plants' proportionally to herbivores:
#      plants += herbivores * 0.1
data$plants <- with(data, plants + herbivores * 0.1)

# (1g) For herbivores between 5 and 15 (exclusive),
#      reduce 'plants' by herbivores * 0.2
data$plants[data$herbivores > 5 & data$herbivores < 15] <-
  with(data[data$herbivores > 5 & data$herbivores < 15, ],
       plants - herbivores * 0.2)

# (1h) Finally, convert these continuous 'plants' values into integer counts
#      using a Poisson distribution with mean = 'plants'.
for (i in seq_len(nrow(data))) {
  data$plants[i] <- rpois(1, data$plants[i])
}


# ---------------------------------------------------------
# 2. TREE MODEL FITTING
# ---------------------------------------------------------

# (2a) Load the 'tree' package for decision tree modeling
library(tree)

# (2b) Randomly pick half the rows in 'data' as a training set
training <- sample(nrow(data), nrow(data)/2)

# (2c) Fit a regression tree to the training data,
#      using 'plants' as the response variable and
#      all other columns (.) as predictors.
model <- tree(plants ~ ., data = data[training, ])

# (2d) Plot the tree structure (nodes and splits)
plot(model)
text(model)

# (2e) Display a textual summary of the final tree
model
summary(model)


# ---------------------------------------------------------
# 3. MODEL EVALUATION
# ---------------------------------------------------------

# (3a) Compute correlation between predicted and actual 'plants'
#      for the test set (the half of the data not in training).
#      This gives an idea of how well the tree generalizes.
cor.test(predict(model, data[-training, ]),
         data$plants[-training])

# (3b) Perform cross-validation of the tree to see how deviance
#      changes with different tree sizes (pruning levels).
#      Then plot those results.
plot(cv.tree(model))




####################BAGGED REGRESSION TREES ###############################

#these help with overfitting compared to above

# Bagged Regression Trees (Bagging) Explained:
# 
# 1. Generate Multiple Bootstrap Samples:
#    - Draw random samples (with replacement) from the original dataset.
#    - Some points appear multiple times; others are omitted.
#
# 2. Train Separate Trees:
#    - For each bootstrap sample, fit a regression tree.
#    - Each tree is grown independently, capturing different data nuances.
#
# 3. Aggregate Predictions:
#    - For a new observation, predict with each tree and average the results.
#    - Averaging reduces model variance (stabilizes predictions) and often improves accuracy.
#
# Additional Points:
#    - Bagging helps mitigate overfitting by combining many "less stable" trees.
#    - It handles noisy data better than a single tree.
#    - Trade-off: lower interpretability compared to a single tree, but better predictive performance.

library(randomForest)
model <- randomForest(plants~., data=data[training,], mtry=ncol(data)-1)
cor.test(predict(model, data[-training,]), data$plants[-training])


# ------------------------------------------------------------------------------
# EXPLANATION: RANDOM FOREST, THE 'mtry' ARGUMENT, AND VARIABLE IMPORTANCE
# ------------------------------------------------------------------------------

# 1. The 'mtry' Argument
# ------------------------------------------------------------------------------
#   * 'mtry' in randomForest() controls how many explanatory variables are
#     considered each time a split is attempted in a tree.
#   * If you set mtry to the total number of variables, each split can use
#     any of your explanatory variables (like bagging).
#   * If mtry < total number of variables (the default), each time a split
#     is made, only a random subset of variables is considered.
#
# WHY IT MATTERS:
#   - This random restriction of variables at each split creates trees that
#     differ from one another more significantly (they're less correlated).
#   - Averaging several uncorrelated (or weakly correlated) models reduces
#     variance more effectively.
#   - In other words, when trees are too similar (highly correlated),
#     averaging doesn't reduce the variance as much.

# 2. Building a Random Forest
# ------------------------------------------------------------------------------
#   * Random Forest = Many bootstrapped trees + Randomly restricted
#     variables at each split.
#   * Each tree is grown on a bootstrapped sample of the data.
#   * Each split is chosen from a random subset of variables.
#   * "Decorrelating" your trees (making them less similar) helps improve
#     the ensemble's performance and reduces overfitting risk.

# 3. Variable Importance in Random Forest
# ------------------------------------------------------------------------------
#   * In a single regression tree, you can see splits directly to gauge
#     each variable's impact.
#   * In a random forest, you have hundreds or thousands of trees, so it's
#     not practical to inspect each one.
#   * Variable Importance:
#        - Usually reported as the "average decrease in Mean Squared Error"
#          (MSE) for regression problems, or "average decrease in Gini"
#          for classification.
#        - Interpreted somewhat like an "R-squared" for each variable.
#        - Helps you understand which variables most contribute to
#          predictive power across the entire forest.

# WHY IT'S USEFUL:
#   - Since you can't look at a single tree for interpretation,
#     variable importance scores provide a concise summary of how each
#     explanatory variable affects the predictions overall.
# ------------------------------------------------------------------------------

model <- randomForest(plants~., data=data[training,], importance=TRUE)
importance(model)
cor.test(predict(model, data[-training,]), data$plants[-training])

###########################################Boosted regression trees #################################################

# ------------------------------------------------------------------------------
# BOOSTED REGRESSION TREES (GBM) EXPLANATION
# ------------------------------------------------------------------------------
# Boosted regression trees are an extension of ordinary regression trees:
#   1. They fit a series of trees, where each new tree focuses on the residuals
#      (unexplained variation) from the previously fitted tree.
#   2. Each newly fitted tree’s predictions are added to the existing prediction
#      total, iteratively improving the fit.
#   3. The end result is a “boosted” model that combines the initial tree with
#      multiple smaller corrective trees.
#
# PROS:
#   * Tends to avoid overfitting by not letting any single tree dominate.
#   * Often achieves strong predictive performance.
#
# CONS:
#   * Less interpretable than a single tree, because many small trees collectively
#     produce the final prediction.
#
# TWO KEY PARAMETERS IN gbm():
#   1. distribution="poisson":
#       - Similar to how Generalized Linear Models (GLMs) can use a "link function".
#       - Here, if you have count data, “poisson” is appropriate. Otherwise, you can
#         leave it at the default or specify something else (e.g., "gaussian").
#   2. shrinkage (learning rate):
#       - Controls the influence of each successive tree.
#       - Smaller values => each tree has less impact, so more trees are needed.
#       - Generally, a lower shrinkage can improve accuracy but may increase
#         computation time.
#
# Below is a brief example using the 'gbm' package.
# ------------------------------------------------------------------------------

library(gbm)

# Fit a boosted regression tree model to Poisson (count) data
model <- gbm(
  plants ~ .,                 # Response ~ all predictors
  data = data[training, ],    # Use training subset
  distribution = "poisson"    # Specify Poisson for count data
)

summary(model)
# summary() gives variable importance and partial dependence info.
# A variable importance plot is often displayed automatically.

# Fit a second model with a larger shrinkage (=0.1),
# which places more weight on the later trees in the boosting sequence.
faster.model <- gbm(
  plants ~ ., 
  data = data[training, ], 
  distribution = "poisson", 
  shrinkage = 0.1
)
summary(faster.model)
# This can train faster, but might not be as accurate as a fine-tuned
# model with a smaller shrinkage value. Experimentation is key!

########################################LASSO Regression and least angle regression (LAR)########################################

#Are used to help find which explanatory variables can be discarded

# ------------------------------------------------------------------------------
# INTRODUCTION TO LASSO REGRESSION (AND LEAST ANGLE REGRESSION)
# ------------------------------------------------------------------------------
#
# 1. LEAST SQUARES VS. ABSOLUTE ERROR
#    * Up to now, you likely worked with ordinary least squares (OLS), minimizing
#      squared differences between observed and predicted values.
#    * Why squares? One reason: It treats over-prediction and under-prediction
#      symmetrically and is mathematically convenient.
#    * But in Lasso regression, we minimize absolute errors (modulus of residuals).
#      This is more difficult from a calculus standpoint but leads to useful
#      properties for feature selection.

# 2. LASSO REGRESSION: THE ‘L1 PENALTY’
#    * Lasso adds a constraint on the sum of absolute values of the coefficients
#      (the ‘L1 arc length’).
#    * This constraint penalizes large coefficients and encourages simplicity:
#      a smaller L1 means fewer coefficients are non-zero.
#    * Intuition: The simpler the model, the lower the penalty, which helps avoid
#      overfitting.

# 3. HOW DO WE FIND THE ‘BEST’ MODEL?
#    * We vary the penalty strength (lambda) to control how big the L1 arc length
#      can become.
#    * At very high penalty (very small arc length), nearly all coefficients are zero.
#    * As we relax the penalty (allow a larger arc length), more variables can have
#      non-zero coefficients.
#    * We look for a sweet spot where adding more complexity doesn’t sufficiently
#      improve model performance.

# 4. INTERPRETATION OF THE COEFFICIENT PATH
#    * In a coefficient path plot (Figure 4.1 reference), we start with all
#      coefficients at zero on the left (maximum penalty).
#    * As the penalty decreases (arc length increases), one or more coefficients
#      ‘enter’ the model at a time.
#    * We typically stop at a point where additional complexity yields little
#      extra explanatory power.

# 5. LEAST ANGLE REGRESSION (LAR)
#    * LAR is closely related to Lasso. In fact, its algorithmic approach can
#      be used to more efficiently compute Lasso solutions.
#    * Basic idea: As we decrease the penalty, the algorithm identifies the
#      variable most correlated with the current residual and starts to
#      increase its coefficient.
#    * When another variable becomes more correlated with the residual, we
#      bring that into the model too, adjusting the coefficients under the L1
#      constraint.
#    * Similar coefficient path to Lasso (the two panels in Figure 4.1 look alike).

# 6. KEY TAKEAWAYS
#    * Lasso = Minimizing absolute errors + an L1 penalty on coefficients.
#    * This naturally performs feature selection, as some coefficients can be
#      driven exactly to zero.
#    * Least Angle Regression (LAR) is a similar technique, often used as a
#      computationally efficient way to find Lasso solutions.
#    * Both methods reduce model complexity by penalizing large coefficients,
#      aiming to balance simplicity with predictive power.


#########Using it #######################
# We have a dataset of 1000 explanatory variables. Only two of which (columns 123 and 678) are significantly related to our data

# -------------------------------------------------------------------------
# EXPLANATION OF EACH LINE OF THE CODE
# -------------------------------------------------------------------------

# 1. Create a 1000 x 1000 matrix of random normal values.
#    Each of the 1000 columns is a predictor, and each column has 1000 observations.
explanatory <- replicate(1000, rnorm(1000))

# 2. Generate a response variable using two specific predictors from 'explanatory':
#    * predictor at column 123 is multiplied by 1.5
#    * predictor at column 678 is multiplied by -0.5
#    All other columns have no effect, so they're effectively noise.
response <- explanatory[, 123] * 1.5 - explanatory[, 678] * 0.5

# 3. Fit a Lasso model using the 'lars' package.
#    * 'explanatory' is the matrix of predictors
#    * 'response' is the target variable
#    * 'type = "lasso"' indicates we're fitting a Lasso (L1-penalized) path
model <- lars(explanatory, response, type = "lasso")

# 4. Plot the Lasso path, showing how each predictor’s coefficient changes
#    as we relax the penalty (move from left to right).
plot(model)

# -------------------------------------------------------------------------
# ADDITIONAL FUNCTION TO EXTRACT SIGNIFICANT COEFFICIENTS FROM THE MODEL
# -------------------------------------------------------------------------

# 5. Define a function that retrieves the final (last-step) coefficients from
#    the lars model, filtering out those below a chosen threshold in absolute value.
signif.coefs <- function(model, threshold = 0.001) {
  # Extract the matrix of coefficients at each step of the Lasso path
  coefs <- coef(model)
  
  # Find the row index of the last set of coefficients (the most relaxed penalty)
  # 'nrow(coefs)' is that row index.
  # Then select the columns where the absolute coefficient is larger than 'threshold'.
  signif <- which(abs(coefs[nrow(coefs), ]) > threshold)
  
  # Return a named vector of significant coefficients, with variable indices as names
  return(setNames(coefs[nrow(coefs), signif], signif))
}

# 6. Call 'signif.coefs' on our model to identify which predictors have
#    non-zero (or more than 'threshold') final coefficients.
#    Ideally, this should highlight columns 123 and 678 with coefficients
#    close to +1.5 and -0.5 respectively.
signif.coefs(model)


#####################################LEAST ANGLE REGRESSION #########################################


# ------------------------------------------------------------------------------
# EXPLANATION OF THE CODE: LEAST ANGLE REGRESSION (LAR) AND VARIABLE SCALING
# ------------------------------------------------------------------------------

# 1. Fit a model using Least Angle Regression (LAR) instead of Lasso.
#    'type="lar"' indicates we're using the LAR algorithm rather than the Lasso one.
model <- lars(explanatory, response, type = "lar")

# 2. Plot the LAR coefficient path. Similar to the Lasso plot, it shows
#    how each variable's coefficient changes as the penalty is relaxed.
plot(model)

# 3. Apply our previously defined function to extract the "significant"
#    final coefficients from the LAR model. Because the data was simulated
#    with two truly important variables, we expect to see them here.
signif.coefs(model)

# ------------------------------------------------------------------------------
# SCALING (NORMALIZING) VARIABLES
# ------------------------------------------------------------------------------
# Explanation:
#   * Many regression methods assume variables are on similar scales (or "z-scaled"),
#     i.e., each variable has mean = 0 and standard deviation = 1.
#   * Failing to scale variables can lead to numerical instability and can bias
#     the optimization routines towards variables with larger numerical ranges.
#   * By default, 'lars' normalizes variables, but we can turn that off by setting
#     'normalize=FALSE'.

# 4. Fit a "bad" LAR model with normalization turned off.
#    Because our 'explanatory' data is standard normal, we wouldn't
#    usually see a big problem here. But let's see how it behaves.
bad.model <- lars(explanatory, response, type = "lar", normalize = FALSE)

# 5. Extract coefficients with threshold = 0, forcing the function to show
#    every coefficient, including tiny ones. Notice that many more variables
#    might appear with non-zero coefficients.
signif.coefs(bad.model, thresh = 0)

# 6. Compare with the "good" model that uses the default normalization.
#    Because variables are normalized here, we don't see a bunch of tiny,
#    spurious coefficients.
signif.coefs(model, thresh = 0)

# Conclusion:
#   * When variables differ widely in scale, turning off normalization can
#     lead to misleading results (huge or tiny coefficients in the final model).
#   * Normalizing (scaling) variables is generally good practice before
#     fitting regressions, especially when using methods like Lasso or LAR.







