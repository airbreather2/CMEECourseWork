#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

###########Binomial and Binary Models################

#Remember the three steps of generalised linear models

#Choosing a distribution from the response variable that makes assumptions about its error structure (e.g Binomial)

#Specifying a linear function of covariates and /or fixed factors 
#Covariates adjust for continuous variables to account for additional variation.
#Fixed factors represent categorical groups or levels being directly compared in the analysis.

#Choosing a link function between the predictor function and the mean of the distribution (of the response variable) (here: logit)


#########Binary Models #########
require(ggplot2)
require(ggpubr)
worker <- read.csv("../data/workerbees.csv",stringsAsFactors = T)
str(worker)
#data contains worker bee cell size and presence/absence of parasites 

#lets see this graphically
scatterplot<-ggplot(worker, aes(x=CellSize, y=Parasites))+
  geom_point()+
  labs(x= "Cell Size (cm)", y="Probability of Parasite")+
  theme_classic()
boxplot<- ggplot(worker, aes(x=factor(Parasites), y=CellSize))+
  geom_boxplot()+
  theme_classic()+
  labs(x="Presence/Absence of Parasites", y="Cell Size (cm)")
ggarrange(scatterplot, boxplot, labels=c("A","B"), ncol=1, nrow=2)

##################fitting the model ######################
M1<- glm(Parasites~CellSize, data = worker, family = "binomial")
summary(M1)

anova(M1, test = "Chisq")

# Logistic Regression Model Output Explanation
# We used glm() to model the probability of parasites being present (Parasites) based on cell size (CellSize).
# Since 'Parasites' is binary, we specified a binomial family.

# Coefficients Interpretation:
# The intercept is -11.245, meaning when CellSize = 0, the log odds of having parasites is -11.245.
# The CellSize coefficient (22.175) suggests that as CellSize increases, the likelihood of parasites increases.
# Both the intercept and CellSize coefficients are highly significant (p < 2e-16), indicating a strong relationship.

# Model Deviance and AIC:
# Null Deviance (1259.6) represents the deviance of a model with only an intercept.
# Residual Deviance (1104.9) shows the deviance after adding CellSize as a predictor, indicating a reduction in unexplained variation.
# AIC (1108.9) is used to compare model fit; lower values suggest better fit.

# ANOVA with Chi-Square Test:
# The anova() function compares the null model (no predictors) to the current model with CellSize.
# Df: Degrees of freedom for each model.
# Deviance: Shows how much unexplained variation each model has.
# Pr(>Chi): The p-value for the chi-square test (p < 2e-16), indicating that adding CellSize significantly improves model fit.
# Overall, this output suggests that cell size is a significant predictor of parasite presence.

#############MODEL INTERPRETATION#####################################

#from this summary we can plot the equation

# logit(Probability of Parasites) = -11.25 + 22.18 * CellSize

# Converting the logit equation into a threshold cell size:
# Starting with the logistic regression model:
# logit(Probability of Parasites) = -11.25 + 22.18 * CellSize
# Set logit = 0 to find the cell size threshold where the probability of parasites is 50%.
# 0 = -11.25 + 22.18 * CellSize
# Solve for CellSize:
# CellSize = 11.25 / 22.18 ≈ 0.51 cm
# This threshold (0.51 cm) is the cell size threshold where there is a 50% chance of finding parasites.

# Why does logit = 0 mean a 50% chance of finding parasites?
# In logistic regression, logit(p) is the log-odds of an outcome (e.g., parasite presence).
# The logit function is defined as logit(p) = ln(p / (1 - p)), where p is the probability of the outcome.
# When logit(p) = 0, it implies ln(p / (1 - p)) = 0.
# Solving for p when logit(p) = 0:
#    ln(p / (1 - p)) = 0
#    => p / (1 - p) = 1
#    => p = 1 - p
#    => 2p = 1, so p = 0.5
# Thus, when logit = 0, p = 0.5, meaning there's a 50% probability of finding parasites.

###############PLOTTING THIS GRAPHICALLY########################################

range(worker$CellSize) # Finding the range of CellSize in the worker dataset
## [1] 0.352 0.664

