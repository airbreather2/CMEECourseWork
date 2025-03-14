#!/usr/bin/Rscript

#In this script, models will be fit to data and a final dataframe to be used for comparison generated

#############################
# 1. Setup and Data Loading #
#############################

# Load necessary packages
library(minpack.lm)   # For NLLS model fitting
library(parallel)     # For multicore processing

# Source data preparation script
# (Assumes that data is already cleaned and that 'group_data' has been split into group_list by group_id.)
source("data-preparation.R")

#initialise cores for parallelisation
n_cores <- detectCores() - 1
cat("Using", n_cores, "cores...\n")


#############################
# 2. Model Definitions      
#############################

# Cubic Model is handled by lm(... poly(Time, 3))

# Logistic Growth Model
logistic_model <- function(t, r_max, K, N_0) { 
  return( N_0 * K * exp(r_max * t) / (K + N_0 * (exp(r_max * t) - 1)) )
}

#Gompertz Growth Model (log scale) 
gompertz_model <- function(t, r_max, K, N_0, t_lag) {
  return(
    N_0 + (K - N_0) * exp(
      -exp(r_max * exp(1) * (t_lag - t) / ((K - N_0) * log(10)) + 1)
    )
  )
}

#############################
# 3. Utility Functions      #
#############################

# Calculate AICc:
calculate_AICc <- function(n, k, RSS) {
  AIC  <- n * log(RSS/n) + 2 * k
  AICc <- AIC + (2 * k * (k + 1)) / (n - k - 1)
  return(AICc)
}

# Calculate BIC:
calculate_BIC <- function(n, k, RSS) {
  return( n * log(RSS/n) + k * log(n) )
}

# Calculate R-squared:
calculate_Rsquared <- function(observed, predicted) {
  RSS <- sum((observed - predicted)^2)
  TSS <- sum((observed - mean(observed))^2)
  return(1 - RSS/TSS)
}

# Calculate adjusted R-squared:
calculate_adjusted_Rsquared <- function(observed, predicted, n, p) {
  # n = number of observations
  # p = number of parameters (excluding intercept)
  R_squared <- calculate_Rsquared(observed, predicted)
  adj_R_squared <- 1 - (1 - R_squared) * (n - 1) / (n - p - 1)
  return(adj_R_squared)
}

# Find Delta AIC/BIC and weights: 
calculate_model_metrics <- function(models_df) { #input data frame with fitted models to analyse
  models_df <- models_df %>%
    group_by(group_id) %>%  #select desired groups
    mutate( #add columns finding difference between AIC/BIC and minimum AIC/BIC (best model) 
      delta_AICc = AICc - min(AICc, na.rm = TRUE),
      delta_BIC  = BIC  - min(BIC,  na.rm = TRUE)
    ) %>%
    ungroup() %>%
    group_by(group_id) %>%
    mutate( #add columns with calculated AICc/BICc weights. 
      AIC_weight = exp(-0.5 * delta_AICc) / sum(exp(-0.5 * delta_AICc), na.rm = TRUE),
      BIC_weight = exp(-0.5 * delta_BIC)  / sum(exp(-0.5 * delta_BIC),  na.rm = TRUE)
    ) %>%
    ungroup()
  return(models_df)
}

#############################
# 4. Model Fitting Functions
#############################

# ---- Cubic Model ---- #
fit_cubic <- function(group_data) {
  tryCatch({
    model <- lm(PopBio ~ poly(Time, 3), data = group_data) #fit the cubic model to group IDs
    
    #list required metrics for our model
    R_squared <- summary(model)$r.squared #find r squared
    n  <- nrow(group_data) #find number of observations in group 
    k  <- length(coef(model)) #num of params
    
    # Calculate adjusted R-squared
    adj_R_squared <- calculate_adjusted_Rsquared(group_data$PopBio, predict(model), n, k-1)
    
    RSS <- sum(residuals(model)^2) #residual sum of squares
    AICc <- calculate_AICc(n, k, RSS) #AICc using values above
    BIC  <- calculate_BIC(n, k, RSS) #BIC using values above
    
    list( #return list of model metrics if convergence is reached 
      group_id  = unique(group_data$group_id),
      model     = model,
      coef      = coef(model),
      R_squared = R_squared,
      adj_R_squared = adj_R_squared,
      AICc      = AICc,
      BIC       = BIC,
      convergence = TRUE
    )
  }, error = function(e) {  #error handling incase model fails to fit 
    list(
      group_id  = unique(group_data$group_id),
      model     = NULL,
      coef      = c(Intercept = NA, `poly(Time, 3)1` = NA, 
                    `poly(Time, 3)2` = NA, `poly(Time, 3)3` = NA),
      R_squared = NA,
      adj_R_squared = NA,  # Add this line
      AICc      = NA,
      BIC       = NA,
      convergence = FALSE,
      error_message = as.character(e)
    )
  })
}

