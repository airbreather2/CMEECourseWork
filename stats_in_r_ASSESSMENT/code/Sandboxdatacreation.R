#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

# Start your script by setting the seed
set.seed(1234)  # Replace 123 with your chosen seed number


library(dplyr)
library(MASS)
library(mgcv)

budburst <-read.csv("../data/girthandbudburst.csv")


############ Sample one observation per Tree ID within each period
sampled_data <- budburst %>%
  group_by(TreeID, Period) %>%
  sample_n(size = 1) %>%
  ungroup()
###################### create dataset 

write.csv(sampled_data, "../data/stratifiedgirthdata.csv", row.names = FALSE)
budburst <-read.csv("../data/stratifiedgirthdata.csv")

sort(unique(budburst$Year))


par(mfrow(1,1))
hist(sampled_data$JulianDay, breaks = 50)
qqnorm(budburst$JulianDay)

glm_model <- glm(JulianDay ~ Girth_cm + factor(Period), 
                 data = sampled_data,
                 family = poisson(link = "log"))

summary(glm_model)

########comparing statistical power of glms



# Calculate power as the proportion of p-values less than 0.05
power <- mean(p_values < 0.05)
print(power)















par(mfrow = c(2, 2))
plot(gam_model)


# Calculate Cook's distance
cooks_dist <- cooks.distance(glm_model)

# Identify observations with high Cook's distance
threshold <- 4 / length(cooks_dist)
influential_points <- which(cooks_dist > threshold)

# Number of influential points (potential outliers)
num_influential <- length(influential_points)
print(num_influential)



par(mfrow = c(2, 2))
plot(glm_model)