new_data <- data.frame(CellSize=seq(from=0.352, to=0.664, length=100)) # Creating a new dataset with CellSize values from 0.352 to 0.664 in 100 steps

predictions <- predict(M1, newdata = new_data, type = "link", se.fit = TRUE) # Predicting log-odds (link scale) and standard error (se) for each CellSize in new_data

new_data$pred <- predictions$fit # Adding predicted values (log-odds) to new_data
new_data$se <- predictions$se.fit # Adding standard errors of predictions to new_data

new_data$upperCI <- new_data$pred + (new_data$se * 1.96) # Calculating the upper 95% confidence interval for log-odds
new_data$lowerCI <- new_data$pred - (new_data$se * 1.96) # Calculating the lower 95% confidence interval for log-odds

# Making the Plot
ggplot(new_data, aes(x=CellSize, y=plogis(pred)))+  # Plotting predicted probability (converting log-odds to probability with plogis)
  geom_line(col="black")+ # Adding a line for the predicted probabilities
  geom_point(worker, mapping = aes(x=CellSize, y=Parasites), col="blue")+ # Adding actual data points from worker dataset
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend = FALSE)+ # Adding confidence interval ribbon for probabilities
  labs(y="Probability of Infection", x="Cell Size (cm)")+ # Labeling y-axis as Probability of Infection and x-axis as Cell Size (cm)
  theme_classic() # Applying a clean, classic theme to the plot

#can find r squared by dividing residual by null deviance and minusing by 1
pseudo_r_squared <- 1 - (1104 / 1259)
pseudo_r_squared
# this model was able to explain 12 percent of the varation regarding presence and absence of the mite



############################Chrytrid Infection Status in the Pyrenees#########################################

require(ggplot2)
chytrid<- read.csv("../data/chytrid.csv", stringsAsFactors = T)
str(chytrid)
 
# Dataset includes amphibian infection status (1 = positive, 0 = negative) 
# from lakes and ponds in the Pyrenees (2003-2018).
# Also includes climate data: annual rainfall, average max, min, and mean annual 
# temperatures, and average spring temperature.
# Next, we will analyze the relationship between average spring temperature 
# and chytrid infection status to assess if spring temperature clearly affects infection outcomes.

scatterplot<-ggplot(chytrid, aes(x=Springavgtemp, y=InfectionStatus))+
  geom_point()+
  labs(x= "Probability of Infection", y="Average Spring Temperature (Degrees Celsius)")+
  theme_classic()
boxplot<- ggplot(chytrid, aes(x=factor(InfectionStatus), y=Springavgtemp))+
  geom_boxplot()+
  theme_classic()+
  labs(x="Presence/Absence of Infection", y="Average Spring Temperature (Degrees Celsius)")
ggarrange(scatterplot, boxplot, labels=c("A","B"), ncol=1, nrow=2)

#its not apparent but the plots show in the data that spring temperature does increase infection likelihood

M2<- glm(InfectionStatus~Springavgtemp, data = chytrid, family = "binomial")
summary(M2)

# Logistic Regression Model Output Explanation
# We modeled the probability of amphibian infection status (InfectionStatus) based on average spring temperature (Springavgtemp).
# 
# Coefficients:
# - The intercept is -0.057236, which represents the log-odds of infection when Springavgtemp is 0.
# - The Springavgtemp coefficient (0.052629) suggests that as average spring temperature increases, the log-odds of infection increase.
# - The p-value for Springavgtemp is highly significant (p < 0.001), indicating a strong relationship between spring temperature and infection status.
#
# Model Deviance and AIC:
# - Null Deviance (9310.0) represents the deviance with only an intercept (no predictors).
# - Residual Deviance (9270.7) represents the deviance with Springavgtemp as a predictor, showing a reduction in unexplained variation.
# - AIC (9274.7) is used for model comparison; lower AIC values indicate a better fit.

anova(M2, test="Chisq")

# ANOVA with Chi-Square Test:
# - The Chi-square test shows the effect of Springavgtemp on infection status.
# - The p-value (< 0.001) indicates that adding Springavgtemp significantly improves the model fit.
# - Overall, this suggests a significant positive association between spring temperature and the likelihood of infection.