# ---- Logistic Model ---- #

fit_logistic <- function(group_data) {
  
  #initialize variables to track best performing model
  best_model    <- NULL
  best_R_squared <- -Inf
  best_adj_R_squared <- -Inf
  best_AICc      <- Inf
  best_BIC       <- Inf
  best_coef      <- c(r_max = NA, K = NA, N_0 = NA)
  
  set.seed(1234) # For reproducibility
  
  #repeat model fitting multiple times to find best fit with different starting values
  for (i in 1:200) {
    
    # fit starting parameters: random draws around min & max using normal distribution
    K_start   = rnorm(1, mean = max(group_data$PopBio) * 1.1, sd = 0.1)
    N_0_start = rnorm(1, mean = min(group_data$PopBio),        sd = 0.1)
    r_max_start = 0.1  
    
    # Bound-check if needed for model fitting, ensures model will be fit properly
    if (K_start <= 0)   K_start   <- max(group_data$PopBio) * 1.1
    if (N_0_start <= 0) N_0_start <- min(group_data$PopBio) 
    
    # Attempt model fit using parameters above for 100 iterations
    tryCatch({
      model <- nlsLM(
        PopBio ~ logistic_model(t = Time, r_max, K, N_0),
        data  = group_data,
        start = c(r_max = r_max_start, K = K_start, N_0 = N_0_start),
        lower = c(r_max = 0, K = max(group_data$PopBio) * 0.5, N_0 = 0), 
        control = nls.lm.control(maxiter = 100)
      )
      #calculates performance metrics to identify the best fitting model
      preds <- predict(model) #plot data
      R_squared <- calculate_Rsquared(group_data$PopBio, preds) #find rsquared based off of predicted model
      n   <- nrow(group_data) #num of datapoints 
      k   <- length(coef(model)) #num of parameters 
      RSS <- sum((group_data$PopBio - preds)^2) #residual sum of squares
      adj_R_squared <- calculate_adjusted_Rsquared(group_data$PopBio, preds, n, k) # find adj r squared
      AICc <- calculate_AICc(n, k, RSS) #AIC using values above
      BIC  <- calculate_BIC(n, k, RSS) #BIC using values above
      
      # First 10 iterations: accept model if it's the first valid one or has better R-squared
      # helps establish good initial models
      if (i <= 50 && (is.null(best_model) || R_squared > best_R_squared)) {
        best_model    <- model
        best_R_squared <- R_squared
        best_adj_R_squared <- adj_R_squared
        best_AICc      <- AICc
        best_BIC       <- BIC
        best_coef      <- coef(model)
      } 
      # After 10 iterations: only accept model if it has better AICc
      # This redefines the selection based on AICc once we have decent initial models
      else if (i > 50 && is.finite(AICc) && AICc < best_AICc) {
        best_model    <- model
        best_R_squared <- R_squared
        best_adj_R_squared <- adj_R_squared
        best_AICc      <- AICc
        best_BIC       <- BIC
        best_coef      <- coef(model)
      }
    }, 
    #error handling
    error = function(e) {})
  }
  #ensures at least 1 model is picked
  if (!is.null(best_model)) {
    list(
      group_id   = unique(group_data$group_id),
      model      = best_model,
      coef       = best_coef,
      R_squared  = best_R_squared,
      adj_R_squared = best_adj_R_squared,
      AICc       = best_AICc,
      BIC        = best_BIC,
      convergence = TRUE
    )
  } else {  #if no model was able to fit return values below
    list(
      group_id    = unique(group_data$group_id),
      model       = NULL,
      coef        = c(r_max = NA, K = NA, N_0 = NA),
      R_squared   = NA,
      adj_R_squared = NA,
      AICc        = NA,
      BIC         = NA,
      convergence = FALSE,
      error_message = "All fitting attempts failed"
    )
  }
}

