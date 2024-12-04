library(ggplot2)
library(dplyr)

data <- read.csv("../data/EcolArchives-E089-51-D1.csv")

# Combine all feeding types into one dataset
data_combined <- data %>%
  mutate(
    LogPreyMass = log10(Prey.mass),
    LogPredatorMass = log10(Predator.mass)
  )

combined_plot <- ggplot(data_combined, aes(x = Prey.mass, y = Predator.mass, color = Predator.lifestage)) + 
  geom_point(shape = 3) +
  geom_smooth(method = "lm", se = TRUE, fullrange=TRUE) +
  facet_wrap(~Type.of.feeding.interaction, ncol = 1, strip.position = "right") + #creates seperate plots for different feeding interaction types
  scale_x_log10(limits = c(1e-7, 1e2)) +  # Use log scale for x-axis
  scale_y_log10(limits = c(1e-6, 1e6)) +  # Use log scale for y-axis
  theme_bw() +  # Start with a clean black-and-white theme
  theme(
    legend.position = "bottom"  # Move legend to bottom
  ) +
  guides(color = guide_legend(nrow = 1)) + # Set the number of rows in the legend 
  labs(
    x = "Prey Mass in grams (log scale)",
    y = "Predator Mass in grams (log scale)",
    color = "Predator Lifestage"
  )

# Display the combined plot
print(combined_plot)

