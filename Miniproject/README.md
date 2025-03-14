# CMEE Miniproject: 

## Project Overview
This repository contains the code and analysis for the CMEE Miniproject focused on bacterial growth modeling. The project compares multiple mathematical models (Cubic, Logistic, and Gompertz) to determine which best fits empirical bacterial growth data across different temperature ranges.

## Key Objectives
- Clean and prepare bacterial growth rate dataset
- Fit and compare three alternative mathematical models:
  - Cubic polynomial model
  - Logistic growth model
  - Gompertz growth model
- Evaluate model performance using Information criteria and R-squared values
- Analyze effects of temperature on model performance

## Repository Structure

Here's the repository structure in markdown with bullet points:

## Repository Structure

* MiniProject/
  * code/
    * data-preparation.R            # Data cleaning and preparation
    * model-fitting.R               # Core model fitting functionality
    * model-validation-plotting.R   # Model comparison and visualization
    * run_miniproject.sh            # Master script to run the entire workflow
  * data/
    * LogisticGrowthData.csv        # Raw bacterial growth dataset and accompanying metadata
  * output/
    * all_best_models.csv           # Complete model comparison results
    * AICc_weight_violin.png        # Visualization of model weights
    * model_comparison_by_temp_ranges.png  # Visual model comparisons
    * low_temp_summary.csv          # Results for 0-12°C range
    * medium_temp_summary.csv       # Results for 12-25°C range
    * high_temp_summary.csv         # Results for 25-37°C range
    * total_temp_summary.csv        # Aggregate results across all temperatures

## Implemented Models

### 1. Cubic Polynomial Model
A flexible model that can capture different growth patterns using a third-degree polynomial function.

### 2. Logistic Growth Model
Models population growth with a sigmoidal curve, approaching a carrying capacity (K):

Where:
- N(t) is the population size at time t
- N_0 is the initial population size
- K is the carrying capacity
- r_max is the maximum growth rate

### 3. Gompertz Growth Model
A modified growth model that can account for lag phases in bacterial growth:

Where:
- ln(N(t)) is the natural log of the population size
- t_lag is the lag time before exponential growth
- Other parameters are similar to the logistic model

## Workflow: scripts source each other

### Data Preparation
The `data-preparation.R` script:
- Loads and cleans the bacterial growth dataset
- Removes negative values and incomplete experiments
- Groups data by experiment
- Performs log transformation for Gompertz model fitting
- Filters for experiments with sufficient data points

### Model Fitting
The `model-fitting.R` script:
- Fits all three models to each experimental group
- Uses non-linear least squares with multiple starting parameters
- Calculates comparative metrics (AIC, BIC, R-squared...)
- Handles convergence issues
- Uses parallel processing for computational efficiency

### Analysis and Visualization
The `model-validation-plotting.R` script:
- Analyzes model performance across temperature ranges
- Generates summary statistics for each temperature group
- Creates visualization of model fits
- Produces violin plots of AICc weights for model comparison

## Running the Analysis
To run the complete analysis, execute:

```bash
bash run_miniproject.sh