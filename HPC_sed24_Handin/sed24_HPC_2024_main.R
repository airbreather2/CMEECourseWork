# CMEE 2024 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

name <- "Sebastian Dohne"
email <- "sed24@ic.ac.uk"
username <- "sed24"

# Please remember *not* to clear the work space here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

# Section One: Stochastic demographic population model

#Necessary modules include: ggplot2 and parallel, they are loaded within functions when run 

##### source necessary functions
source("Demographic.R")


# Question 0

#Initialize community state consisting of adults only
# Example Input: state_initialise_adult(6, 100)
# Example Output: c(0, 0, 0, 0, 0, 100)
state_initialise_adult <- function(num_stages, initial_size) {
  adult <- rep(0, num_stages) #initialise adult vector
  adult[length(adult)] <- initial_size  # Use round brackets, not square brackets (assigns the initial size to the last index of adult vector)
  return(adult)
}

#initialise community spread across life stages
# Example Input: num_stages = 5, initial_size = 18
# Example Output: c(4, 4, 4, 3, 3)
# Explanation: 18 ÷ 5 = 3 with remainder 3, first 3 stages get +1
state_initialise_spread <- function(num_stages, initial_size) {
  # Create a vector with the base value distributed evenly
  even_spread <- rep(floor(initial_size / num_stages), num_stages) #assigns size of pop divided by number of stages across a vector length num of stages
  
  # Calculate the remainder to distribute
  if (initial_size %% num_stages != 0) {  # Fix: Use '!=' instead of '=!'
    remainder <- initial_size %% num_stages
    
    # Distribute the remainder across the first few stages
    for (i in 1:remainder) {
      even_spread[i] <- even_spread[i] + 1
    }
  }
  
  return(even_spread)
}


# Question 1

#simulate deterministic population growth using a matrix for spread and adult only community as initial conditions and create a plot: question1.png
question_1 <- function() {
  
  
  num_stages = 4
  simul_length= 24
  initial_adult = 100
  initial_spread = 100
  
  
  # Use the input variables
  adult <- state_initialise_adult(num_stages, initial_adult)
  spread <- state_initialise_spread(num_stages, initial_spread)
  
  growth_matrix <- matrix(
    c(0.1, 0.0, 0.0, 0.0, 
      0.5, 0.4, 0.0, 0.0, 
      0.0, 0.4, 0.7, 0.0, 
      0.0, 0.0, 0.25, 0.4), 
    nrow = num_stages, ncol = num_stages, byrow = TRUE
  )
  
  reproduction_matrix <- matrix(
    c(0.0, 0.0, 0.0, 2.6, 
      0.0, 0.0, 0.0, 0.0, 
      0.0, 0.0, 0.0, 0.0, 
      0.0, 0.0, 0.0, 0.0), 
    nrow = num_stages, ncol = num_stages, byrow = TRUE
  )
  
  projection_matrix <- reproduction_matrix + growth_matrix
  
  line1 <- deterministic_simulation(adult, projection_matrix, simul_length)
  
  line2 <- deterministic_simulation(spread, projection_matrix, simul_length)
  
  # Save output as a PNG file
  png(filename = "question_1.png", width = 600, height = 400)
  
  matplot(cbind(line1, line2), type="l", col = c("red", "blue"), lwd=2, lty = 1, main="Deterministic Population growth", xlab="Generations", ylab="Population" )
  
  #add legend
  legend("topright", legend = c("Adult Population", "Spread Population"), 
         col = c("red", "blue"), lty = 1, lwd=2, cex=0.8)
  
  Sys.sleep(0.1)
  dev.off()
  
  return("A higher initial adult count leads to a rapid population increase in early generations due to more mature individuals contributing to reproduction. This effect is driven by the reproduction matrix, where only Stage 4 individuals produce offspring. Over time, the population growth rate depends on survival probabilities and transition rates between life stages.")
} # 


# Question 2
#simulate stochastic population growth using a matrix for spread and adult only community as initial conditions and create a plot :question2.png


question_2 <- function() {
  
  # Define input variables
  num_stages <- 4
  simul_length <- 24
  initial_adult <- 100
  initial_spread <- 100
  
  # Use the initial state functions
  adult <- state_initialise_adult(num_stages, initial_adult)
  spread <- state_initialise_spread(num_stages, initial_spread)
  
  
  # Define the growth and reproduction matrices
  growth_matrix <- matrix(
    c(0.1, 0.0, 0.0, 0.0, 
      0.5, 0.4, 0.0, 0.0, 
      0.0, 0.4, 0.7, 0.0, 
      0.0, 0.0, 0.25, 0.4), 
    nrow = num_stages, ncol = num_stages, byrow = TRUE
  )
  
  reproduction_matrix <- matrix(
    c(0.0, 0.0, 0.0, 2.6, 
      0.0, 0.0, 0.0, 0.0, 
      0.0, 0.0, 0.0, 0.0, 
      0.0, 0.0, 0.0, 0.0), 
    nrow = num_stages, ncol = num_stages, byrow = TRUE
  )
  
  # Define the clutch distribution
  clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)
  
  # Run the stochastic simulations using the initial states
  line1 <- stochastic_simulation(adult, growth_matrix, reproduction_matrix, clutch_distribution, simul_length)
  line2 <- stochastic_simulation(spread, growth_matrix, reproduction_matrix, clutch_distribution, simul_length)
  
  
  # Plot the results and save as a PNG file
  png(filename = "question_2.png", width = 600, height = 400)
  
  matplot(
    cbind(line1, line2), type = "l", col = c("red", "blue"), lwd = 2, lty = 1,
    main = "Stochastic Population Growth", xlab = "Generations", ylab = "Population"
  )
  #add legend
  legend("topright", legend = c("Adult Population", "Spread Population"), 
         col = c("red", "blue"), lty = 1, lwd=2, cex=0.8)
  
  dev.off()  # Close the graphics device
  
  return("Stochasticity in recruitment and survival introduces variation in population growth, unlike deterministic models, which follow a fixed trajectory. In nature, environmental (abiotic) factors such as climate fluctuations and resource availability, as well as biological (biotic) interactions like predation and competition, cause unpredictable changes in survival and reproduction rates. This added variability leads to more realistic population dynamics, where population size fluctuates due to random effects rather than following a fixed pattern. ")
}


  # Questions 3 and 4 involve writing code elsewhere to run your simulations on the cluster

  
