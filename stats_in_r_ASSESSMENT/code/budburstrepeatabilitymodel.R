#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>


#############################REFIT MODEL WITH ADJUSTED TREE IDS WHERE TREES ARE NOT SINGLE




#########requirements################
require(ggplot2)
library(lme4)


budburst <-read.csv("../data/budburstrepeatability.csv")

#M1 <- glm(JulianDay ~ Year, data = budburst, family = "gaussian")


ggplot(budburst, aes(x = Year, y = JulianDay)) +
  geom_jitter(width = 0.2, height = 0, aes(color = as.factor(Year))) +  # Adds jitter and colors each year differently
  geom_smooth(method = "lm", color = "RED", se = FALSE) +
  labs(x = "Year", y = "Budburst Day", title = "Budburst Day vs. Year", color = "Year") +
  scale_y_continuous(limits = c(50, 150)) +
  theme_minimal()



M_repeat_filtered <- lmer(JulianDay ~ Year + (1 | TreeID), data = budburst)

hist(budburst$JulianDay)

VarCorr(M_repeat_filtered)

summary(M_repeat_filtered)
hist(budburst$JulianDay)

p <- ggplot(budburst, aes(x = Year, y = JulianDay)) +
  geom_point() +  # plot data points
  geom_smooth(method = "glm", formula = y ~ x, method.args = list(family = "gaussian"), se = TRUE) +
  labs(title = "Julian Day vs. Year", x = "Year", y = "Julian Day") +
  scale_x_continuous(breaks = seq(min(budburst$Year), max(budburst$Year), by = 1)) +  # show each year
  scale_y_continuous(limits = c(50, 170)) +  # set y-axis from 0 to 365
  theme_minimal()

# Print the plot
print(p)

  

print(p)