# ---- Gompertz Model ---- #
 fit_gompertz <- function(group_data) {
  
  # Calculate a rough estimate for t_lag & r_max from slopes
  sorted_data <- group_data[order(group_data$Time), ] #order time data per group
  growth_rates <- diff(sorted_data$LogN) / diff(sorted_data$Time) #find the max growth acceleration (indicates where time lag ends as exponential growth begins)
  
  #error handling ensures values are assigned despite data
  if (length(growth_rates) > 0) {
    max_growth_idx <- which.max(growth_rates) #
    t_lag_estimate <- ifelse(max_growth_idx > 1, sorted_data$Time[max_growth_idx], 0) #assigns time lag estimate at maximum growth rate and insures time lag is 0 if max growth occurs immediately
    r_max_estimate <- max(growth_rates, na.rm = TRUE) #assigns max growth rate 
  } 
  #initialise variables for best model metrics to be reassigned
  best_model    <- NULL
  best_R_squared <- -Inf
  best_adj_R_squared <- -Inf
  best_AICc      <- Inf
  best_BIC       <- Inf
  best_coef      <- c(r_max = NA, K = NA, N_0 = NA, t_lag = NA)
  
  #fit model many times per group to find best fit with different starting parameters
  set.seed(1234)
  for (i in 1:200) {
    # Implement variation for starting parameters using normal dist
    K_start   <- rnorm(1, mean = max(group_data$LogN) * 1.1, sd = 0.1) #multiplying by 1.1 for slightly higher carrying capacity improved convergence rate
    N_0_start <- rnorm(1, mean = min(group_data$LogN),        sd = 0.1)
    r_max_start <- rnorm(1, mean = r_max_estimate,            sd = 0.05)
    t_lag_start <- rnorm(1, mean = t_lag_estimate,            sd = 0.2)
    
    # setting values to above 0 if assigned below so model can be fitted still
    if (K_start <= min(group_data$LogN))  K_start <- max(group_data$LogN) * 1.1
    if (N_0_start <= min(group_data$LogN)) N_0_start <- min(group_data$LogN)
    if (r_max_start <= 0) r_max_start <- r_max_estimate
    if (t_lag_start < 0)  t_lag_start <- 0
    
    #fitting the model
    tryCatch({
      model <- nlsLM(
        LogN ~ gompertz_model(t = Time, r_max, K, N_0, t_lag),
        data = group_data,
        start = c(
          r_max = r_max_start, 
          K     = K_start, 
          N_0   = N_0_start, 
          t_lag = t_lag_start
        ),
        lower = c(
          r_max = 1e-5, #low number prevents division by 0 errors
          K     = min(group_data$LogN), # carrying capacity must above at least the smallest observed value to fit model
          N_0   = min(group_data$LogN) -1, #since logged popbio for model so values can be negative
          t_lag = 0 
        ),
        control = nls.lm.control(maxiter = 300)
      )
      
      #calculate performance metrics to find best fitting model
      preds <- predict(model)
      R_squared <- calculate_Rsquared(group_data$LogN, preds)
      n   <- nrow(group_data)
      k   <- length(coef(model))
      adj_R_squared <- calculate_adjusted_Rsquared(group_data$LogN, preds, n, k)
      RSS <- sum((group_data$LogN - preds)^2)
      AICc <- calculate_AICc(n, k, RSS)
      BIC  <- calculate_BIC(n, k, RSS)
      
      # First 10 iterations: accept model if it's the first valid one or has better R-squared
      # This helps establish good initial models
      if (i <= 50 && (is.null(best_model) || R_squared > best_R_squared)) {
        best_model    <- model
        best_R_squared <- R_squared
        best_adj_R_squared <- adj_R_squared
        best_AICc      <- AICc
        best_BIC       <- BIC
        best_coef      <- coef(model)
      } 
      # After 10 iterations: only accept model if it has better AICc
      # This refines the selection based on AICc once we have decent initial models
      else if (i > 50 && is.finite(AICc) && AICc < best_AICc) {
        best_model    <- model
        best_R_squared <- R_squared
        best_adj_R_squared <- adj_R_squared
        best_AICc      <- AICc
        best_BIC       <- BIC
        best_coef      <- coef(model)
      }
    }, error = function(e) {})
  }
  #error handling to ensure model is fit if there is at least one that fit, and if not to assign values as NA 
  if (!is.null(best_model)) { 
    list(
      group_id   = unique(group_data$group_id),
      model      = best_model,
      coef       = best_coef,
      R_squared  = best_R_squared,
      adj_R_squared = best_adj_R_squared,
      AICc       = best_AICc,
      BIC        = best_BIC,
      convergence = TRUE
    )
  } else {
    list(
      group_id   = unique(group_data$group_id),
      model      = NULL,
      coef       = c(r_max = NA, K = NA, N_0 = NA, t_lag = NA),
      R_squared  = NA,
      adj_R_squared = NA,
      AICc       = NA,
      BIC        = NA,
      convergence = FALSE,
      error_message = "All fitting attempts failed"
    )
  }
}

