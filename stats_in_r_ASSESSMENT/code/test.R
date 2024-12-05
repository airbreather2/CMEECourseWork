#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>


set.seed(123456)

library(tseries)
library(nortest)
require(ggplot2)
library(lme4)
require(ggeffects)
library(car)
require(usdm)
require(psych)
require(lmerTest)
require(sjPlot)


table(sampled_data$Period)

##########finding normaility of residuals

residuals_lmm <- resid(mixed_model)

hist(residuals_lmm, main = "Histogram of Residuals", xlab = "Residuals", breaks = 10)

jarque.bera.test(residuals_lmm)
shapiro.test(residuals_lmm)
ad.test(residuals_lmm)

budburst <-read.csv("../data/stratifiedgirthdata.csv")


# Fit a mixed-effects model  (TREEID REMOVED AS A RANDOM EFFECT AS NOT ENOUGH SAMPLES FOR VARIABILITY)
mixed_model <- lmer(JulianDay ~ Girth_cm + DateRange + (1 | SPlocation), 
                    data = budburst)
summary(mixed_model)



# 1. Check Linearity
# Plot residuals vs. fitted values
plot(resid(mixed_model) ~ fitted(mixed_model), main = "Residuals vs Fitted")
abline(h = 0, col = "red")
# Interpretation: Residuals should be randomly scattered around zero with no clear pattern.

# 2. Check Normality of Residuals
# Q-Q plot for residuals
qqnorm(resid(mixed_model), main = "Q-Q Plot of Residuals")
qqline(resid(mixed_model))
# Interpretation: Residuals should fall along the line. Deviations suggest non-normality.

# 3. Check Homoscedasticity (Constant Variance)ues again
plot(fitted(mixeds_model), resid(mixed_model), main = "Homoscedasticity Check")
abline(h = 0, col = "red")
# Interpretation: Residuals should have a constant spread. A funnel shape indicates heteroscedasticity.

# 4. Check Independence of Observations
# Ensure the random effects structure is correctly specified
summary(mixed_model)
# Interpretation: Confirm that your random effects (e.g., TreeID, SPlocation) are meaningful and correctly modeled.

# 5. Check Normality of Random Effects
# Q-Q plot for random effects
qqnorm(ranef(mixed_model)$SPlocation[, 1], main = "Q-Q Plot of Random Effects (SPlocation)")
qqline(ranef(mixed_model)$SPlocation[, 1])
# Interpretation: Random effects should be normally distributed.

# 6. Check for Multicollinearity
# Calculate Variance Inflation Factor (VIF)
vif_values <- car::vif(mixed_model)
print(vif_values)
# Interpretation: VIF values should be below 5. High values indicate multicollinearity.

# 7. Model Fit Diagnostics
# Use diagnostic plots and summary to check model performance
plot(mixed_model)
# Interpretation: Review plots for any patterns or issues in model fit.
tab_model(mixed_model)

plot(ggpredict(mixed_model, terms = c("Girth_cm", "Period")), 
     show_data = TRUE, 
     colors = c("lightgreen", "darkgreen"))
# Load necessary libraries
library(ggeffects)
library(ggplot2)

# Load necessary libraries
library(ggeffects)
library(ggplot2)

mixed_model$Period <- as.factor(mixed_model$Period)

# Generate the ggpredict object, ensuring Period is treated as a factor
predictions <- ggpredict(mixed_model, terms = c("Girth_cm", "as.factor(Period)"))


# Generate and customize the plot
# Customize the plot with modified legend labels

# Customize the plot with modified legend labels
plot(ggpredict(mixed_model, terms = c("Girth_cm", "DateRange")),
     show_data = TRUE,
     colors = c("#006400", "red")) +  # Dark green and red colors
  geom_jitter(width = 5, height = 0.5, alpha = 0.4) +  # Adding jitter with some transparency
  scale_fill_manual(values = c("green", "red")) +  # Light green and pink for confidence interval fill
  theme_minimal() +  # Cleaner and more modern theme
  theme(
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10)
  ) +
  labs(
    x = "Tree Girth (cm)",
    y = "Julian Days until Budburst in trees"
  ) +
  ggtitle("") +
  scale_color_manual(
    values = c("#006400", "red"),  # Ensure colors are defined
    labels = c("2007-2015", "2016-2018")  # Custom legend labels
  )

