# High-Performance Computing for Ecological Neutral Theory Simulations

## Overview
This submission is part of the hand in for the high-performance computing (HPC) module to run large-scale stochastic simulations of species abundance, richness, and population dynamics. The project consists of deterministic, stochastic, and coalescence-based models, analyzing their computational efficiency and ecological implications.

The simulations are executed on the imperial HPC cluster, with results stored and analyzed using R.

Packages Utilised are: GGPLOT2 for certain plots and parrallel for local parallelisation in some of the challenge questions

## Project Structure
The project consists of several R scripts that define and execute simulations, process results, and generate visualizations. These scripts are correctly formatted and stored as per the project guidelines.

- `2024-11-16 HPC worksheet.pdf`: PDF in this directory outlining the assignment brief and objectives of the functions in this Directory, provides more details not listed below.


### Key Files
- `sed24_HPC_2024_main.R`: Main script containing all core functions for demographic and neutral theory simulations.
- `sed24_HPC_2024_main_test.R`: A test version of the main script with placeholders for certain computations.
- `Demographic.R`: Contains supporting functions for stochastic demographic models.
- `neutral_cluster_data/`: Directory storing .rda files from HPC neutral theory simulations.
- `Demographic_output_data/`: Directory storing .rda files from HPC demographic simulations.
- `sed24_HPC_2024_demographic_cluster.R`: Script that runs stochastic demographic simulations on HPC.
- `sed24_HPC_2024_neutral_cluster.R`: Runs individual-based neutral theory simulations on HPC.
- `neutral_cluster_run_script.sh`: Shell script to submit neutral cluster simulations to the HPC cluster.
- `demographic_cluster_run_script.sh`: Shell script to submit demographic simulations to the HPC cluster.
- `*.rda` files: Stores simulation results for further analysis.
- `*.png` files: Saved plots from analysis scripts generated from sed24_HPC_2024_main.R file.

## Core Functions

### Stochastic Demographic Population Modelling
- `state_initialise_adult(num_stages, initial_size)`: Initializes adult population state vector.
- `state_initialise_spread(num_stages, initial_size)`: Initializes spread population state vector.
- `deterministic_simulation(population, projection_matrix, simul_length)`: Runs deterministic population projections using a growth and reproduction matrix.
- `stochastic_simulation(population, growth_matrix, reproduction_matrix, clutch_distribution, simul_length)`: Runs stochastic population simulations with variability in recruitment and survival.

### Extinction Probability & Stochastic vs Deterministic Comparison
- `question_5()`: Loads HPC .rda files and calculates extinction probability across different initial conditions.
- `question_6()`: Computes mean stochastic population trends, compares them to deterministic expectations, and saves deviation plots.

### Functions For Individual-Based Neutral Theory Simulation
- `species_richness(community)`: Returns the number of unique species in a community.
- `init_community_max(size)`: Initializes a community where each individual is a unique species.
- `init_community_min(size)`: Initializes a community where all individuals belong to the same species.
- `choose_two(max_value)`: Selects two distinct individuals at random.
- `neutral_step(community)`: Simulates one neutral model step by randomly replacing an individual.
- `neutral_generation(community)`: Evolves a community using multiple neutral steps.
- `neutral_time_series(community, duration)`: Tracks species richness over time.
- `neutral_step_speciation(community, speciation_rate)`: Introduces a new species with probability `speciation_rate`, otherwise performs a neutral step.
- `neutral_generation_speciation(community, speciation_rate)`: Runs multiple neutral steps with speciation events.
- `neutral_time_series_speciation(community, speciation_rate, duration)`: Tracks species richness over time in a neutral model with speciation.
- `species_abundance(community)`: Returns the species abundance distribution sorted in decreasing order.
- `octaves(species_abundance_vector)`: Converts species abundance into octave bins (log-scaled categories).
- `sum_vect(x, y)`: Sums two vectors, padding shorter vectors with zeros.

### HPC Cluster Simulations
- `neutral_cluster_run(speciation_rate, size, wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name)`: Runs long-term neutral theory simulations on the HPC cluster.
- `process_neutral_cluster_results()`: Reads .rda files from the HPC cluster and computes mean abundance distributions.
- `plot_neutral_cluster_results()`: Generates species abundance bar plots from cluster results.

## Challenge Functions
- `Challenge_A()`: Processes HPC simulation data and plots population size over time.
- `Challenge_B()`: Computes and plots mean species richness over time, adding confidence intervals.
- `Challenge_C()`: Visualizes species richness across different initial conditions.
- `Challenge_D()`: Analyzes mean species richness per generation to determine the burn-in period.
- `Challenge_E(speciation_rate, community_size, hpc_results_file)`: Runs a coalescence simulation, compares it with HPC results, and measures computational efficiency.

Each function processes .rda files and produces visual outputs (e.g., `Challenge_A.png`).

## HPC Shell Scripts
- `neutral_cluster_run_script.sh`: Submits neutral cluster simulations to the HPC cluster. It loads necessary modules, copies files to the HPC temporary directory, executes `sed24_HPC_2024_neutral_cluster.R`, and moves the results to the appropriate directories.
- `demographic_cluster_run_script.sh`: Submits demographic simulations to the HPC cluster, ensuring the script runs efficiently on a scheduled HPC job.

## How to Run Simulations
1. Submit jobs to the HPC cluster using shell scripts:
   ```bash
   qsub neutral_cluster_run_script.sh
   qsub demographic_cluster_run_script.sh
   ```