#############################
# 6. Apply Fitting Functions
#############################

#message to signify models are being fit to groups using parallelisation
cat("Fitting models to", length(group_list), "groups using", n_cores, "cores...\n")

# Fit cubic
cubic_results <- mclapply(group_list, fit_cubic,    mc.cores = n_cores)
# Fit logistic
logistic_results <- mclapply(group_list, fit_logistic, mc.cores = n_cores)
# Fit Gompertz
gompertz_results <- mclapply(group_list, fit_gompertz, mc.cores = n_cores)

# Convert model results to data frames
cubic_df <- do.call(rbind, lapply(cubic_results, function(x) {
  if (is.null(x)) return(NULL)
  data.frame(
    group_id = x$group_id, 
    model = "cubic",
    Intercept = x$coef["(Intercept)"],
    Term1 = x$coef["poly(Time, 3)1"],
    Term2 = x$coef["poly(Time, 3)2"],
    Term3 = x$coef["poly(Time, 3)3"],
    R_squared = x$R_squared,
    adj_R_squared = x$adj_R_squared,
    AICc = x$AICc,
    BIC  = x$BIC,
    convergence = x$convergence,
    stringsAsFactors = FALSE
  )
}))

logistic_df <- do.call(rbind, lapply(logistic_results, function(x) {
  if (is.null(x)) return(NULL)
  data.frame(
    group_id = x$group_id, 
    model = "logistic",
    r_max = x$coef["r_max"],
    K     = x$coef["K"],
    N_0   = x$coef["N_0"],
    R_squared = x$R_squared,
    adj_R_squared = x$adj_R_squared,
    AICc      = x$AICc,
    BIC       = x$BIC,
    convergence = x$convergence,
    stringsAsFactors = FALSE
  )
}))

gompertz_df <- do.call(rbind, lapply(gompertz_results, function(x) {
  if (is.null(x)) return(NULL)
  data.frame(
    group_id = x$group_id, 
    model = "gompertz",
    r_max = x$coef["r_max"],
    K     = x$coef["K"],
    N_0   = x$coef["N_0"],
    t_lag = x$coef["t_lag"],
    R_squared = x$R_squared,
    adj_R_squared = x$adj_R_squared,
    AICc      = x$AICc,
    BIC       = x$BIC,
    convergence = x$convergence,
    stringsAsFactors = FALSE
  )
}))


#Show how many models have been successfully fitted
cat("\nCubic model: Successfully fitted", sum(cubic_df$convergence, na.rm = TRUE), 
    "of", length(group_list), "groups\n")
cat("Average AICc:", mean(cubic_df$AICc, na.rm = TRUE), "\n")

cat("\nLogistic model: Successfully fitted", sum(logistic_df$convergence, na.rm = TRUE), 
    "of", length(group_list), "groups\n")
cat("Average AICc:", mean(logistic_df$AICc, na.rm = TRUE), "\n")

cat("\nGompertz model: Successfully fitted", sum(gompertz_df$convergence, na.rm = TRUE), 
    "of", length(group_list), "groups\n")
cat("Average AICc:", mean(gompertz_df$AICc, na.rm = TRUE), "\n")

# Combine for model comparison 
all_models_df <- rbind(
  cubic_df[, c("group_id","model","R_squared", "adj_R_squared", "AICc","BIC","convergence")],
  logistic_df[, c("group_id","model","R_squared", "adj_R_squared", "AICc","BIC","convergence")],
  gompertz_df[, c("group_id","model","R_squared", "adj_R_squared", "AICc","BIC","convergence")]
)

####################################################
# Final dataframe used for model comparison and plotting (it will be refered to heavily from now on)
####################################################

#Calculate AIC and BIC weights and delta AIC and BIC
model_comparison <- calculate_model_metrics(all_models_df)

########################################################
# attach temperature values to fitted model df for comparison analysis by temperature
########################################################
# create a data frame with unique group_id and temperature values
temp_by_group <- data %>%
  group_by(group_id) %>%
  summarize(Temp = first(Temp)) %>%  # Use first() since temp is same for each group
  ungroup()

# join this all models df
model_comparison <- model_comparison %>%
  left_join(temp_by_group, by = "group_id")

#Same for measurement unit
unit_by_group <- data %>%
  group_by(group_id) %>%
  summarize(PopBio_units = first(PopBio_units)) %>%  # Use first() since temp is same for each group
  ungroup()

# join this all models df
model_comparison <- model_comparison %>%
  left_join(unit_by_group, by = "group_id")

#save dataframe in output
write.csv(model_comparison , "../output/all_best_models.csv", row.names = FALSE)