#######Model interpretation###########################

# Model Interpretation
# From the logistic regression summary, we can construct the logit equation for infection probability:
# logit(Probability of Infection) = -0.06 + 0.05 * AverageSpringTemperature
#
# The equation implies that as the average spring temperature increases, the log-odds of infection also increase.
#
# Flipping Point (Threshold Temperature):
# To find the temperature at which there is an equal probability of infection (50% chance), set the logit to 0.
# Solve for AverageSpringTemperature when logit = 0:
# 0 = -0.06 + 0.05 * AverageSpringTemperature
# AverageSpringTemperature = -(-0.06) / 0.05 = 1.2 degrees Celsius
# This indicates that amphibians are more likely to be infected with chytrid when spring temperatures exceed 1.2 degrees Celsius.
#
# Pseudo R-squared:
# Pseudo-R^2 helps us understand the proportion of variance explained by the model.
# Here, we calculate McFadden's pseudo-R^2 as:
# PseudoR^2 = 1 - (Residual Deviance / Null Deviance)
# PseudoR^2 = 1 - (9270.7 / 9310.0) = 0.004
# This value (0.004) means the model explains about 0.4% of the variation in infection presence/absence.
#
# Interpretation:
# Although significant, the effect of spring temperature explains a small portion of the variability in chytrid infection status.

#####################################PLOTTING THE MODEL###############################

range(chytrid$Springavgtemp) # Find range of Average Spring Temperature
## [1]  0.9968934 13.6638193

new_data <- data.frame(Springavgtemp=seq(from=0.99, to=13.67, length=100)) # Create new data with Springavgtemp from 0.99 to 13.67

predictions <- predict(M2, newdata = new_data, type = "link", se.fit = TRUE) # Predict log-odds and SE for each Springavgtemp

new_data$pred <- predictions$fit # Add predicted log-odds to new_data
new_data$se <- predictions$se.fit # Add SE of predictions to new_data

new_data$upperCI <- new_data$pred + (new_data$se * 1.96) # Calculate upper 95% CI
new_data$lowerCI <- new_data$pred - (new_data$se * 1.96) # Calculate lower 95% CI

# Plot the data
ggplot(new_data, aes(x=Springavgtemp, y=plogis(pred)))+  # Plot predicted probability
  geom_line(col="black")+ # Add line for predicted probabilities
  geom_point(chytrid, mapping = aes(x=Springavgtemp, y=InfectionStatus), col="blue")+ # Add actual data points
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend = FALSE)+ # Add CI ribbon
  labs(y="Probability of Infection", x="Average Spring Temperature (Degrees Celsius)")+ # Label axes
  theme_classic() # Apply classic theme

#While plot tells reader about relationship between spring temp and infection status, relationship appears weak and y intercept starts above 0.50

###############BINOMIAL MODELS #####################################
#in this section we'll model the same data as a binomial outcome instead of a binary outcome: 
#Number of positives over number of Negatives

chytrid_binomial<- read.csv("../data/chytrid_binomial.csv", stringsAsFactors = T)
str(chytrid_binomial)
# The dataset is a condensed version of the "chytrid.csv" dataset.
# Relevant columns:
# - "Positives": Number of positive samples per "Year", "Site", "Habitat", and "LarvalStage".
# - "Total": Total number of samples.
# We can use "Positives" and "Total" to create a binomial model to analyze if average spring temperature affects 
# the probability of chytrid infection.
# Use cbind to feed the number of positives and negatives into the glm function.

M3<- glm(cbind(Positives, Total-Positives)~AverageSpringTemp, data = chytrid_binomial, family = "binomial")
summary(M3)
anova(M3, test="Chisq")