# Question 5
# Function analyzes multiple simulation files to calculate extinction rates for 4 initial population conditions: Large Adult, Small Adult, Large Spread, Small Spread
#
# Example Input: function call with no parameters
# Example Output: Returns a text explanation of findings after:
# 1. Loading multiple .rda files containing simulation results
# 2. Counting extinctions for each condition
# 3. Creates a bar plot with extinction counts
# 4. Saves plot as "question_5.png"

  question_5 <- function() {
    
    rdafiles <- list.files(path = "Demographic_output_data/.", pattern = ".*[0-9]+\\.rda$", full.names = TRUE)
    
    print(rdafiles)  # Debugging: Check if any files are found
    
    if (length(rdafiles) == 0) {
      stop("No .rda files found in directory")
    }
    
    # 1. Define counters for each condition’s total extinctions and total runs
    LA_extinction_counter <- 0
    SA_extinction_counter <- 0
    LS_extinction_counter <- 0
    SS_extinction_counter <- 0
    LA_total_sims <- 0
    SA_total_sims <- 0
    LS_total_sims <- 0
    SS_total_sims <- 0
    
    # 2. Loop over every .rda file
    for (f in seq_along(rdafiles)) {
      file_path <- rdafiles[f]
      # Extract HPC job index from filename, e.g. "output_17.rda" => 17
      file_name <- basename(file_path)  # "output_17.rda"
      iter_str  <- sub("output_(\\d+)\\.rda", "\\1", file_name)
      job_idx   <- as.numeric(iter_str)
      
      # 3. Determine the condition name the same way the cluster script does
      mod_val <- job_idx %% 4
      if (mod_val == 1) {
        cond_name <- "large spread"
      } else if (mod_val == 2) {
        cond_name <- "small adult"
      } else if (mod_val == 3) {
        cond_name <- "small spread"
      } else {
        # mod_val == 0
        cond_name <- "large adult"
      }
      
      # Load the HPC object "simulation_results"
      load(file_path)
      
      # Count total simulations in this file
      num_simulations <- length(simulation_results)
      # Determine how many ended in extinction (final pop == 0)
      extinct_vec <- sapply(simulation_results, function(x) tail(x, 1) == 0)
      n_extinct   <- sum(extinct_vec)
      
      # 4. Update counters for whichever condition
      if (cond_name == "large adult") {
        LA_extinction_counter <- LA_extinction_counter + n_extinct
        LA_total_sims         <- LA_total_sims + num_simulations
      } else if (cond_name == "small adult") {
        SA_extinction_counter <- SA_extinction_counter + n_extinct
        SA_total_sims         <- SA_total_sims + num_simulations
      } else if (cond_name == "large spread") {
        LS_extinction_counter <- LS_extinction_counter + n_extinct
        LS_total_sims         <- LS_total_sims + num_simulations
      } else if (cond_name == "small spread") {
        SS_extinction_counter <- SS_extinction_counter + n_extinct
        SS_total_sims         <- SS_total_sims + num_simulations
      }
    }
    
    # 5. Compute proportions for each condition
    large_adult_extinction  <- LA_extinction_counter / LA_total_sims
    small_adult_extinction  <- SA_extinction_counter / SA_total_sims
    large_spread_extinction <- LS_extinction_counter / LS_total_sims
    small_spread_extinction <- SS_extinction_counter / SS_total_sims
    
    # Print an extinction summary
    cat("---- Extinction Counts ----\n")
    cat("Large Adult Extinctions:", LA_extinction_counter, "/", LA_total_sims, "\n")
    cat("Small Adult Extinctions:", SA_extinction_counter, "/", SA_total_sims, "\n")
    cat("Large Spread Extinctions:", LS_extinction_counter, "/", LS_total_sims, "\n")
    cat("Small Spread Extinctions:", SS_extinction_counter, "/", SS_total_sims, "\n\n")
    
    # 6. Create a barplot of all 4 proportions
    extinction_rates <- c(
      large_adult_extinction,
      small_adult_extinction,
      large_spread_extinction,
      small_spread_extinction
    )
    
    labels <- c("Large Adult", "Small Adult", "Large Spread", "Small Spread")
    
    cat("---- Extinction Proportions ----\n")
    print(extinction_rates)
    
    # Save a barplot
    png("question_5.png", width = 600, height = 400)
    barplot(
      extinction_rates,
      names.arg = labels,
      xlab = "Initial Condition",
      ylab = "Proportion of simulations that ended in extinction",
      main = "Extinction Probabilities by Initial Condition",
      col = "skyblue"
    )
    dev.off()
    
    print("Simulation analysis complete")
    return("Stochastic simulations with small initial population sizes are are more prone to extinction due to a higher vulnerability to variability within the stochastic model. Inital states containing only mature adults reach extinction in less cases due to an initial uptick in new juveniles in early stages reducing vulnerability to variation in population")
  }
  

# Question 6
  
  # Function compares deterministic vs. stochastic population models for spread populations
  #
  # Input: None
  # Output: 
  # 1. Creates "question_6.png" which shows deviation between models for small and large spread conditions
  # 2. Returns text explaining which initial condition is better approximated by deterministic model
  # 
  # Process:
  # - Loads simulation data for small/large spread populations (initial conditions 3 & 4)
  # - Calculates averaged population trend across stochastic simulations
  # - Runs deterministic simulations using the same projection matrix
  # - Computes deviation ratio (stochastic/deterministic) at each time step
  # - Plots deviation as two-paneled graph

  question_6 <- function() {
    
    # -----------------------------
    # 1) FIND .RDA FILES
    # -----------------------------
    rda_files <- list.files(
      path = "Demographic_output_data/.",         # directory to look in
      pattern = ".*[0-9]+\\.rda$",     # only .rda files
      full.names = TRUE        # include full path
    )
    
    if (length(rda_files) == 0) {
      stop("No .rda files found in 'output' directory.")
    }
    
    # -----------------------------
    # 2) INITIAL SETUP & MATRICES
    # -----------------------------
    num_stages   <- 4
    simul_length <- 120
    
    # HPC code sets large_spread=100, small_spread=10 (initial conditions 3 and 4)
    large_initial_spread <- 100
    small_initial_spread <- 10
    
    # Spread these totals among 4 stages
    large_spread_state <- state_initialise_spread(num_stages, large_initial_spread)
    small_spread_state <- state_initialise_spread(num_stages, small_initial_spread)
    
    #initialise growth and reproduction matrices
    growth_matrix <- matrix(
      c(0.1, 0.0, 0.0, 0.0, 
        0.5, 0.4, 0.0, 0.0, 
        0.0, 0.4, 0.7, 0.0, 
        0.0, 0.0, 0.25, 0.4),
      nrow = num_stages, byrow = TRUE
    )
    
    reproduction_matrix <- matrix(
      c(0.0, 0.0, 0.0, 2.6,
        0.0, 0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 0.0, 
        0.0, 0.0, 0.0, 0.0),
      nrow = num_stages, byrow = TRUE
    )
    
    projection_matrix <- reproduction_matrix + growth_matrix
    
    # -----------------------------
    # 3) DETERMINISTIC SIMULATIONS
    # -----------------------------
    # deterministic_simulation() returns a length-121 numeric vector (time=0..120)
    
    det_large_spread <- deterministic_simulation(large_spread_state, projection_matrix, simul_length)
    det_small_spread <- deterministic_simulation(small_spread_state, projection_matrix, simul_length)
    
    # -----------------------------
    # 4) ACCUMULATORS FOR STOCHASTIC
    # -----------------------------
    total_sims_sum_large <- rep(0, simul_length + 1)  # length 121
    total_sims_sum_small <- rep(0, simul_length + 1)
    
    count_large <- 0
    count_small <- 0
    
    # -----------------------------
    # 5) LOOP OVER .rda FILES
    # -----------------------------
    for (f in seq_along(rda_files)) {
      
      file_path <- rda_files[f]
      # Load simulation_results (list of numeric vectors, each length ~121)
      load(file_path)  
      
      # Extract HPC job index, e.g. "output_17.rda" => 17
      file_name <- basename(file_path)
      iter_str  <- sub("output_(\\d+)\\.rda", "\\1", file_name)
      job_idx   <- as.numeric(iter_str)
      
      # HPC logic: 0=large_adult, 1=large_spread, 2=small_adult, 3=small_spread
      mod_val <- job_idx %% 4
      if (mod_val == 1) {
        cond_name <- "large spread"
      } else if (mod_val == 3) {
        cond_name <- "small spread"
      } else {
        # skip large_adult(0) & small_adult(2)
        next
      }
      
      # simulation_results is a list of length 150 (by default),
      # each element is a numeric vector of length 121
      for (i in seq_along(simulation_results)) {
        sim_vec <- simulation_results[[i]]
        # keep all 121 points:
        
        if (cond_name == "large spread") {
          total_sims_sum_large <- total_sims_sum_large + sim_vec
          count_large <- count_large + 1
        } else {
          # small spread
          total_sims_sum_small <- total_sims_sum_small + sim_vec
          count_small <- count_small + 1
        }
      }
    }
    
    # -----------------------------
    # 6) AVERAGE STOCHASTIC TRENDS
    # -----------------------------
    mean_large_spread <- total_sims_sum_large / max(count_large, 1)
    mean_small_spread <- total_sims_sum_small / max(count_small, 1)
    
    # -----------------------------
    # 7) COMPUTE DEVIATION
    # -----------------------------
    # Ratio of mean stochastic to deterministic, each length 121
    
    deviation_large <- mean_large_spread / det_large_spread
    deviation_small <- mean_small_spread / det_small_spread
    
    # -----------------------------
    # 8) MAKE THE PLOT
    # -----------------------------
    png("question_6.png", width = 600, height = 400)
    
    # Time axis = 0..120
    time_axis <- 0:simul_length
    
    # Set up a 1-row, 2-column layout to produce two separate panels
    par(mfrow = c(1, 2))
    
    # Panel 1: Large spread
    plot(
      time_axis, deviation_large, type = "l", col = "blue",
      ylim = c(0.95, max(deviation_large, na.rm = TRUE) * 1.03),
      xlab = "Time step", ylab = "Deviation (Stochastic / Deterministic)",
      main = "Deviation: Large Spread"
    )
    abline(h = 1, col = "darkgray", lty = 2)  # reference line at 1
    
    # Panel 2: Small spread
    plot(
      time_axis, deviation_small, type = "l", col = "red",
      ylim = c(0.95, max(deviation_small, na.rm = TRUE) * 1.03),
      xlab = "Time step", ylab = "Deviation (Stochastic / Deterministic)",
      main = "Deviation: Small Spread"
    )
    abline(h = 1, col = "darkgray", lty = 2)
    
    dev.off()
    
    # -----------------------------
    # 9) RETURN WRITTEN ANSWER
    # -----------------------------
    return(
      paste(
        "For the large-spread initial condition, the deterministic model",
        "more closely approximates the average stochastic trend. When the",
        "initial population is large, random variation has a smaller relative",
        "impact on population, so the mean stochastic trajectory remains closer to deterministic in comparison to the small-spread initial condition"
      )
    )
  }
  
