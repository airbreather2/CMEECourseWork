#In this script, comparison metrics will summarised and plots generated


#source the model fitting script for validation
source("model-fitting.R")

##################Necessary modules #####################

# Plot each group
library(gridExtra) #for plotting multiple grids
library(cowplot) #used in violin plot to arrange elements nicely 

#########################################################
# Add Model comparison metrics across temperature ranges
#########################################################

analyze_temperature_range <- function(all_models_df, temp_min, temp_max, range_name = NULL) {
  # Filter for models in the specified temperature range
  range_models <- all_models_df %>%
    filter(Temp >= temp_min & Temp < temp_max)
  
  # Skip analysis if no models in specified range
  if(nrow(range_models) == 0) {
    cat("No models found in temperature range", temp_min, "to", temp_max, "\n")
    return(NULL)
  }
  
  # Filter for converged models within temperature range
  model_comparison_filtered <- range_models %>% 
    filter(convergence == TRUE)
  
  # Identify models with lowest AICc per group
  best_models_AICc <- model_comparison_filtered %>%
    group_by(group_id) %>%
    slice_min(order_by = AICc, n = 1) %>%
    ungroup()
  
  # Identify best models by adjusted R-squared for each group
  best_models_adj_R <- model_comparison_filtered %>%
    group_by(group_id) %>%
    slice_max(order_by = adj_R_squared, n = 1) %>%
    ungroup()
  
  # Identify models with AIC weight > 0.95 (AIC weight "wins")
  best_models_AIC_weight_wins <- model_comparison_filtered %>%
    filter(AIC_weight > 0.95)
  
  # Identify clear winners (≥2 AICc units better than second-best)
  clear_winners <- model_comparison_filtered %>%
    group_by(group_id) %>%
    arrange(AICc) %>%
    mutate(delta_next_best = lead(AICc) - AICc) %>%
    slice(1) %>%
    ungroup() %>%
    filter(delta_next_best >= 2)
  
  # Count occurrences for adjusted R-squared
  best_adj_R_counts <- best_models_adj_R %>%
    count(model, name = "best_model_by_adj_R_count")
  
  # Count occurrences of AIC weight "wins" (AIC weight > 0.95)
  best_AIC_weight_wins_counts <- best_models_AIC_weight_wins %>%
    count(model, name = "best_model_AIC_weight_wins")
  
  # Count occurrences of clear AICc winners (delta AIC over 2)
  clear_winner_counts <- clear_winners %>%
    count(model, name = "AICc_clear_winner_count")
  
  # Calculate model frequency for AICc (for printing only)
  model_frequency <- best_models_AICc %>%
    count(model) %>%
    mutate(proportion = n / sum(n))
  
  # Create summary table
  summary_table <- model_comparison_filtered %>%
    group_by(model) %>%
    summarize(
      n_rsq = sum(!is.na(R_squared)),
      mean_R_squared = mean(R_squared, na.rm = TRUE),
      median_R_squared = median(R_squared, na.rm = TRUE),
      sd_R_squared = sd(R_squared, na.rm = TRUE),      
      IQR_R_squared = IQR(R_squared, na.rm = TRUE),   
      se_rsq = sd_R_squared / sqrt(n_rsq),
      ci_lower_rsq = mean_R_squared - 1.96 * se_rsq,
      ci_upper_rsq = mean_R_squared + 1.96 * se_rsq,
      
      n_adj_rsq = sum(!is.na(adj_R_squared)),
      mean_adj_R_squared = mean(adj_R_squared, na.rm = TRUE),
      median_adj_R_squared = median(adj_R_squared, na.rm = TRUE),
      sd_adj_R_squared = sd(adj_R_squared, na.rm = TRUE),
      IQR_adj_R_squared = IQR(adj_R_squared, na.rm = TRUE),
      se_adj_rsq = sd_adj_R_squared / sqrt(n_adj_rsq),
      ci_lower_adj_rsq = mean_adj_R_squared - 1.96 * se_adj_rsq,
      ci_upper_adj_rsq = mean_adj_R_squared + 1.96 * se_adj_rsq,
      
      mean_AICc = mean(AICc, na.rm = TRUE),
      mean_BIC = mean(BIC, na.rm = TRUE),
      mean_AIC_weight = mean(AIC_weight, na.rm = TRUE),
      mean_BIC_weight = mean(BIC_weight, na.rm = TRUE),
      
      convergence_rate = sum(convergence, na.rm = TRUE) / n()
    ) %>%
    left_join(best_adj_R_counts, by = "model") %>%
    left_join(best_AIC_weight_wins_counts, by = "model") %>%
    left_join(clear_winner_counts, by = "model") %>%
    mutate(
      best_model_by_adj_R_count = replace_na(best_model_by_adj_R_count, 0),
      best_model_AIC_weight_wins = replace_na(best_model_AIC_weight_wins, 0),
      AICc_clear_winner_count = replace_na(AICc_clear_winner_count, 0)
    )
  
  # Generate range name if not provided
  if(is.null(range_name)) {
    range_name <- paste(temp_min, "to", temp_max, "°C")
  }
  
  # Print results
  cat("\n----- Analysis for Temperature Range:", range_name, "-----\n")
  cat("Number of experiments:", length(unique(range_models$group_id)), "\n")
  cat("\nModel frequency based on AICc:\n")
  print(model_frequency)
  cat("\nModel summary:\n")
  print(summary_table)
  
  return(summary_table)
}


