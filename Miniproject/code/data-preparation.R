# Clear environment
rm(list = ls())


#Here I'll prepare the data to be worked with

#load neccesary packages
require(minpack.lm) # for NLLS model fitting
require(tidyverse) # for data management
require(ggplot2) # for plotting
require(ggpubr)


#read in data
data <- read.csv("../data/LogisticGrowthData.csv")

#Basic checks
head(data)


#group data by experiments and then create a group ID for each experiment
data <- data %>%
  mutate(
    unique_id = paste(Temp, Species, Medium, Rep, Citation, sep = "_"),
    group_id = cumsum(c(TRUE, unique_id[-1] != unique_id[-length(unique_id)]))
  )

#Remove negative popbio values (as weight can't be negative)
data <- data %>% filter(PopBio >= 0)

#Remove Nas in data
data = na.omit(data)

#Remove repeats in data
distinct(data)

#Remove time points that are less than 0 (required for logistic growth model)
data <- data %>%
  filter(Time > 0)

# Count occurrences of each group_id
group_counts <- data %>%
  group_by(group_id) %>%
  summarize(count = n())

# Get list of group_ids that have at least 6 entries
valid_groups <- group_counts %>%
  filter(count >= 6) %>%
  pull(group_id)

# Filter the original data to keep only rows with valid group_ids
data <- data %>%
  filter(group_id %in% valid_groups)

#log transform data: 
# Note: Unlike the Logistic model, the Gompertz model is in the log scale.
# It wasn't derived from a differential equation but was specifically designed
# to be fitted to log-transformed data.
data$LogN = log(data$PopBio) # Create a column of log-transformed population data


#Observe temperature values across the data 
max(data$Temp)
min(data$Temp)

# Get frequency count of all unique temperature values
temp_frequency <- table(data$Temp)

# Display the results
print(temp_frequency)

#######################################################
#Check if temperature values stay consistent per experiment (for usage after model-fitting in cross validation)
#######################################################

#group data by experiments and then create a group ID for each experiment
data <- data %>%
  mutate(
    unique_id = paste(Temp, Species, Medium, Rep, Citation, sep = "_"),
    group_id = cumsum(c(TRUE, unique_id[-1] != unique_id[-length(unique_id)]))
  )

#Function that checks for consistency of temperature per group ID in dataset
check_temperature_consistency <- function(data) {
  # Create an empty data frame to store results
  results <- data.frame(
    group_id = integer(),
    consistent_temperature = logical(),
    temperature_value = numeric(),
    stringsAsFactors = FALSE
  )
  
  # Loop through each unique group_id
  for (group in unique(data$group_id)) {
    # Extract data for this group
    group_data <- data[data$group_id == group, ]
    
    # Check if temperature is the same for all rows in this group
    temp_values <- unique(group_data$Temp)
    is_consistent <- length(temp_values) == 1
    
    # If consistent, record the temperature value; otherwise NA
    temp_value <- ifelse(is_consistent, temp_values[1], NA)
    
    # Add to results
    results <- rbind(results, 
                     data.frame(
                       group_id = group,
                       consistent_temperature = is_consistent,
                       temperature_value = temp_value
                     ))
  }
  
  # Return the results
  return(results)
}

# To use above function:
temperature_check <- check_temperature_consistency(data)
#prints df containing group ID, if temp stays consistent across experiment and temperature value if so
print(temperature_check)

# To find any groups with inconsistent temperatures:
inconsistent_groups <- temperature_check[!temperature_check$consistent_temperature, ]
if(nrow(inconsistent_groups) > 0) {
  print("Groups with inconsistent temperatures:")
  print(inconsistent_groups)
} else {
  print("All groups have consistent temperatures.")
}
#successfully prints all groups have consistent temperatures
max(data$Temp)
min(data$Temp)

# Get frequency count of all unique temperature values
temp_frequency <- table(data$Temp)

# Display the results
print(temp_frequency)

#Observing remaining study metrics
# print(unique(data$Time_units))
# print(unique(data$PopBio_units))
# print(unique(data$Species))
# print(unique(data$Medium))
# print(unique(data$Citation))
# print(unique(data$unique_id))


###########Split data by group ID for model-fitting ########################
group_list <- split(data, data$group_id)

#Manually visually inspect experimental groups with obvious collection errors which are unable to be captured by the steps above 

# Create output directory (if it doesn't exist yet)
# dir.create("./output/graphs", showWarnings = FALSE, recursive = TRUE)
#
# For (i in seq_along(group_list)) {
#   # increase width, height, and resolution so the plots aren't squished
#   png(filename = paste0("../output/graphs/group-", i, ".png"),
#     width = 1280,  # pixels
#     height = 800,  # pixels
#     res = 120)     # resolution (dots per inch)
#
#   par(mfrow = c(1, 2)) # two plots side by side
#
#   # 1st plot: PopBio vs. Time
#   plot(PopBio ~ Time, data = group_list[[i]],
#     main = paste("popbio-group", i))
#
#   # 2nd plot: log(PopBio) vs. Time
#   plot(log(PopBio) ~ Time, data = group_list[[i]],
#     main = paste("logpopbio-group", i))
#
#   dev.off()
# }


# After visually identifying problematic groups (by their index)
# List of indices to be removed
problematic_indices <- c(5, 14, 17, 20, 110, 180, 189, 190, 200, 204)

# Remove those elements from the list by negative indexing
group_list <- group_list[-problematic_indices]