# Section Two: Individual-based ecological neutral theory simulation 

# Question 7: Find species richness in vector: 
  #example: 
  #input:species_richness(c(1,4,4,5,1,6,1))
  #output: returns 4 
  
species_richness <- function(community){  #requires vector
  s_richness <- length(unique(community)) #find most common value within vector
  return(s_richness)
}

# Question 8: generate vector of max community size.
# Example:
# Input: 5
# Expected Output: 1 2 3 4 5

init_community_max <- function(size) {
  # This function initializes a community of the specified size
  # with the maximum possible number of distinct species.
  # Each individual in the community is assigned a unique species ID numerically.
  
  # Generate a sequence from 1 up to 'size'
  max_size <- seq(1:size)
  
  # Return this sequence as the community
  return(max_size)
}

# Question 9: initialise community with monodominance of species
# Example usage:
# Input: 5
# Expected Output: 1 1 1 1 1
init_community_min <- function(size) {
  # This function initializes a community of the specified size
  # where all individuals belong to the same species (monodominance).
  
  # Create a vector of length 'size' where all elements are species 1
  min_size <- rep(1, size)
  
  # Return the community
  return(min_size)
}

# Question 10: 
# This function selects two distinct random integers from 1 to max_value.
# The numbers are chosen with equal probability.
# example usage:
# Possible outputs for choose_two(4): c(3, 4), c(1, 2), c(2, 4), etc.

choose_two <- function(max_value) {

  # Generate a random sample of 2 unique numbers between 1 and max_value
  random_int <- sample(1:max_value, 2) 
  
  # Return the selected numbers as a vector
  return(random_int)
}


# Question 11: Neutral Step: 
# Example usage:
# If community = c(1, 2), neutral_step(c(1,2)) could return c(1,1) or c(2,2)

neutral_step <- function(community) {
  # This function performs one step of a neutral model simulation.
  # It selects one individual to die and another to reproduce.
  
  # Choose two distinct indices in the community
  indices <- choose_two(length(community))
  
  # One individual (first in indices) dies and is replaced by the species of the second
  community[indices[1]] <- community[indices[2]]
  
  # Return the updated community
  return(community)
}


# Question 12
#Example: simulate a generation in a community by performing x/2 neutral steps
# If community = c(1, 2, 3, 4), this will perform 2 neutral steps (either floor(4/2) = 2 or ceiling(4/2) = 2)

neutral_generation <- function(community) {
  # If there's only one individual, nothing changes
  if (length(community) == 1) {
    return(community)
  }
  
  # Determine the number of neutral steps for one generation
  generations <- sample(c(floor(length(community) / 2), ceiling(length(community) / 2)), 1)
  
  # Perform the determined number of neutral steps
  for (i in 1:generations) {
    community <- neutral_step(community)
  }
  
  # Return the updated community after one generation
  return(community)
}


# Question 13: Time Series of Species Richness
# Example usage:
# If community = c(1,2,3,4,5,6), neutral_time_series(community, 10) 
# could return c(6,6,5,5,4,4,4,3,3,2,2)

neutral_time_series <- function(community, duration) {
  # Initialize species richness list
  richness_vector <- numeric(duration + 1)  
  richness_vector[1] <- species_richness(community)  
  
  for (i in 2:(duration + 1)) {  
    community <- neutral_generation(community)  
    richness_vector[i] <- species_richness(community)  
  }
  
  return(richness_vector)  
}


# Question 14: Plot Species Richness Over Time
# Example usage:
# question_14() will save "results/question_14.png" and return final richness vector.

