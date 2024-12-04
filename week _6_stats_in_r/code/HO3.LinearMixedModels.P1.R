# When to Use a Mixed-Effects Model:
# - Use when data has both fixed and random effects.
# - Fixed effects: Variables of primary interest whose levels are consistent across studies (e.g., treatment groups).
# - Random effects: Variables with levels that represent random samples from a larger population (e.g., subjects, groups).
# - Ideal for hierarchical or grouped data (e.g., repeated measurements on individuals, measurements from different locations).
# - Useful to account for non-independence within groups (e.g., measurements from the same student or time period).
# - Allows modeling of both within-group and between-group variability, improving the accuracy of results.


rm(list=ls())

d<-read.table("../data/ObserverRepeatability.txt", header=T)
str(d)

# Using the dataset from the first Stats with Sparrows week, measuring tarsus and bill width.
# We will evaluate how much variance is explained by differences between observers and by group.
# Data is grouped by morning/afternoon sessions and by year, with groups labeled A-I.

# StudentID and Group are already factors
# To assess variance explained by each group-level variable, first examine the data spread.

hist(d$Tarsus)
#there looks to be an outlier in this data 
hist(d$BillWidth)

d<-subset(d, d$Tarsus<=30)
d<-subset(d, d$Tarsus>=10)
hist(d$Tarsus)

#now lets reexamine
summary(d$tarsus)
var(d$tarsus)
summary(d$BillWidth)
var(d$BillWidth)

# Summary of methods and approach:
# We aim to measure variance introduced by observers in measuring sparrow morphology (tarsus length, bill width).
# Traits measured: tarsus length and bill width of a stuffed sparrow (Passer domesticus), in mm to 0.1 mm precision.
# Data collected annually during Stats With Sparrows course; 266 observations from 113 students across eight groups.
# Analysis approach:
# - Two mixed-effects models (one for tarsus length, one for bill width) with StudentID and Group as random intercepts.
# - No fixed effects; intercept set to 1.
# - Use likelihood-ratio tests to assess significance of each random effect by comparing models with and without the effect.

require(lme4)
require(lmtest)


mT1<-lmer(Tarsus~1+(1|StudentID), data=d)
mT2<-lmer(Tarsus~1+(1|StudentID)+(1|GroupN), data=d)
lrtest(mT1,mT2)

# Model mT1:
# mT1 <- lmer(Tarsus ~ 1 + (1 | StudentID), data = d)
# - This model estimates the variance in Tarsus length, accounting for random effects by StudentID.
# - The intercept (1) represents the overall mean Tarsus length.
# - (1 | StudentID) allows each student to have their own random intercept, capturing variation in measurements between students.

# Model mT2:
# mT2 <- lmer(Tarsus ~ 1 + (1 | StudentID) + (1 | GroupN), data = d)
# - This model builds on mT1 by adding GroupN as a second random effect.
# - (1 | GroupN) allows each group (A-I) to have a unique random intercept, accounting for variation across groups.
# - By comparing mT1 and mT2, we can assess how much additional variance is explained by including GroupN.

# LogLik: Log-likelihood values for each model (higher values indicate better fit).
# - mT1 LogLik: -506.72
# - mT2 LogLik: -505.08

# Chisq: Chi-squared statistic (3.2809) comparing the two models.
# Pr(>Chisq): p-value (0.0709), testing if adding GroupN significantly improves model fit.

# Interpretation:
# - p-value (0.0709) is above 0.05, indicating that adding GroupN as a random effect does not significantly improve model fit.
# - Suggests that StudentID alone may be sufficient to explain most of the variance in Tarsus measurements.
# - GroupN might explain some variance, but the evidence is not strong enough to be statistically significant at 0.05 level.
# however it is close so worth keeping an eye on

summary(mT1)

# Model Summary for mT1 (Tarsus ~ 1 + (1 | StudentID))
# - Formula: Tarsus ~ 1 + (1 | StudentID)
#   - This model examines Tarsus length with a fixed intercept and a random intercept for each StudentID.
#
# REML Criterion:
# - REML criterion at convergence: 1013.4
#   - A measure of model fit; lower values indicate better fit.
#
# Scaled Residuals:
# - Min, 1Q, Median, 3Q, Max: These summarize residuals, showing how well the model fits the data.
#   - Residuals close to zero indicate good fit.
#
# Random Effects:
# - StudentID (Intercept):
#   - Variance: 3.209; Std.Dev.: 1.791
#   - This represents variability in Tarsus length due to individual differences in StudentID.
# - Residual:
#   - Variance: 1.228; Std.Dev.: 1.108
#   - This captures remaining variance in Tarsus length not explained by the model.
# - Observations: 264 total observations, from 112 unique students (StudentID).
#
# Fixed Effects:
# - Intercept:
#   - Estimate: 18.4041, Std. Error: 0.1856, t-value: 99.18
#   - This is the overall average Tarsus length, and a high t-value indicates it is highly significant.
#
# Intraclass Correlation Coefficient (ICC):
# - ICC calculation: 3.21 / (3.21 + 1.23) = 0.723
#   - Approximately 72.3% of the variance in Tarsus length is due to differences among students.
#
# Summary:
# - The model shows an average Tarsus length of 18.4041 cm.
# - StudentID explains 72.3% of the variance, while the remaining variance is residual.

##########LOOK AT HANDOUT SHEET TO SEE HOW TO WRITE THESE RESULTS PROPERLEY###############