# Binomial Model Summary:
# The model analyzes the relationship between AverageSpringTemp and the probability of chytrid infection.
# Coefficients:
# - Intercept = -0.403670: Represents the log-odds of infection when AverageSpringTemp is 0.
# - AverageSpringTemp coefficient = 0.088839: A positive value, suggesting that higher spring temperatures increase the log-odds of infection.
# - Both coefficients are highly significant (p < 0.001), indicating a strong relationship.
#
# Deviance and AIC:
# - Null Deviance = 5695.4, representing the deviance with only an intercept.
# - Residual Deviance = 4795.7, showing reduced unexplained variation after adding AverageSpringTemp as a predictor.
# - AIC = 5410.5, used for model comparison (lower values indicate better fit).
#
# ANOVA with Chi-Square Test:
# - The Chi-square test shows that adding AverageSpringTemp significantly improves the model (p < 0.001).
# - This supports a significant positive association between AverageSpringTemp and the probability of chytrid infection.

##############MODEL INTERPRETATION ###################################
# Model Interpretation:
# From the model summary, we can construct the logit equation:
# logit(Probability of Infection) = -0.4 + 0.09 * AverageSpringTemperature
#
# Interpretation of Slope:
# - The slope coefficient (0.09) means that each 1°C increase in AverageSpringTemperature increases the log-odds of infection by 0.09.
# - In terms of odds, this translates to a 1.09-fold increase in the probability of infection per degree Celsius.
#
# Flipping Point (Threshold Temperature):
# - To find the temperature at which there’s a 50% probability of infection, set logit = 0:
# - Temperature = abs(-0.4 / 0.09) = 4.44 degrees Celsius
# - This suggests that an average spring temperature above 4.44°C is associated with a higher probability of chytrid infection.
#
# Pseudo R-squared:
# - Calculated as: PseudoR^2 = 1 - (Residual Deviance / Null Deviance)
# - PseudoR^2 = 1 - (4795.7 / 5055.4) ≈ 0.05
# - This indicates that the model explains approximately 5% of the variation in infection probability.

###############MODEL VALIDATION #########################

#Dispersion parameter is: 4795.75/173 =27.72
#overdispersed

#could be random effects (year or site) ,fixed factors ~(habitat or larval stage) or continous covariates (Average rf)
# One or zero outliers: potentially (see diagnostic plots below)

par(mfrow=c(2,2))
plot(M3)

#residuals vs leverage plot suggest model may have a number of outliers causing overdispersion
sum(cooks.distance(M3)>1)

#two outliers have been identified above 1 
#This may be due to other covariates or random effects but for now we will fit the quasi-binomial model

#####################FITTING A QUASI-BINOMIAL MODEL##########################################

M4<- glm(cbind(Positives, Total-Positives)~AverageSpringTemp, data = chytrid_binomial, family = "quasibinomial")
summary(M4)

# Quasi-Binomial Model Summary:
# This model examines the effect of AverageSpringTemp on the probability of chytrid infection, accounting for overdispersion.
#
# Coefficients:
# - Intercept = -0.40367: Represents the log-odds of infection when AverageSpringTemp is 0.
# - AverageSpringTemp coefficient = 0.08868: Suggests that higher spring temperatures increase the log-odds of infection.
# - The p-value (0.0012) indicates a significant effect of spring temperature on infection probability.
#
# Dispersion Parameter:
# - Estimated dispersion parameter is 23.44, indicating overdispersion in the data.
#
# Deviance:
# - Null Deviance = 5055.4, which represents the deviance of the model with no predictors.
# - Residual Deviance = 4795.7 after including AverageSpringTemp, showing a reduction in unexplained variation.

### ESTIMATE VALUES DIDN'T CHANGE BUT SEs ARE INFLATED

anova(M4, test="F") # for quasi approaches we use the F test 

#
# ANOVA with F-test:
# - The F-test (used with quasi-binomial models) shows a significant effect of AverageSpringTemp (p < 0.001).
# - This result supports a significant association between AverageSpringTemp and chytrid infection probability.

######################PLOTTING THE MODEL ###########################################

range(chytrid_binomial$AverageSpringTemp) # Find the range of Average Spring Temperature in the chytrid_binomial dataset
## [1]  0.9968934 13.6638193

new_data <- data.frame(AverageSpringTemp=seq(from=0.99, to=13.67, length=100)) # Create new data with 100 values of AverageSpringTemp from 0.99 to 13.67

predictions <- predict(M4, newdata = new_data, type = "link", se.fit = TRUE) # Predict log-odds and SE for each AverageSpringTemp in new_data on the link (log-odds) scale