species_richness_over_time <- function() {
  
  # Initialize community with maximal diversity (100 species)
  communityfortimeseries <- init_community_max(100) 
  
  # Run simulation for 200 generations
  simulation_data <- neutral_time_series(communityfortimeseries, 200)
  
  # Generate sequence for x-axis (generations)
  generations <- seq_along(simulation_data)  
  
  # Extract the final species richness value
  final_value <- tail(simulation_data, 1)
  
  # Save plot as PNG
  png(filename = "question_14.png", width = 600, height = 400)
  
  # Plot the data
  plot(generations, simulation_data, type = "o", col = "blue",
       xlab = "Generations", ylab = "Species Richness",
       main = "Species Richness Over Time",
       ylim = c(0, 100), yaxt = "n")
  y_ticks <- sort(unique(c(seq(0, 100, by = 10), final_value))) #Adds a tick on the Y axis to signify last recorded species richness value
  axis(2, at = y_ticks, labels = as.character(y_ticks)) 
  
  dev.off()  # Close the graphics device
  
  # Return the required answer for Question 14
  return("Over time, the system will converge to a single species (monodominance) due to the absence of speciation. 
  This occurs because, in a neutral model without speciation, random extinction events eventually eliminate all but one species.")
}


# Question 15: Neutral Step with Speciation
# Example usage:
# If community = c(1,1,2), neutral_step_speciation(c(1,1,2), 0.2) 
# behaves like neutral_step 80% of the time, and introduces a new species 20% of the time.

neutral_step_speciation <- function(community, speciation_rate) {
  indices <- choose_two(length(community))
  
  if (runif(1) < speciation_rate) { #runif generates continous value between 0 and 1
    # Generate a unique species ID
    existing_species <- unique(community)
    new_species <- max(existing_species) + 1  # Ensures uniqueness
    community[indices[1]] <- new_species
  } else {
    community[indices[1]] <- community[indices[2]]
  }
  
  return(community)
}


# Question 16: Neutral Generation with Speciation
# Example usage:
# neutral_generation_speciation(c(1,1,2,2,3,3), 0.1)

neutral_generation_speciation <- function(community, speciation_rate) {
  
  # If there's only one individual, nothing changes
  if (length(community) == 1) {
    return(community)
  }
  
  # Determine the number of neutral steps for one generation
  num_steps <- sample(c(floor(length(community) / 2), ceiling(length(community) / 2)), 1)
  
  # Perform the determined number of neutral steps
  for (i in 1:num_steps) {
    community <- neutral_step_speciation(community, speciation_rate)
  }
  
  return(community)
}

# Question 17: Time Series of Species Richness with Speciation
# Example usage:
# neutral_time_series_speciation(c(1,2,3,4,5), 0.1, 10)

neutral_time_series_speciation <- function(community, speciation_rate, duration) {
  # Initialize species richness list
  richness_vector <- numeric(duration + 1)
  richness_vector[1] <- species_richness(community)  # Store initial richness
  
  # Simulate over generations
  for (gen in 2:(duration + 1)) {  
    community <- neutral_generation_speciation(community, speciation_rate)  
    richness_vector[gen] <- species_richness(community)  
  }
  
  return(richness_vector)  
}

# Question 18: Species Richness Over Time with Speciation
# Example usage:
# question_18() saves "results/question_18.png" and returns a written explanation.

question_18 <- function()  {
  
  # Initialize community with maximal diversity (100 individuals that are 100 different species)
  communityfortimeseriesmax <- init_community_max(100) 
  
  # Initialize community with minimal diversity (100 individuals that are of 1 species)
  communityfortimeseriesmin <- init_community_min(100) 
  
  # Run simulation for 200 generations
  simulation_data1 <- neutral_time_series_speciation(communityfortimeseriesmax, 0.1, 200)
  simulation_data2 <- neutral_time_series_speciation(communityfortimeseriesmin, 0.1, 200)
  
  # Generate sequence for x-axis (generations)
  generations <- seq_along(simulation_data1)
  
  # Save plot as PNG
  png(filename = "question_18.png", width = 600, height = 400)
  
  plot(generations, simulation_data1, type = "o", col = "blue", 
       xlab = "Generations", ylab = "Species Richness", 
       main = "Species Richness Over Time in Speciation Model",  
       ylim = c(0, 100)) 
  
  lines(generations, simulation_data2, type = "o", col = "red")
  
  # Add a legend
  legend("topright", legend = c("Max community richness", "Min community richness"), 
         col = c("blue", "red"), lty = 1, pch = 1)
  
  dev.off()  # Close the graphics device
  
  return("Both initial conditions converge toward a similar species richness over time due to speciation balancing diversity loss from extinction. 
  The initially diverse community loses species quickly, while the monodominant community gains diversity gradually. 
  This confirms that long-term species richness is determined more by speciation rate than initial diversity.")
}



# Question 19: Species Abundance Distribution
# Example usage:
# species_abundance(c(1,1,2,2,2,3,3,3,3,4))
# Expected output: A table with species sorted by abundance (most to least)

species_abundance <- function(community)  {
  # Count the number of times each species appears in the community
  species_counts <- table(community)
  
  # Sort species from most to least abundant
  abundance_ordered <- sort(species_counts, decreasing = TRUE)
  
  # Return the sorted species abundance table
  return(abundance_ordered)
}


# Question 20: Convert species abundance into octave bins
# Example usage:
# octaves(c(1, 2, 3, 4, 5, 8, 9, 12, 15, 20))
# Expected output: A vector representing how many species fall into each octave bin.

octaves <- function(species_abundance_vector) {
  if (length(species_abundance_vector) == 0) {
    return(integer(0))  # Return empty integer vector if there are no species
  }
  
  # Compute octave bins using powers of 2
  octave_bins <- floor(log2(species_abundance_vector)) + 1  
  octave_distribution <- tabulate(octave_bins)  # Counts occurrences in each bin
  
  return(octave_distribution)
}


# Question 21: Summing Two Vectors After Padding with Zeros
# Example usage:
# sum_vect(c(1,3), c(1,0,5,2)) 
# Expected output: c(2,3,5,2)

sum_vect <- function(x, y) {
  # Pad the shorter vector with zeros to match the longer vector's length
  len_x <- length(x)
  len_y <- length(y)
  
  if (len_x > len_y) {
    y <- c(y, rep(0, len_x - len_y))  # Pad y with zeros
  } else if (len_y > len_x) {
    x <- c(x, rep(0, len_y - len_x))  # Pad x with zeros
  }
  
  # Return sum of both vectors
  return(x + y)
}


# Question 22: Mean Species Abundance Distribution After Burn-in
# Runs two neutral model simulations, records species abundance octaves, and saves bar plots.  
question_22 <- function() {
  # -----------------------------
  # 1. SIMULATION SETUP
  # -----------------------------
  
  burn_in_steps <- 200  # Number of generations for system stabilization
  total_sim_steps <- 2200  # Total simulation steps including burn-in
  sampling_frequency <- 20  # Interval for recording species abundance
  mutation_probability <- 0.1  # Probability of speciation event per step
  
  # Initialize two different community structures
  diverse_community <- init_community_max(100)  # Community with unique species per individual
  monodominant_community <- init_community_min(100)  # Community with a single dominant species
  
  # -----------------------------
  # 2. BURN-IN PHASE (Equilibrate the system before recording data)
  # -----------------------------
  for (gen in 1:burn_in_steps) {
    diverse_community <- neutral_generation_speciation(diverse_community, mutation_probability)
    monodominant_community <- neutral_generation_speciation(monodominant_community, mutation_probability)
    
    # Print diagnostic info for debugging population trends during burn-in
    cat("Burn-in step:", gen, "Species richness diverse:", species_richness(diverse_community), 
        "Species richness monodominant:", species_richness(monodominant_community), "\n")
  }
  
  # -----------------------------
  # 3. SPECIES ABUNDANCE TRACKING
  # -----------------------------
  
  # Initialize empty vectors to accumulate species abundance distributions
  abundance_diverse <- integer(0)
  abundance_monodominant <- integer(0)
  
  # Main simulation loop for tracking species richness and distribution
  for (gen in 1:(total_sim_steps - burn_in_steps)) {
    diverse_community <- neutral_generation_speciation(diverse_community, mutation_probability)
    monodominant_community <- neutral_generation_speciation(monodominant_community, mutation_probability)
    
    # Record species abundance at defined intervals
    if (gen %% sampling_frequency == 0) {
      abundance_diverse <- sum_vect(abundance_diverse, octaves(species_abundance(diverse_community)))
      abundance_monodominant <- sum_vect(abundance_monodominant, octaves(species_abundance(monodominant_community)))
    }
  }
  
  # -----------------------------
  # 4. COMPUTE AVERAGE SPECIES ABUNDANCE DISTRIBUTIONS
  # -----------------------------
  
  mean_abundance_diverse <- abundance_diverse / ((total_sim_steps - burn_in_steps) / sampling_frequency)
  mean_abundance_monodominant <- abundance_monodominant / ((total_sim_steps - burn_in_steps) / sampling_frequency)
  
  # -----------------------------
  # 5. PLOTTING SPECIES ABUNDANCE DISTRIBUTIONS
  # -----------------------------
  
  # Generate category labels for abundance bins (octaves)
  x <- seq(1,length(mean_abundance_diverse))
  low <- 2^(x-1)
  up <- 2^x -1
  val <- paste0(low,"-", up)
  val[1] <- "1"  # Label the first bin correctly
  
  # -----------------------------
  # 5. PLOTTING SPECIES ABUNDANCE DISTRIBUTIONS (Side-by-Side)
  # -----------------------------
  
  # Save the combined figure as one PNG
  png("question_22.png", width = 1200, height = 600)
  
  # Set up plotting area for two side-by-side plots
  par(mfrow=c(1,2))
  
  # Generate category labels for abundance bins (octaves)
  x <- seq(1,length(mean_abundance_diverse))
  low <- 2^(x-1)
  up <- 2^x -1
  val <- paste0(low,"-", up)
  val[1] <- "1"  # Label the first bin correctly
  
  # First Plot: Diverse Initial Condition
  barplot(mean_abundance_diverse,
          names.arg = val,
          col = "red",
          main = "Diverse Species Initial Abundance",
          xlab = "Abundance (log2 scale)",
          ylab = "Mean Number of Species",
          ylim = c(0, max(c(mean_abundance_diverse, mean_abundance_monodominant)) + 1))
  
  # Second Plot: Monodominant Initial Condition
  barplot(mean_abundance_monodominant,
          names.arg = val,
          col = "lightblue",
          main = "Monodominant Species Initial Abundance",
          xlab = "Abundance (log2 scale)",
          ylab = "Mean Number of Species",
          ylim = c(0, max(c(mean_abundance_diverse, mean_abundance_monodominant)) + 1))
  
  # Close the PNG device
  dev.off()
  
  # -----------------------------
  # 6. RETURN FUNCTION SUMMARY
  # -----------------------------
  return("After the burn-in period, both initial conditions converge to a similar species abundance distribution. 
The stochastic model reaches a dynamic equilibrium where species richness fluctuates around a stable mean, 
suggesting that speciation and random extinction balance out over time.")
}

# Question 23: 
neutral_cluster_run <- function(
    speciation_rate, 
    size, 
    wall_time,           # in minutes
    interval_rich, 
    interval_oct, 
    burn_in_generations, 
    output_file_name
) {
  # Start timer
  start_time <- proc.time()[3]  
  
  # Initialize community at minimal diversity
  community <- init_community_min(size)
  
  # Storage for species richness and abundance
  time_series <- numeric(0)  
  abundance_list <- list()  
  
  # Main loop: runs until wall time is exceeded
  generation <- 0
  repeat {
    elapsed <- proc.time()[3] - start_time  # Time elapsed so far
    if (elapsed > wall_time * 60) break  # Stop if time limit exceeded
    
    # Advance one generation
    generation <- generation + 1
    community <- neutral_generation_speciation(community, speciation_rate)
    
    # Record species richness every `interval_rich` generations
    if (generation <= burn_in_generations && generation %% interval_rich == 0) {
      time_series <- c(time_series, species_richness(community))
    }
    
    # Record species abundance every `interval_oct` generations
    if (generation %% interval_oct == 0) {
      abundance_list[[length(abundance_list) + 1]] <- octaves(species_abundance(community))
    }
  }
  
  # Compute total runtime
  total_time <- proc.time()[3] - start_time  
  
  # Additional metadata
  sp_rate         <- speciation_rate   # Store speciation rate
  sz              <- size              # Store community size
  w_time          <- wall_time         # Store wall time limit
  i_rich          <- interval_rich     # Store species richness recording interval
  i_oct           <- interval_oct      # Store species abundance recording interval
  burn_in_gens    <- burn_in_generations  # Store burn-in period duration
  
  # Save additional metadata along with main results**
  save(
    time_series, 
    abundance_list, 
    community, 
    total_time,
    sp_rate,   
    sz,        
    w_time,    
    i_rich,    
    i_oct,    
    burn_in_gens,  # 
    file = output_file_name
  )
  
  return(invisible(NULL))  # Keep function output clean
}

# Questions 24 and 25 involve writing code elsewhere to run your simulations on
# the cluster

# Question 26:
#Reads in cluster-run RDA files, and calculates a mean value across all of the saved(post burn in data) for each abundance vector and community size
#averages across time and all 25 simulations per community size
#saves data in rda file as a list of 4 vectors corresponding to mean octave output

process_neutral_cluster_results <- function() {
  # Step 1: Retrieve the List of `.rda` Files
  neutral_data_files <- dir(
    path = "neutral_cluster_data",             # Directory containing data
    pattern = "\\.rda$",             # Match only `.rda` files
    full.names = TRUE                # Get complete file paths
  )
  
  # Stop execution if no files are found
  if (length(neutral_data_files) == 0) {
    stop("No simulation data found in 'neutral_cluster_data'. Please check the directory.")
  }
  
  # Step 2: Set Up Storage for Processed Data
  community_sizes <- c(500, 1000, 2500, 5000)  # Known population sizes
  
  cumulative_means <- vector("list", length(community_sizes))  # create list to hold summed vectors
  counts <- integer(length(community_sizes))  # Keep track of file count per size
  
  names(cumulative_means) <- as.character(community_sizes)  # Assign list names so we can refer to them easily
  names(counts) <- as.character(community_sizes)
  
  # Step 3: Process `.rda` Files
  index <- 1  # to iterate using a while loop manually
  
  while (index <= length(neutral_data_files)) {
    file_name <- neutral_data_files[index]
    index <- index + 1  # Move to next file in list
    
    # Try to load the file, skip on error
    loaded_successfully <- tryCatch({
      load(file_name)  # Expects `abundance_list` and `sz` inside file
      TRUE
    }, error = function(e) {
      message(paste("Skipping", file_name, "due to an error:", e$message))
      FALSE
    })
    
    if (!loaded_successfully) next  # Move to next file if there was an issue
    
    # Ensure `sz` (community size) exists
    if (!exists("sz") || !sz %in% community_sizes) {
      message(paste("Skipping", file_name, "— missing or invalid `sz`."))
      next
    }
    
    # Ensure `abundance_list` exists and is not empty
    if (!exists("abundance_list") || length(abundance_list) == 0) {
      message(paste("Skipping", file_name, "— `abundance_list` is empty or missing."))
      next
    }
    
    # Step 3a: Compute Mean Abundance Per File
    sum_abundance <- Reduce(sum_vect, abundance_list, init = numeric(0))  # Sum all octaves
    total_entries <- length(abundance_list)  # Count number of entries
    
    if (total_entries == 0) next  # Skip if no valid octaves
    
    mean_abundance <- sum_abundance / total_entries  # Compute mean vector
    community_label <- as.character(sz)  # Convert size to string for indexing
    
    # Step 3b: Aggregate Means for Each Community Size
    if (length(cumulative_means[[community_label]]) == 0) {
      cumulative_means[[community_label]] <- mean_abundance  # First assignment
    } else {
      cumulative_means[[community_label]] <- sum_vect(cumulative_means[[community_label]], mean_abundance)
    }
    
    counts[[community_label]] <- counts[[community_label]] + 1
  }
  
  # Step 4: Compute Final Averages
  final_averages <- lapply(names(cumulative_means), function(size_label) {
    if (counts[[size_label]] > 0) {
      return(cumulative_means[[size_label]] / counts[[size_label]])  # Compute average
    }
    return(numeric(0))  # Return empty vector if no data available
  })
  
  # Convert list format to match expected output order
  processed_results <- setNames(final_averages, community_sizes)
  
  # Step 5: Save Results
  save(processed_results, file = "processed_cluster_results.rda")
  message("Processing complete! Results saved as 'processed_cluster_results.rda'.")
  
  return(processed_results)
}

# Saves 4 bar graphs in multi-panel plot, plotting: 
# mean species abundance octave result from all simulation runs of that size and the list of data it plotted.
# Bargraph is then saved as: plot_neutral_cluster_results.png

plot_neutral_cluster_results <- function() {
  # Load processed results
  load("processed_cluster_results.rda")  
  
  if (!exists("processed_results")) {
    stop("Processed results file did not contain expected data. Ensure processing was successful.")
  }
  
  # Define population sizes
  community_sizes <- c(500, 1000, 2500, 5000)  
  
  # Create PNG output
  png(filename = "plot_neutral_cluster_results.png", width = 800, height = 800)
  
  # Arrange plots in a 2x2 grid
  par(mfrow = c(2,2), mar = c(6, 4, 4, 2))  # Increase bottom margin to fit diagonal labels
  
  for (pop_size in community_sizes) {
    species_distribution <- processed_results[[as.character(pop_size)]]
    
    if (is.null(species_distribution) || length(species_distribution) == 0) {
      barplot(0, 
              main = paste("Size =", pop_size, "\nNo Data Available"), 
              xlab = "Octave Bin", 
              ylab = "Species Count")
    } else {
      # Compute octave labels (ranges of species abundance)
      num_bins <- length(species_distribution)
      octave_labels <- sapply(1:num_bins, function(bin) {
        lower <- 2^(bin - 1)  
        upper <- (2^bin) - 1  
        if (lower == upper) return(as.character(lower))  
        return(paste0(lower, "-", upper))
      })
      
      # Plot bar chart without x-axis labels
      bars <- barplot(species_distribution, 
                      main = paste("Neutral Model mean species abundance (Community Size =", pop_size, ")"),
                      xlab = "Octave Bin (Log 2 Ranges)",
                      ylab = "Mean Species abundance",
                      col = "lightgreen",
                      axes = TRUE,  # Keep axes visible
                      names.arg = NA,
                      cex.main = 0.7)  # Remove automatic labels
      
      # Manually add diagonal labels
      text(x = bars, y = par("usr")[3] - 0.2,  # Position labels slightly below x-axis
           labels = octave_labels, 
           srt = 45,  # Rotate text diagonally (45°)
           adj = 1,  # Right-align labels
           xpd = TRUE,  # Allow text to be outside plot area
           cex = 0.8)  # Reduce label size
    }
  }
  
  # Close PNG output
  dev.off()
  
  return("Bar plots successfully generated and saved as 'plot_neutral_cluster_results.png'.")
}


# Challenge questions - these are substantially harder and worth fewer marks.
# I suggest you only attempt these if you've done all the main questions. 

# Challenge_A Function
# ----------------------
# Processes cluster simulation data to create `population_size_df`, 
# a long-form data frame of population size time series for all runs.
# Generates a ggplot2 graph of population size vs. time step, color-coded by initial condition.
# Saves the plot as "Challenge_A.png".

# Run the function with:
# Challenge_A()

Challenge_A <- function() {
  # -----------------------------
  # 1) FIND .RDA FILES
  # -----------------------------
  
  rda_files <- list.files(
    path = "Demographic_output_data",  
    pattern = ".*[0-9]+\\.rda$",     
    full.names = TRUE,
    recursive = TRUE  
  )
  
  if (length(rda_files) == 0) {
    stop("No .rda files found in the directory.")
  }
  
  # -----------------------------
  # 2) DEFINE FUNCTION TO PROCESS .RDA FILES
  # -----------------------------
  
  process_rda_file <- function(file_path) {
    file_name <- basename(file_path)
    iter_str  <- sub("output_(\\d+)\\.rda", "\\1", file_name)
    job_idx   <- as.numeric(iter_str)
    
    cond_map <- c("large adult", "small adult", "large mixed", "small mixed")
    initial_condition <- cond_map[((job_idx - 1) %% 4) + 1]  
    
    loaded_successfully <- tryCatch({
      load(file_path)
      exists("simulation_results")
    }, error = function(e) {
      FALSE
    })
    
    if (!loaded_successfully) return(NULL)
    
    sim_data <- lapply(seq_along(simulation_results), function(sim_idx) {
      time_series <- simulation_results[[sim_idx]]
      if (is.null(time_series) || length(time_series) == 0) return(NULL)
      
      data.frame(
        simulation_number = paste0(job_idx, "-", sim_idx),  
        initial_condition = initial_condition, 
        time_step = 0:(length(time_series) - 1),  
        population_size = time_series,
        stringsAsFactors = FALSE  
      )
    })
    
    return(do.call(rbind, Filter(Negate(is.null), sim_data)))  
  }
  
  # -----------------------------
  # 3) PARALLEL PROCESSING USING MCLAPPLY
  # -----------------------------
  
  library(parallel)  
  num_cores <- detectCores() - 1  
  
  population_data_list <- mclapply(rda_files, process_rda_file, mc.cores = num_cores)
  
  population_size_df <- do.call(rbind, Filter(Negate(is.null), population_data_list))
  
  # -----------------------------
  # 4) SAVE AND PLOT RESULTS
  # -----------------------------
  
  save(population_size_df, file = "Challenge_A_population_data.rda")
  
  if (nrow(population_size_df) == 0) {
    stop("Error: No data available for plotting.")
  }
  
  library(ggplot2)
  
  # Define custom colors for each condition
  condition_colors <- c(
    "large adult" = "red", 
    "small adult" = "blue", 
    "large mixed" = "green", 
    "small mixed" = "purple"
  )
  
  plot <- ggplot(population_size_df, aes(
    x = time_step,  
    y = population_size,  
    group = simulation_number,  
    colour = initial_condition  
  )) +
    geom_line(alpha = 0.1) +  
    labs(
      title = "Population Size Trajectories Over Time",
      x = "Time Step", 
      y = "Population Size",
      colour = "Initial Condition"
    ) +
    scale_colour_manual(values = condition_colors) +  # Explicitly assign colors to legend
    theme_classic() +  
    theme(
      panel.background = element_rect(fill = "white", color = NA),  
      plot.background = element_rect(fill = "white", color = NA),   
      legend.background = element_rect(fill = "white", color = NA), 
      legend.key = element_rect(fill = "white", color = "black"),   
      legend.title = element_text(size = 14, face = "bold"),        
      legend.text = element_text(size = 12),
      legend.key.width = unit(2,"cm")
    ) +
    guides(colour = guide_legend(override.aes = list(size = 5, alpha = 1)))  
  
  ggsave(filename = "Challenge_A.png", plot = plot, device = "png", width = 12, height = 8, units = "in", bg = "white")
  
  return("Challenge A completed: Population trajectories saved and plotted.")
}


# Challenge question B:
#  Runs with Challenge_B()
# - Plots mean species richness over time across multiple simulations.
# - Adds a 97.2% confidence interval to the plot.
# - Compares two initial conditions (minimum and maximum species richness).
# - Saves the plot as "Challenge_B.png" and outputs the equilibrium estimate.

Challenge_B <- function() {
  # -----------------------------------------------------
  # 1. INITIAL SETUP: PARAMETERS & DATA STORAGE
  # -----------------------------------------------------
  
  num_simulations <- 50  # Number of independent runs
  speciation_prob <- 0.1  # Speciation rate per individual per generation
  community_size <- 100  # Total individuals in each community
  max_generations <- 400  # Total number of generations to simulate
  
  # Matrices to store species richness results for each simulation
  richness_min <- matrix(NA, nrow = num_simulations, ncol = max_generations + 1)
  richness_max <- matrix(NA, nrow = num_simulations, ncol = max_generations + 1)
  
  # Compute the Z-score for the 97.2% confidence interval
  conf_z <- qnorm(0.986)  # Two-tailed CI for 97.2%
  
  # -----------------------------------------------------
  # 2. RUNNING THE SIMULATIONS
  # -----------------------------------------------------
  
  for (sim in 1:num_simulations) {  # Loop through each independent simulation
    # Initialize communities with different starting species diversities
    min_diversity <- init_community_min(community_size)  # All individuals are the same species
    max_diversity <- init_community_max(community_size)  # Every individual is a different species
    
    # Record species richness at the start (generation 0)
    richness_min[sim, 1] <- species_richness(min_diversity)
    richness_max[sim, 1] <- species_richness(max_diversity)
    
    # Iterate over all generations
    for (gen in 1:max_generations) {
      # Apply speciation and random drift to evolve the community
      min_diversity <- neutral_generation_speciation(min_diversity, speciation_prob)
      max_diversity <- neutral_generation_speciation(max_diversity, speciation_prob)
      
      # Log species richness after evolution
      richness_min[sim, gen + 1] <- species_richness(min_diversity)
      richness_max[sim, gen + 1] <- species_richness(max_diversity)
    }
  }
  
  # -----------------------------------------------------
  # 3. ANALYSIS: COMPUTE MEAN & CONFIDENCE INTERVALS
  # -----------------------------------------------------
  
  # Calculate mean species richness across simulations for each time step
  avg_richness_min <- colMeans(richness_min, na.rm = TRUE)
  avg_richness_max <- colMeans(richness_max, na.rm = TRUE)
  
  # Compute standard deviations across runs
  sd_richness_min <- apply(richness_min, 2, sd, na.rm = TRUE)
  sd_richness_max <- apply(richness_max, 2, sd, na.rm = TRUE)
  
  # Compute standard errors
  se_min <- sd_richness_min / sqrt(num_simulations)
  se_max <- sd_richness_max / sqrt(num_simulations)
  
  # Compute confidence intervals
  ci_min_upper <- avg_richness_min + conf_z * se_min
  ci_min_lower <- avg_richness_min - conf_z * se_min
  ci_max_upper <- avg_richness_max + conf_z * se_max
  ci_max_lower <- avg_richness_max - conf_z * se_max
  
  # -----------------------------------------------------
  # 4. PLOTTING THE RESULTS
  # -----------------------------------------------------
  
  # Save the plot as a PNG file
  png("Challenge_B.png", width = 800, height = 600)
  
  # Define the X-axis values (generations)
  time_series <- seq(0, max_generations)
  
  # Create the base plot
  plot(
    time_series, avg_richness_min,
    type = "l",
    col  = "blue",
    ylim = range(c(ci_min_lower, ci_min_upper, ci_max_lower, ci_max_upper)),
    xlab = "Generations",
    ylab = "Species Richness",
    main = "Species Richness Over Time"
  )
  
  # Confidence interval shading for minimum diversity condition
  polygon(
    x = c(time_series, rev(time_series)),
    y = c(ci_min_lower, rev(ci_min_upper)),
    col = adjustcolor("blue", alpha.f = 0.2),
    border = NA
  )
  lines(time_series, avg_richness_min, col = "blue", lwd = 2)
  
  # Confidence interval shading for maximum diversity condition
  polygon(
    x = c(time_series, rev(time_series)),
    y = c(ci_max_lower, rev(ci_max_upper)),
    col = adjustcolor("red", alpha.f = 0.2),
    border = NA
  )
  lines(time_series, avg_richness_max, col = "red", lwd = 2)
  
  # Add a legend to the plot
  legend(
    "topright",
    legend = c("Low Initial Diversity", "High Initial Diversity"),
    col    = c("blue", "red"),
    lwd    = 2
  )
  
  # Close the PNG device to save the image
  dev.off()
  
  # ---------------------------------------------
  # 5. RETURN SUMMARY
  # ---------------------------------------------
  
  # Generate a plain-text explanation of the equilibrium result
  explanation <- paste(
    "Based on the simulations, the system appears to reach dynamic equilibrium around 60-80 generations.",
    "Over time, species richness converges and stabilizes despite different initial conditions."
  )
  
  return(explanation)  # Return the result as a string
}


# Challenge question C
# Similair to Function Challenge_B but instead Averages time series simulation for a range of different initial community species richnesses
# runs with:  Challenge_C()

Challenge_C <- function() {
  # -----------------------------------------------------
  # 1. INITIAL SETUP: PARAMETERS & DATA STORAGE
  # -----------------------------------------------------
  
  library(parallel)  # Load parallel processing library for efficiency
  
  num_simulations <- 50  # Number of independent runs per initial richness level
  speciation_prob <- 0.1  # Probability of speciation per individual per generation
  community_size <- 100  # Fixed total number of individuals in each community
  max_generations <- 400  # Number of generations simulated
  
  # Range of species richness levels to investigate
  richness_levels <- c(10, 25, 50, 75, 100, 150)  
  
  # Storage for simulation results across different initial conditions
  results <- list()
  
  # Compute the Z-score for the 97.2% confidence interval
  conf_z <- qnorm(0.986)
  
  # Detect available CPU cores for parallel execution
  num_cores <- detectCores() - 1  
  
  # -----------------------------------------------------
  # 2. FUNCTION TO GENERATE COMMUNITIES WITH VARIOUS SPECIES RICHNESSES
  # -----------------------------------------------------
  
  generate_initial_community <- function(richness) {
    # Each individual is randomly assigned one of `richness` species
    initial_community <- sample(1:richness, size = community_size, replace = TRUE)
    return(initial_community)  
  }
  
  # -----------------------------------------------------
  # 3. RUNNING THE SIMULATIONS IN PARALLEL
  # -----------------------------------------------------
  
  simulate_richness <- function(richness) {
    # Runs `num_simulations` for a given `richness` level.
    # Stores and computes mean species richness and confidence intervals.
    
    richness_matrix <- matrix(NA, nrow = num_simulations, ncol = max_generations + 1)
    
    for (sim in 1:num_simulations) {
      # Generate an initial community with exactly `richness` unique species
      initial_community <- generate_initial_community(richness)
      
      # Record the actual starting richness for verification
      print(paste("Expected:", richness, "Actual:", species_richness(initial_community)))
      
      # Store initial species richness before any evolutionary changes
      richness_matrix[sim, 1] <- species_richness(initial_community)
      
      # Simulate the community over `max_generations`
      for (gen in 1:max_generations) {
        initial_community <- neutral_generation_speciation(initial_community, speciation_prob)
        richness_matrix[sim, gen + 1] <- species_richness(initial_community)
      }
    }
    
    # Compute mean richness across all simulations at each time step
    avg_richness <- colMeans(richness_matrix, na.rm = TRUE)
    
    # Compute standard deviation and standard error
    sd_richness <- apply(richness_matrix, 2, sd, na.rm = TRUE)
    se_richness <- sd_richness / sqrt(num_simulations)
    
    # Compute confidence interval bounds
    ci_upper <- avg_richness + conf_z * se_richness
    ci_lower <- avg_richness - conf_z * se_richness
    
    return(list(avg = avg_richness, ci_upper = ci_upper, ci_lower = ci_lower))
  }
  
  # Run simulations in parallel for efficiency
  results <- mclapply(richness_levels, simulate_richness, mc.cores = num_cores)
  names(results) <- as.character(richness_levels)
  
  # -----------------------------------------------------
  # 4. PLOTTING THE RESULTS
  # -----------------------------------------------------
  
  png("Challenge_C.png", width = 800, height = 600)
  
  # Define the time axis (x-axis)
  time_series <- seq(0, max_generations)
  
  # Assign distinct colors to each initial richness level
  colors <- c("blue", "red", "green", "purple", "orange", "darkgrey")
  
  # Fix y-axis between 0 and 100 for clarity
  y_min <- 0  
  y_max <- 80  
  
  # Create an empty plot with proper scaling
  plot(
    NULL, NULL, 
    xlim = range(time_series), 
    ylim = c(y_min, y_max),  
    xlab = "Generations", 
    ylab = "Species Richness",
    main = "Species Richness Over Time for Different Initial Conditions"
  )
  
  # Overlay each richness level onto the plot
  for (i in seq_along(richness_levels)) {
    richness <- as.character(richness_levels[i])
    
    # Plot the mean species richness trajectory
    lines(time_series, results[[richness]]$avg, col = colors[i], lwd = 2)
    
    # Add semi-transparent confidence interval shading
    polygon(
      x = c(time_series, rev(time_series)),
      y = c(results[[richness]]$ci_lower, rev(results[[richness]]$ci_upper)),
      col = adjustcolor(colors[i], alpha.f = 0.1),  # High transparency to keep individual lines visible
      border = NA
    )
  }
  
  # Add a legend indicating each initial richness level
  legend(
    "topright",
    legend = paste("Initial Richness:", richness_levels),
    col = colors,
    lwd = 2
  )
  
  # Save the plot
  dev.off()
  
  return("Regardless of initial species richness of communities, dynamic equillibrium of species richness is reached after enough successive generations.")
}


# Challenge question D
# ----------------------
# Reads and processes neutral cluster simulation data to compute mean species richness over generations.
# Plots mean species richness vs. simulation generation for different community sizes.
# Helps determine the required burn-in period.
# Saves the plot as "Challenge_D.png".

# Run the function with:
# Challenge_D()


Challenge_D <- function() {
  # Step 1: Identify and Load Simulation Files
  file_paths <- list.files("neutral_cluster_data", pattern = "\\.rda$", full.names = TRUE)
  
  if (length(file_paths) == 0) {
    stop("No .rda files found in 'neutral_cluster_data'. Check if the directory exists and has files.")
  }
  
  # Step 2: Define community sizes we expect
  community_sizes <- c(500, 1000, 2500, 5000)
  
  # Create a list to store species richness time series for each community size
  richness_data <- list()
  for (size in community_sizes) {
    richness_data[[as.character(size)]] <- list()
  }
  
  # Step 3: Loop over all files and extract species richness over time
  for (file_path in file_paths) {
    load(file_path)  # Loads variables like 'time_series' and 'sz'
    
    # Ensure valid file contents
    if (!exists("time_series") || !exists("sz") || !(sz %in% community_sizes)) {
      next  # Skip files that don't have expected variables
    }
    
    # Store the species richness time series into the corresponding size category
    richness_data[[as.character(sz)]][[length(richness_data[[as.character(sz)]]) + 1]] <- time_series
  }
  
  # Step 4: Compute mean species richness per generation for each community size
  mean_richness <- list()
  
  for (size in community_sizes) {
    size_label <- as.character(size)
    runs <- richness_data[[size_label]]
    
    if (length(runs) == 0) {
      mean_richness[[size_label]] <- numeric(0)  # No data for this size
      next
    }
    
    # Determine the maximum length of any time series (not all runs may have the same length)
    max_gen <- max(sapply(runs, length))
    
    # Create a matrix where each row is a run and each column is a generation
    richness_matrix <- matrix(NA, nrow = length(runs), ncol = max_gen)
    
    for (i in seq_along(runs)) {
      run_length <- length(runs[[i]])
      richness_matrix[i, 1:run_length] <- runs[[i]]
    }
    
    # Compute the mean across all runs for each generation
    mean_richness[[size_label]] <- colMeans(richness_matrix, na.rm = TRUE)
  }
  
  # Step 5: Plot the mean species richness over generations
  png("Challenge_D.png", width = 800, height = 600)
  
  # Setup empty plot with appropriate axis limits
  plot(0, 0, type = "n", xlab = "Generation", ylab = "Mean Species Richness",
       xlim = c(0, min(3000, max(sapply(mean_richness, length)))),
       ylim = range(unlist(mean_richness), na.rm = TRUE),
       main = "Mean Species Richness Over Time for different Community Sizes")
  
  # Define colors for different community sizes
  colors <- c("coral", "darkblue", "darkseagreen", "deeppink2")
  
  # Plot lines for each community size
  for (i in seq_along(community_sizes)) {
    size_label <- as.character(community_sizes[i])
    if (length(mean_richness[[size_label]]) > 0) {
      lines(0:(length(mean_richness[[size_label]]) - 1), mean_richness[[size_label]],
            col = colors[i], lwd = 2)
    }
  }
  
  # Add a legend
  legend("topleft", legend = paste("community size =", community_sizes),
         col = colors, lwd = 2, cex = 0.75)
  
  dev.off()
  
  return("Challenge_D.png successfully created. Examine the graph to determine the burn-in period.")
}


#Challenge question E (Could not complete)
#Defines a function that calculates community coalescence and then defines another which compares simulating CPU time to reach coalescence to time required to fully simulate neutral cluster runs on the HPC 

Coalescence <- function(community_size, speciation_rate) {
  # Step 1: Initialize variables
  lineages <- rep(1, community_size)  # Each individual starts as its own species
  abundances <- c()  # Empty vector to store species abundances
  N <- community_size  # Number of active lineages
  theta <- (speciation_rate * (community_size - 1)) / (1 - speciation_rate)  # Compute θ
  
  # Step 2: Coalescence process (until only one lineage remains)
  while (N > 1) {
    j <- sample(seq_along(lineages), 1)  # Select a random lineage index
    
    randnum <- runif(1)  # Generate a random number between 0 and 1
    
    if (randnum < (theta / (theta + N - 1))) {
      # Speciation event: Store this lineage in abundances
      abundances <- c(abundances, lineages[j])
    } else {
      # Coalescence event: Merge this lineage with another randomly chosen lineage
      i <- sample(seq_along(lineages)[-j], 1)  # Select another random index i ≠ j
      lineages[i] <- lineages[i] + lineages[j]  # Merge lineages i and j
    }
    
    lineages <- lineages[-j]  # Remove merged/speciated lineage
    N <- N - 1  # Reduce lineage count
  }
  
  # Step 3: Store final lineage in abundances
  abundances <- c(abundances, lineages)  # Add last remaining lineage to abundances
  
  return(abundances)  # Return species abundances
}


why_coalescence_faster <- function() {
# Define parameters
community_size <- 1000
speciation_rate <- 0.005402

# Measure runtime for coalescence
start_time_coal <- proc.time()[3]
coalescence_abundances <- Coalescence(community_size, speciation_rate)
coalescence_runtime <- proc.time()[3] - start_time_coal

# Save results for comparison
save(coalescence_abundances, coalescence_runtime, file = "coalescence_results.rda")

# Load previous HPC-based simulation results
load("neutral_cluster_data/neutral_run1.rda")  # Ensure correct file name

# Compute species richness
richness_coalescence <- length(coalescence_abundances)
richness_HPC <- length(unique(community))  # Unique species in HPC model

# Compare CPU usage
cpu_hours_coalescence <- coalescence_runtime / 3600
cpu_hours_HPC <- total_time / 3600

# Print results
cat("=== Performance Comparison ===\n")
cat("Coalescence Runtime (seconds):", coalescence_runtime, "\n", "vs", "HPC Runtime (seconds):", total_time, "\n")
cat("Coalescence CPU Hours:", cpu_hours_coalescence, "vs ", "\n", "HPC CPU Hours:", cpu_hours_HPC, "\n")
cat("\n=== Species Richness Comparison ===\n")
cat("Coalescence Richness:", richness_coalescence, "\n", "vs ", "HPC Richness:", richness_HPC, "\n")

# Explain why coalescence is faster
cat("\n=== Why is Coalescence Faster? ===\n")
cat("1. Coalescence tracks only the final species distribution, skipping individual generations.\n", "2. The HPC simulation models every generation explicitly, which is computationally expensive and time consuming.\n", "3. Coalescence reduces unnecessary steps, making it signficantly faster.\n")
}

