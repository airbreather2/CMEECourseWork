rm(list = ls())
graphics.off()
source("sed24_HPC_2024_main.R")

#read in job from job cluster

iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX")) # Find out the job number
#set seed as iter

#iter <- 4

set.seed(iter) # Set this as the random seed so that all runs have a unique seed


# Define input variables for community sizes
initial_community_states <- list(500, 1000, 2500, 5000) 


if (iter %% 4 == 0) {
  size <- initial_community_states[[1]]  # Store the first simulation condition
} else if (iter %% 4 == 1) {
  size <- initial_community_states[[2]]  # Store the second simulation condition
} else if (iter %% 4 == 2) {
  size <- initial_community_states[[3]]  # Store the third simulation condition
} else if (iter %% 4 == 3) {
  size <- initial_community_states[[4]]  # Store the fourth simulation condition
}

print(size)

#### 1. Parameters for the simulation
speciation_rate          <- 0.005402
burn_in_generations      <- 8*size
total_generations_after  <- 2000
sampling_interval        <- 20  # record every 20 generations
interval_oct             <- size/10
interval_rich            <- 1
wall_time                <- 690
output_filename <- paste0("neutral_run", iter, ".rda")


simulation_result <- neutral_cluster_run(speciation_rate, size, wall_time , interval_rich, interval_oct = size/10, burn_in_generations = 8*size, output_filename)

print("done!")