new_data$pred <- predictions$fit # Add predicted log-odds to new_data
new_data$se <- predictions$se.fit # Add standard errors of predictions to new_data

new_data$upperCI <- new_data$pred + (new_data$se * 1.96) # Calculate upper 95% confidence interval for log-odds
new_data$lowerCI <- new_data$pred - (new_data$se * 1.96) # Calculate lower 95% confidence interval for log-odds

# Plot the data
ggplot(new_data, aes(x=AverageSpringTemp, y=plogis(pred))) + # Plot predicted probability by converting log-odds to probability with plogis
  geom_line(col="black") + # Add a line for the predicted probabilities
  geom_point(chytrid_binomial, mapping = aes(x=AverageSpringTemp, y=(Positives/Total)), col="blue") + # Add actual data points for observed infection rate
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend = FALSE) + # Add confidence interval ribbon for probabilities
  labs(y="Probability of Infection", x="Average Spring Temperature (Degrees Celsius)") + # Label axes
  theme_classic() # Use a clean, classic theme for the plot

######################Revisiting bee mites data #############################################
#we previously said a binomial dist may be a better fit than a poisson model

mites<- read.csv("../data/bee_mites.csv")
M5<- glm(cbind(Dead_mites, Total-Dead_mites)~Concentration, data = mites, family = "binomial")
summary(M5)

# Binomial Model Summary:
# This model examines the effect of Concentration on the probability of mite death.
#
# Coefficients:
# - Intercept = -0.87288: Represents the log-odds of mite death when Concentration is 0.
# - Concentration coefficient = 2.9687: Indicates that higher concentrations increase the log-odds of mite death.
# - Both coefficients are highly significant (p < 0.001), suggesting a strong effect of Concentration on mite death probability.
#
# Deviance and AIC:
# - Null Deviance = 347.77, representing the deviance with no predictors.
# - Residual Deviance = 194.82 after including Concentration, showing a reduction in unexplained variation.
# - AIC = 294.85, used for model comparison; lower values indicate a better fit.

anova(M5, test = "Chisq")

# ANOVA with Chi-Square Test:
# - The Chi-square test shows a significant effect of Concentration (p < 0.001) on mite death probability.
# - This result supports a strong association between Concentration and the probability of mite death.


######################Model Validation ############################################

# Residual deviance: 194.82  on 113  degrees of freedom
#Dispersion parameter is 192.82 divided by 113 = 1.72 
#model is overdispersed

par(mfrow=c(2,2))
plot(M5)

# Using a quasi-Poisson model can be helpful for overdispersed binomial data.
# Overdispersion means the data has more variability than expected by a standard binomial model.
# Standard binomial models assume fixed dispersion (variance), which can lead to underestimated errors and false positives.
# A quasi-Poisson model includes a dispersion parameter, adjusting for extra variability.
# This provides more accurate standard errors, p-values, and confidence intervals, improving model reliability.


############### Refitting the Quasi-binomial Model and Plotting ############################

M6<- glm(cbind(Dead_mites, Total-Dead_mites)~Concentration, data = mites, family = "quasibinomial")

range(mites$Concentration)
## [1] 0.00 2.16
new_data <- data.frame(Concentration=seq(from=0, to=2.16, length=100))
predictions<- predict(M6, newdata = new_data, type = "link", se.fit = TRUE) # the type="link" here predicted the fit and se on the log-linear scale. 
new_data$pred<- predictions$fit
new_data$se<- predictions$se.fit
new_data$upperCI<- new_data$pred+(new_data$se*1.96)
new_data$lowerCI<- new_data$pred-(new_data$se*1.96)

# Making the Plot 
ggplot(new_data, aes(x=Concentration, y=plogis(pred)))+ 
  geom_line(col="black")+
  geom_point(mites, mapping = aes(x=Concentration, y=(Dead_mites/Total)), col="blue")+
  geom_ribbon(aes(ymin=plogis(lowerCI), ymax=plogis(upperCI), alpha=0.2), show.legend = FALSE)+ 
  labs(y="Probability of Infection", x="Concentration")+
  theme_classic()