# Then use the function for each range to create dataframes:
results_low <- analyze_temperature_range(model_comparison, 0, 12, "Low (0-12°C)")
results_medium <- analyze_temperature_range(model_comparison, 12, 25, "Medium (12-25°C)")
results_high <- analyze_temperature_range(model_comparison, 25, 38, "High (25-37°C)")
results_all_temps <- analyze_temperature_range(model_comparison, 0, 38, "All temps (0-37°C)")


# Save to csv files:
write.csv(results_low, "../output/low_temp_summary.csv", row.names = FALSE)
write.csv(results_medium, "../output/medium_temp_summary.csv", row.names = FALSE)
write.csv(results_high, "../output/high_temp_summary.csv", row.names = FALSE)
write.csv(results_all_temps, "../output/total_temp_summary.csv", row.names = FALSE)

##############################
# 6. VISUALLY EXAMINE models
##############################

####### observing their fit across all group IDS visually by plotting values #####################

# Create a function to plot one group's data with all model fits
plot_group_fits <- function(group_id) {
  # Get the group data which will be passed to function
  group_data <- data[data$group_id == group_id, ]
  
  # Get the unit for this specific group from the model_comparison dataframe
  unit <- model_comparison %>%
    filter(group_id == !!group_id) %>%
    pull(PopBio_units) %>%
    unique() %>%
    .[1]  # Takes the first since units are the same value
  
  # Get all model fits for this group, checks element is not null and has matching group IDs: 
  cubic_fit <- cubic_results[[which(sapply(cubic_results, function(x) !is.null(x) && x$group_id == group_id))]]
  logistic_fit <- logistic_results[[which(sapply(logistic_results, function(x) !is.null(x) && x$group_id == group_id))]]
  gompertz_fit <- gompertz_results[[which(sapply(gompertz_results, function(x) !is.null(x) && x$group_id == group_id))]]

  # Create time sequence for smooth prediction curves
  time_seq <- seq(min(group_data$Time), max(group_data$Time), length.out = 100)
  
  # Base plot with data points to be plotted
  p <- ggplot(group_data, aes(x = Time, y = PopBio)) +
    geom_point(size = 3, alpha = 0.7) +
    labs(
      x = "Time in hours", 
      y = paste0("Population Size (", unit, ")")
    ) +
    theme_minimal()
  
  # Add model fits if available: fit exists and convergence of nlls was reached
  #Does this for all models compared
  if(!is.null(cubic_fit) && cubic_fit$convergence) {
    pred_df <- data.frame(Time = time_seq)
    pred_df$y <- predict(cubic_fit$model, newdata = pred_df)
    p <- p + geom_line(data = pred_df, aes(x = Time, y = y, color = "Cubic"), size = 1)
  }
  
  if(!is.null(logistic_fit) && logistic_fit$convergence) {
    pred_df <- data.frame(Time = time_seq)
    pred_df$y <- predict(logistic_fit$model, newdata = pred_df)
    p <- p + geom_line(data = pred_df, aes(x = Time, y = y, color = "Logistic"), size = 1)
  }
  
  if(!is.null(gompertz_fit) && gompertz_fit$convergence) {
    pred_df <- data.frame(Time = time_seq)
    pred_df$y <- exp(predict(gompertz_fit$model, newdata = pred_df)) # Convert back from log
    p <- p + geom_line(data = pred_df, aes(x = Time, y = y, color = "Gompertz"), size = 1)
  }
  
  return(p)
}

##############################################################################################
# visually display growth model behaviours across temperature groups (0-12, 12,25 and 25-37 degrees celcius)
##############################################################################################

#Specify temperature ranges
low_group_ids <- model_comparison %>%
  filter(Temp >= 0 & Temp < 12) %>%
  filter(n() > 30) %>%
  pull(group_id) %>%
  unique()

medium_group_ids <- model_comparison %>%
  filter(Temp >= 12 & Temp < 25) %>%
  filter(n() > 30) %>%
  pull(group_id) %>%
  unique()

high_group_ids <- model_comparison %>%
  filter(Temp >= 25 & Temp < 37) %>%
  filter(n() > 30) %>%
  pull(group_id) %>%
  unique()

 #Sample three group IDs from each temperature range
set.seed(124)  # For reproducibility
low_sample    <- sample(low_group_ids,    4)
medium_sample <- sample(medium_group_ids, 4)
high_sample   <- sample(high_group_ids,   4)

# Generate plots for each range using plot_group_fits() 
low_plots    <- lapply(low_sample, plot_group_fits)
medium_plots <- lapply(medium_sample, plot_group_fits)
high_plots   <- lapply(high_sample,   plot_group_fits)

