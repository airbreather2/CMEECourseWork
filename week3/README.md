# Week 3

Week 3 contains content from the following chapters: **Biological computing in R and Data management and visualisation in R**

additionally python scripts from the groupwork practicals in **biological computing in python 1** can be found at: 
[05_Electric_Emus GitHub Repository](https://github.com/airbreather2/05_Electric_Emus) final scripts are included in this weeks submission. 


#### languages used: 

- R 
- BASH

## Scripts in Code

### basic_io.R

- **Description**:  
  A simple script to illustrate R input-output operations. The script demonstrates how to:
  - Read a CSV file.
  - Write data to a new file.
  - Append data to an existing file.
  - Write data with and without row/column names.

  - **Arguments**:  
    This script does not require any arguments.

  - **Dependencies**:  
    - R environment.
    - CSV file located at `../data/trees.csv`.
    - The script uses standard R functions (`read.csv`, `write.csv`, `write.table`) available in all R installations.
    - Ensure the `../results/` directory exists for saving output files.

- **Usage**:  
  1. Make sure the working directory and file paths are correct.
  2. Run the script using the following syntax:
     ```bash
     Rscript basic_io.R
     ```
### control_flow.R

- **Description**:  
  This script demonstrates basic control flow structures in R such as conditional statements, for loops, and while loops. It also illustrates how to source another R script.

  - **Arguments**:  
    This script does not require any arguments.

  - **Dependencies**:  
    - Ensure the sourced file `Control_flow.R` exists in the working directory.
    - R environment.

- **Usage**:  
  1. Modify the working directory path in the script if necessary.
  2. Run the script using the following syntax:
     ```bash
     Rscript control_flow.R
     ```
### break.R

- **Description**:  
  This script demonstrates a simple `while` loop in R that runs until a break condition is met. It prints the value of `i` on each iteration and exits the loop when `i` equals 10.

  - **Arguments**:  
    This script does not require any arguments.

  - **Usage**:  
    1. Run the script using the following syntax:
       ```bash
       Rscript break.R
       ```
    - The script will print values of `i` from 0 to 9 until the break condition (when `i` equals 10) is met.


  - **Additional Notes**:
    - The script uses a `while` loop that will theoretically run infinitely (`i < Inf`), but it breaks out of the loop when `i == 10`.
    - It prints the value of `i` for each iteration before updating it.

### next.R

- **Description**:  
  This script demonstrates the use of the `next` statement within a `for` loop in R. The `next` statement allows you to skip specific iterations in the loop based on a condition. In this script, the loop skips over even numbers.

  - **Arguments**:  
    This script does not require any arguments.

  - **Usage**:  
    1. Run the script using the following syntax:
       ```bash
       Rscript next.R
       ```
    - The script will print the odd numbers between 1 and 10, skipping the even numbers.

  - **Additional Notes**:
    - The `next` statement is used within a `for` loop to skip iterations when the condition `(i %% 2 == 0)` is met (i.e., when `i` is an even number).
    - The script will only print the odd numbers between 1 and 10.

### boilerplate.R

- **Description**:  
  This script demonstrates the creation and testing of a simple R function (`MyFunction`) that accepts two arguments, prints their types, and returns them as a vector.

- **Arguments**:  
  This script does not require any arguments.

- **Dependencies**:  
  No external dependencies. The script uses standard R functions (`print`, `paste`, `class`, `ls`) available in all R installations.

- **Usage**:  
  1. Run the script using the following syntax:
     ```bash
     Rscript boilerplate.R
     ```
  - The script will:
    - Print the type of each argument passed to `MyFunction`.
    - Test `MyFunction` with numeric and character arguments.
    - List functions matching the pattern `MyFun*`.
    - Output the class of `MyFunction`.

- **Additional Notes**:  
  - The script includes test cases for both numeric and character input.
  - You can modify or extend `MyFunction` to accept other types of arguments or perform additional operations.

### R_conditionals.R

- **Description**:  
  This script contains three functions to check if a number is even, a power of 2, or a prime number.

  - **Functions**:
    1. `is.even(n)`: Checks if a number `n` is even. Returns a message indicating whether the number is even or odd.
    2. `is.power2(n)`: Checks if a number `n` is a power of 2. Returns a message indicating whether the number is a power of 2 or not.
    3. `is.prime(n)`: Checks if a number `n` is prime. Returns a message indicating whether the number is prime, composite, or a special case (0 or 1).

  - **Arguments**:  
    No arguments are required when running the script.

- **Dependencies**:  
  - No external libraries or packages are required. The script uses standard R functions.

- **Usage**:  
  1. To run the script, use the following command in a terminal:
     ```bash
     Rscript R_conditionals.R
     ```
  - The script will:
    - Define the three functions (`is.even`, `is.power2`, and `is.prime`).
    - Test the functions with specific values (e.g., 6 for `is.even`, 8 for `is.power2`, and 14 for `is.prime`).

- **Additional Notes**:  
  - You can modify the test cases in the script to check other numbers for evenness, power of 2, or prime status.
  - The functions can also be used interactively in an R session after sourcing the script.

### treeheights.R

- **Description**:  
  This script defines a function, `TreeHeight`, to calculate the height of a tree based on the distance from the tree's base and the angle of elevation to the top of the tree.

  - **Function**:
    - `TreeHeight(degrees, distance)`: 
      - **Arguments**:
        - `degrees`: The angle of elevation to the top of the tree, in degrees.
        - `distance`: The horizontal distance from the base of the tree, in meters (or other consistent units).
      - **Output**: Prints and returns the calculated height of the tree in the same units as `distance`.

  - **Arguments**:  
    No arguments are required when running the script itself. The function `TreeHeight` takes two inputs: `degrees` and `distance`.

- **Dependencies**:  
  No external libraries are required; the script uses standard R functions (`pi`, `tan`).

- **Usage**:  
  1. To run the script, use the following command in a terminal:
     ```bash
     Rscript treeheights.R
     ```
  - The script will:
    - Define the `TreeHeight` function.
    - Test the function with an example angle of 37 degrees and a distance of 40 meters.

- **Additional Notes**:  
  - You can modify the test values to check the height calculation for other trees by changing the `degrees` and `distance` arguments.
  - The function can also be used interactively in an R session by sourcing the script.

### Vectorise.R

- **Description**:  
  This script compares the execution time of summing all elements in a matrix using two methods:
  - A custom function that uses nested loops.
  - R's built-in vectorized `sum()` function, which is optimized for performance.

  - **Functions**:
    - `SumAllElements(M)`: A custom function that takes a matrix `M` and calculates the sum of its elements using nested loops.

  - **Arguments**:  
    This script does not require any arguments when running.

- **Dependencies**:  
  No external dependencies. The script uses standard R functions like `system.time` and `sum`.

- **Usage**:  
  1. To run the script, use the following command in a terminal:
     ```bash
     Rscript Vectorise.R
     ```
  - The script will:
    - Generate a 1000x1000 matrix of random values.
    - Measure and display the time taken to sum all elements using both the custom function and the built-in `sum()` function.

### preallocate.R

- **Description**:  
  This script compares the time efficiency of two methods for growing a vector in R:
  - A function that grows a vector within a loop without preallocation (`NoPreallocFun`).
  - A function that grows a vector with preallocation (`PreallocFun`).
  
  It demonstrates how preallocating memory for a vector improves performance in R.

  - **Functions**:
    1. `NoPreallocFun(x)`: A function that grows a vector by concatenating elements within a loop. This approach requires R to repeatedly reallocate memory, making it slower.
    2. `PreallocFun(x)`: A function that preallocates a vector and assigns elements directly, avoiding repeated memory allocation and improving speed.

  - **Arguments**:  
    This script does not require any arguments when running.

- **Dependencies**:  
  No external dependencies. The script uses standard R functions like `system.time`, `vector`, and `rep`.

- **Usage**:  
  1. To run the script, use the following command in a terminal:
     ```bash
     Rscript preallocate.R
     ```
  - The script will:
    - Measure and display the time taken to grow a vector using both non-preallocated and preallocated approaches.
    - Demonstrate the performance benefit of preallocation in R.

- **Additional Notes**:  
  - The `system.time` function is used to measure the time required by each method, highlighting the efficiency of preallocation.
  - This example is particularly useful for understanding the impact of preallocation in R, especially when working with large data structures.

### apply1.R

- **Description**:  
  This script demonstrates the use of the `apply` function in R to calculate row and column statistics in a matrix. It:
  - Generates a random 10x10 matrix.
  - Computes the mean and variance for each row.
  - Computes the mean for each column.

  - **Functions**:
    - `apply(M, 1, mean)`: Calculates the mean of each row.
    - `apply(M, 1, var)`: Calculates the variance of each row.
    - `apply(M, 2, mean)`: Calculates the mean of each column.

  - **Arguments**:  
    No arguments are required to run this script.

- **Dependencies**:  
  No external dependencies are required; it uses R’s built-in functions.

- **Usage**:  
  1. Run the script with the following command:
     ```bash
     Rscript apply1.R
     ```
  - The script will print:
    - The mean and variance of each row.
    - The mean of each column.

- **Additional Notes**:  
  - This script highlights the efficiency of the `apply` function for matrix operations in R.
  - The `apply` function allows for concise and efficient calculations across rows and columns.

### apply2.R

- **Description**:  
  This script demonstrates using the `apply` function in R to apply a custom function to each row of a matrix. It creates a 10x10 matrix of random values and applies a function that multiplies each row by 100 if the row sum is positive.

  - **Functions**:
    - `SomeOperation(v)`: A custom function that checks if the sum of a vector `v` is greater than zero. If true, it multiplies each element in the vector by 100; otherwise, it returns the vector unchanged.
    - `apply(M, 1, SomeOperation)`: Uses `apply` to apply `SomeOperation` to each row of matrix `M`.

  - **Arguments**:  
    No arguments are required to run this script.

- **Dependencies**:  
  No external dependencies are required; it uses R’s built-in functions.

- **Usage**:  
  1. Run the script with the following command:
     ```bash
     Rscript apply2.R
     ```
  - The script will:
    - Define and apply `SomeOperation` to each row of a randomly generated matrix.
    - Print the result for each row, modified based on the function’s criteria.

### sample.R

- **Description**:  
  This script demonstrates multiple methods for taking repeated samples from a population in R, including the use of loops with and without preallocation, as well as vectorized functions (`sapply` and `lapply`). It compares the time taken by each method to highlight the efficiency benefits of preallocation and vectorization.

  - **Functions**:
    1. `myexperiment(popn, n)`: Takes a sample of size `n` from `popn` without replacement and returns the mean.
    2. `loopy_sample1(popn, n, num)`: Uses a loop without preallocation to run `num` iterations of `myexperiment`.
    3. `loopy_sample2(popn, n, num)`: Uses a loop with preallocation to run `num` iterations of `myexperiment`.
    4. `loopy_sample3(popn, n, num)`: Uses a loop with preallocation on a list to run `num` iterations of `myexperiment`.
    5. `lapply_sample(popn, n, num)`: Uses `lapply` to vectorize `num` iterations of `myexperiment`.
    6. `sapply_sample(popn, n, num)`: Uses `sapply` to vectorize `num` iterations of `myexperiment` with simplified output.

  - **Arguments**:  
    No arguments are required when running the script.

- **Dependencies**:  
  No external dependencies; the script uses base R functions.

- **Usage**:  
  1. Run the script with the following command:
     ```bash
     Rscript sample.R
     ```
  - The script will:
    - Generate a population and take repeated samples.
    - Measure the execution time for each method and print the results.

- **Additional Notes**:  
  - This script provides a performance comparison of different sampling approaches, illustrating the speed of preallocation and vectorization in R.
  - Setting the seed ensures reproducibility of the random sampling.

### browse.R

- **Description**:  
  This script simulates exponential growth with a custom function and includes a debugging point using the `browser()` function, which pauses execution and opens an interactive debugging session during the first iteration of the loop.

  - **Functions**:
    - `Exponential(N0, r, generations)`: 
      - **Arguments**:
        - `N0`: Initial population size (default is 1).
        - `r`: Growth rate (default is 1).
        - `generations`: Number of generations to simulate (default is 10).
      - **Output**: A vector of population sizes over each generation.
      - **Browser Debugging**: The function enters debugging mode (via `browser()`) during the loop, allowing inspection of variables.

  - **Arguments**:  
    No arguments are required when running the script.

- **Dependencies**:  
  No external dependencies are required; it uses R’s built-in functions.

- **Usage**:  
  1. Run the script with the following command:
     ```bash
     Rscript browse.R
     ```
  - The script will:
    - Simulate exponential growth over several generations.
    - Enter debugging mode during the first loop iteration, where you can inspect variables.
    - Plot the growth model after completion.

- **Additional Notes**:  
  - The `browser()` function is useful for interactive debugging, allowing you to view and inspect variables during the loop.
  - Once in browser mode, you can type commands to inspect variables (`N`, `t`, etc.) and step through each iteration.

### try.R

- **Description**:  
  This script demonstrates error handling in R when calculating the mean of a sample from a population. It includes a custom function, `doit`, which samples from a population and calculates the mean if the sample has enough unique values. If not, it triggers an error. The script uses `try` to handle these errors, allowing continued execution even when some samples do not meet the unique value threshold.

  - **Functions**:
    - `doit(x)`: Samples a population `x` with replacement and calculates the mean if there are more than 30 unique values. If not, it raises an error.
    - `try(doit(x), FALSE)`: Wraps `doit` calls within `try` to handle errors without stopping the script.

  - **Arguments**:  
    No command-line arguments are required to run this script.

- **Dependencies**:  
  Requires no additional libraries; it uses base R functions.

- **Usage**:  
  1. Run the script with:
     ```bash
     Rscript try.R
     ```
  - The script will:
    - Generate a population of random values.
    - Attempt multiple samples from this population, calculate the mean for each, and handle errors where unique values are insufficient.
    - Store results (including errors) in a list.

- **Additional Notes**:  
  - The `try` function prevents the script from stopping due to errors, storing failed attempts in the results for later inspection.
  - Setting a seed ensures that random sampling is reproducible.

### DataWrang.R

- **Description**:  
  This script loads and wrangles the Pound Hill dataset, which initially lacks proper headers. The script handles missing values, reshapes the data from wide to long format, and performs some exploratory analysis.

  - **Functions and Workflow**:
    - **Load Data**: Loads the main dataset as a matrix and the metadata with headers.
    - **Inspect and Transpose**: Displays structure, transposes to make species columns.
    - **Data Cleaning**: Replaces blank cells with zeros to handle missing values.
    - **Reshape Data**: Converts the dataset from wide to long format using `melt` from `reshape2`.
    - **Data Exploration**: Uses tidyverse functions to summarize, filter, and manipulate the data for preliminary insights.

  - **Arguments**:  
    No command-line arguments are required.

- **Dependencies**:  
  Requires the following R packages:
  - `reshape2`: For reshaping data with `melt`.
  - `tidyverse`: For data manipulation functions such as `filter` and `glimpse`.

- **Usage**:  
  1. Run the script with:
     ```bash
     Rscript DataWrang.R
     ```
  - The script will:
    - Load and clean the dataset.
    - Convert it to long format.
    - Perform exploratory data analysis on species counts.

- **Additional Notes**:  
  - Ensure `PoundHillData.csv` and `PoundHillMetaData.csv` are available in the specified data directory.
  - This script demonstrates a sequence of data wrangling and exploration tasks that can be extended for further analysis.

### SQLinR.R

- **Description**:  
  This script demonstrates basic SQLite database operations in R. It creates an SQLite database, defines a table, inserts data, performs SQL queries, and imports additional data from a CSV file. The script also includes cleanup steps to close the database connection and remove data frames from the environment.

  - **Functions and Workflow**:
    - **Database Connection**: Opens a connection to an SQLite database (creates `Test.sqlite` if it does not exist).
    - **Create Table**: Defines a `Consumer` table to store species data.
    - **Insert Data**: Adds rows to the `Consumer` table using SQL `INSERT` statements.
    - **Query Data**: Retrieves records from `Consumer` using `SELECT` statements, including a conditional query.
    - **Import Data from CSV**: Imports data from `Resource.csv` and writes it to the database as a new table.
    - **Database Inspection**: Lists tables, displays columns, and reads data from the database.
    - **Cleanup**: Closes the database connection and removes data frames from the environment.

  - **Arguments**:  
    No command-line arguments are required to run this script.

- **Dependencies**:  
  - **sqldf**: To install and manage SQLite databases in R.
  - **tidyverse**: If required for additional data manipulation (optional).

- **Usage**:  
  1. Ensure `sqldf` is installed:
     ```r
     install.packages("sqldf")
     ```
  2. Run the script with:
     ```bash
     Rscript SQLinR.R
     ```
  - The script will:
    - Create and populate an SQLite database.
    - Perform SQL queries.
    - Import additional data from a CSV file (`Resource.csv`).

- **Additional Notes**:  
  - Ensure `PoundHillData.csv` and `Resource.csv` are available in the specified data directory.
  - This script is a useful template for working with SQLite databases in R.
  - Closing the database connection at the end of the script prevents potential data issues or memory leaks.

### Girko.R

- **Description**:  
  This script generates a visualization of eigenvalues from a random matrix overlaid on an ellipse representing a circular distribution. The plot is saved to a PDF file in the `results` directory.

  - **Functions and Workflow**:
    - **Directory Creation**: Checks if the `results` directory exists; if not, it creates it to store the output PDF.
    - **Ellipse Generation**: Defines `build_ellipse`, which constructs an ellipse data frame based on the specified radius.
    - **Matrix Generation**: Creates a 250x250 matrix of normally distributed random numbers.
    - **Eigenvalue Calculation**: Computes the eigenvalues of the random matrix and stores the real and imaginary components in a data frame.
    - **Plotting**: Plots the eigenvalues overlaid on an ellipse, with additional horizontal and vertical reference lines. The plot is saved as `Girko.pdf` in the `results` directory.

  - **Arguments**:  
    No command-line arguments are required to run this script.

- **Dependencies**:  
  Requires the following R package:
  - `tidyverse`: For data manipulation and plotting functions. Install it with:
    ```r
    install.packages("tidyverse")
    ```

- **Usage**:  
  1. Run the script with:
     ```bash
     Rscript Girko.R
     ```
  - The script will:
    - Generate an ellipse and plot eigenvalues overlaid on it.
    - Save the plot as `Girko.pdf` in the `results` directory.
    
### Mybars.R


## Description

This script generates a bar plot with multiple lineranges from a data file and saves the plot as a PDF in the `results` directory. The plot is created using `ggplot2` from the `tidyverse` package, which allows for flexible and clear data visualization.

## Dependencies

- **R version 4.0+**
- **tidyverse**: The script requires this package for data manipulation and plotting. It will be installed automatically if not already present.

## Usage

1. Place the required input data file `Results.txt` in the `data/` directory.

2. Run the script using one of the following methods:

   - **Command Line with Rscript**: Run the script with Rscript:
     ```bash
     Rscript Mybars.R
     ```
     
   - **R Environment**: Run the script directly within an R environment:
     ```r
     source("Mybars.R")
     ```

## Output

The plot will be saved as `MyBars.pdf` in the `results` directory, with:
- Three distinct lineranges in different colors.
- Custom x and y axis labels.
- Labels positioned below the x-axis for each `x` value.

If the `results/` directory does not exist, the script will create it.


- **Additional Notes**:  
  - Ensure that `tidyverse` is installed before running the script.
  - The PDF file is saved in `../results/Mybars.pdf` with page dimensions of 11.7 x 8.3 inches.

### plotLin.R

## Description

This script generates a scatter plot of simulated data points with a linear regression line overlaid. The color of each data point reflects the absolute residual from the linear regression model, ranging from black (low residuals) to red (high residuals). The plot also includes a mathematical expression label and is saved as a PDF in the results directory.

## Dependencies

- **R version 4.0+**
- **tidyverse**: The script requires this package for data manipulation and plotting. It will be installed automatically if not already present.

## Usage


2. Run the script using one of the following methods:

   - **Command Line with Rscript**: Run the script with Rscript:
     ```bash
     Rscript plotLin.R
     ```
     
   - **R Environment**: Run the script directly within an R environment:
     ```r
     source("plotLin.R")
     ```

## Output

The plot is saved as plotLin.pdf in the results directory, with:

- Scatter points representing the simulated data.
- A linear regression line shown in red.
- Color gradient of points based on the absolute residuals.
- Custom x-axis label with a mathematical expression.
- A mathematical label displayed as an annotation within the plot.
- If the results/ directory does not exist, the script will create it automatically.

### PP_Regress.R

- **Description**:  
  This script generates multiple plots containing linear regressions of predator and prey masses grouped by predator lifestage and feeding type from the EcolArchives-E089-51-D1 dataset. It also calculates regression coefficients for each group and saves them to a CSV file.

  - **Functions**:
    - The script does not define reusable functions but performs the following tasks:
      - Creates a combined dataset with log-transformed predator and prey masses.
      - Identifies groups with insufficient data for regression.
      - Generates regression plots faceted by feeding interaction type.
      - Saves regression results to a CSV file.

  - **Arguments**:  
    This script does not require any arguments when running.

- **Dependencies**:  
  - `ggplot2`: For data visualization.
  - `dplyr`: For data manipulation.
  - `broom`: For organizing regression results.
  - `purrr`: For functional programming operations.

- **Usage**:  
  1. To run the script, use the following command in a terminal:
     ```bash
     Rscript PP_Regress.R
     ```
  - The script will:
    - Load the dataset and preprocess it.
    - Generate a PDF file with regression plots (`test_Visualising_regression_analysis.pdf`).
    - Save a CSV file containing regression coefficients (`PP_Regress_Results.csv`).

### PP_Regress_loc.R

- **Description**:  
  This script generates multiple plots containing linear regressions of predator and prey masses grouped by predator lifestage and feeding type by location from the EcolArchives-E089-51-D1 dataset. It also calculates regression coefficients for each group and saves them to a CSV file.

  - **Functions**:
    - The script does not define reusable functions but performs the following tasks:
      - Creates a combined dataset with log-transformed predator and prey masses.
      - Identifies groups with insufficient data for regression.
      - Generates regression plots faceted by feeding interaction type.
      - Saves regression results to a CSV file.

  - **Arguments**:  
    This script does not require any arguments when running.

- **Dependencies**:  
  - `ggplot2`: For data visualization.
  - `dplyr`: For data manipulation.
  - `broom`: For organizing regression results.
  - `purrr`: For functional programming operations.

- **Usage**:  
  1. To run the script, use the following command in a terminal:
     ```bash
     Rscript PP_Regress_loc.R
     ```
  - The script will:
    - Load the dataset and preprocess it.
    - Generate a PDF file with regression plots (`test_Visualising_regression_analysis.pdf`).
    - Save a CSV file containing regression coefficients (`PP_Regress_bylocation_Results.csv`).
  
### Florida.R

- **Description**:  
  This script performs a permutation analysis on a temperature dataset from Key West, Florida. It calculates an observed correlation coefficient between year and temperature, generates a distribution of 100,000 random correlation coefficients by randomizing temperature values, and computes the fraction of random coefficients greater than the observed value to approximate a p-value. Additionally, it creates a scatterplot of temperature versus year with a regression line.

  - **Functions**:
    - The script does not define reusable functions but performs the following tasks:
      - Loads and visualizes the temperature dataset.
      - Calculates the observed correlation coefficient between year and temperature.
      - Randomizes temperature values and computes a null distribution of correlation coefficients.
      - Calculates a p-value based on the observed and random correlation coefficients.
      - Plots a scatterplot with a regression line.

  - **Arguments**:  
    This script does not require any arguments when running.

- **Dependencies**:  
  - Base R functions only; no additional packages are required.

- **Usage**:  
  1. To run the script, use the following command in a terminal:
     ```bash
     Rscript Florida.R
     ```
  - The script will:
    - Load the dataset (`KeyWestAnnualMeanTemperature.RData`).
    - Plot a scatterplot of temperature versus year, including a regression line.
    - Calculate and print the observed correlation coefficient of temperature against year.
    - Generate a distribution of random correlation coefficients (10000 iterations).
    - Compute and print an approximate p-value indicating if there is a significant relationship between year and temperature.

- **Outputs**:  
  - **Console**:
    - Observed correlation coefficient.
    - Approximate p-value.

  - **Plot**:
    - A scatterplot of temperature versus year with a regression line.

- **Notes**:  
  - Ensure the dataset `KeyWestAnnualMeanTemperature.RData` is stored in the `../data/` directory before running the script.
  - The p-value provides a measure of whether the observed correlation is statistically significant compared to a null hypothesis of no temporal correlation.


### Tautocorr.R

- **Description**:  
  This script analyzes temporal autocorrelation in annual mean temperatures for Key West. It calculates the observed correlation coefficient for consecutive years, conducts a permutation test to assess statistical significance, and generates a histogram of the permuted correlation coefficients.

  - **Functions**:
    - The script does not define reusable functions but performs the following tasks:
      - Loads and inspects the temperature dataset.
      - Computes the observed correlation coefficient between consecutive years.
      - Performs permutation testing to create a null distribution of correlation coefficients.
      - Calculates the p-value based on the observed correlation.
      - Generates and saves a histogram visualizing the results.

  - **Arguments**:  
    This script does not require any arguments when running.

- **Dependencies**:  
  - Base R functions only; no additional packages are required.

- **Usage**:  
  1. To run the script, use the following command in a terminal:
     ```bash
     Rscript Tautocorr.R
     ```
  - The script will:
    - Load the temperature dataset (`KeyWestAnnualMeanTemperature.RData`).
    - Compute the observed correlation coefficient and p-value.
    - Save a PDF file (`Coefficients.pdf`) in the `../results` directory, containing a histogram of permuted correlation coefficients with the observed correlation highlighted.

- **Outputs**:  
  - **Console**:
    - Observed correlation coefficient and its approximate p-value.
  - **Files**:
    - `Coefficients.pdf`: A histogram showing the null distribution of correlation coefficients and the observed value.

- **Notes**:  
  - Ensure the dataset `KeyWestAnnualMeanTemperature.RData` is stored in the `../data/` directory before running the script.
  - The script automatically creates the `../results` directory if it does not already exist.

#### compileLaTeX.sh

### Author
**Sebastian Dohne**  
<sed24@ic.ac.uk>  

### Description
`compileLaTeX.sh` is a shell script that automates the process of compiling a LaTeX document, opens the resulting PDF, and cleans up intermediate files. This script simplifies the workflow for LaTeX users by creating a dedicated output directory for the compiled files and ensuring the resulting PDF is opened automatically.

### Features
- Removes the `.tex` extension from the provided file name.
- Automatically creates a `results` directory for storing compiled files if it doesn't already exist.
- Compiles the LaTeX document twice to ensure proper linking of references and cross-references.
- Opens the generated PDF file in a viewer (e.g., `evince`).
- Cleans up auxiliary files (`.aux`, `.log`) to keep the directory tidy.

### Requirements
- **LaTeX Compiler**: `pdflatex` must be installed and accessible in the system's PATH.
- **PDF Viewer**: `evince` or another PDF viewer must be installed.

### Instructions
1. Save this script (`compileLaTeX.sh`) in the same directory as your LaTeX and BibTeX files.
2. Ensure the script is executable:
   ```bash
   chmod +x compileLaTeX.sh
```

# Data
This folder contains data mentioned for input in the above scripts: 

# Results
This folder contains the outputs of the above scripts

# Sandbox
this is the sandbox area, it contains files used for experimentation: 