### Arrange the nine plots in a 3x3 grid ###
combined_grid <- grid.arrange(
  arrangeGrob(grobs = low_plots,    ncol = 4, top = "Temperature Range 0-12°C"),
  arrangeGrob(grobs = medium_plots, ncol = 4, top = "Temperature Range 12-25°C"),
  arrangeGrob(grobs = high_plots,   ncol = 4, top = "Temperature Range 25-37°C"),
  ncol = 1
)

### Save the final combined plot ###
ggsave("../output/model_comparison_by_temp_ranges.png",
       combined_grid, width = 12, height = 12)


###############################################################################
# 7. Violin plot for Aikaike weight distribution across groups
###############################################################################
# filter for converged models
plot_data <- model_comparison %>% filter(convergence == TRUE)

# Create temperature range datasets
low_temp_data <- plot_data %>% filter(Temp >= 0 & Temp < 12)
medium_temp_data <- plot_data %>% filter(Temp >= 12 & Temp < 25)
high_temp_data <- plot_data %>% filter(Temp >= 25 & Temp <= 37)

# Function to add jitter for visual clarity
jitter_values <- function(x) {
  ifelse(is.na(x), NA, x + runif(length(x), -0.025, 0.025))  # Add tiny noise to avoid stacking, NA values are prevented
}

# Apply jitter to AIC weights
low_temp_data <- low_temp_data %>% mutate(AIC_weight_jittered = jitter_values(AIC_weight))
medium_temp_data <- medium_temp_data %>% mutate(AIC_weight_jittered = jitter_values(AIC_weight))
high_temp_data <- high_temp_data %>% mutate(AIC_weight_jittered = jitter_values(AIC_weight))

# Function to plot violin plots for a given dataset 
plot_violin_graph <- function(dataframe, temp_range, show_y_axis = TRUE) {
  p <- ggplot(dataframe, aes(x = model, y = AIC_weight_jittered, fill = model)) + #plot data 
    geom_violin(alpha = 0.7, width = 0.8, draw_quantiles = c(0.25, 0.5, 0.75)) + #add quantile
    labs( 
      title = temp_range, #define axes
      x = NULL,
      y = if(show_y_axis) "AICc Weight" else NULL
    ) +
    scale_fill_manual(values = c("cubic" = "blue", "logistic" = "red", "gompertz" = "green"), #select colours
                      labels = c("cubic" = "Cubic", "logistic" = "Logistic", "gompertz" = "Gompertz")) +
    scale_y_continuous(limits = c(0, 1)) + #set range from 0-1 (Aikaike weights are probabilities)
    scale_x_discrete(labels = c("cubic" = "Cubic", "logistic" = "Logistic", "gompertz" = "Gompertz")) + #format x-axis labels
    theme_bw() +
    theme(legend.position = "none")  # Remove individual legends
  
  # Remove y-axis text and ticks for all but the leftmost plot
  if (!show_y_axis) {
    p <- p + theme(
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank()
    )
  }
  
  return(p)
}

# Generate individual plots - only first plot shows y-axis
low_plot <- plot_violin_graph(low_temp_data, "Low Temp: 0-12°C", show_y_axis = TRUE)
medium_plot <- plot_violin_graph(medium_temp_data, "Medium Temp: 12-25°C", show_y_axis = FALSE)
high_plot <- plot_violin_graph(high_temp_data, "High Temp: 25-37°C", show_y_axis = FALSE)

# Create a common legend, apply colours to curves and place it at bottom
legend_plot <- ggplot(plot_data, aes(x = model, y = AIC_weight, fill = model)) +
  geom_violin() +
  scale_fill_manual(values = c("cubic" = "blue", "logistic" = "red", "gompertz" = "green"),
                    labels = c("cubic" = "Cubic", "logistic" = "Logistic", "gompertz" = "Gompertz"),
                    name = "Model Type") +
  theme(legend.position = "bottom")

# Extract the legend
legend <- get_legend(legend_plot)

# Combine plots horizontally with shared y-axis label and add the legend at the bottom
plots_row <- plot_grid(
  low_plot, medium_plot, high_plot,
  ncol = 3,
  align = "h",
  axis = "bt"
)

# Add the plots directly with the legend 
plots_with_legend <- plot_grid(
  plots_row,
  legend,
  ncol = 1,
  rel_heights = c(1, 0.1)
)

# Add an overall title with background
title <- ggdraw() + 
  draw_label("AICc Weight Distribution by Model and Temperature Range", 
             fontface = "bold", size = 14, x = 0.5, y = 0.5) +
  theme(
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# Combine title and plots
final_plot <- plot_grid(
  title, plots_with_legend,
  ncol = 1,
  rel_heights = c(0.1, 1)
)

# Save the plot with appropriate dimensions and white background
ggsave("../output/AICc_weight_violin.png", plot = final_plot, 
       width = 12, height = 6, dpi = 300, bg = "white")  # Wider, shorter format

