#!/usr/bin/env Rscript
# Author: Sebastian Dohne <sed24@ic.ac.uk>

require(usdm)
require(psych)
require(lmerTest)
require(sjPlot)
parkgrass <- read.csv("../data/parkgrass_ms.csv")
str(parkgrass)

pairs.panels(parkgrass[,-c(1,10,11,12,13)]) #omitting columns 1, 10, 11, 12, and 13
#he pairs plot gives a good indication of the associations between the variables. There are
# strong correlations between: CWM.SLA and CWM.Leaf.Thickness; CWM.Seed.Mass and CWM.Leaf.N and CWM.C.N

##########VARIANCE INFLATION FACTOR ###############
#we are going to sequentially remove the variable with the highest VIF until we reach the threshold of 3

vif(parkgrass[,-c(1,10,11,12,13)]) # let's remove CWM.Leaf.Thickness and recalculate VIF
vif(parkgrass[,-c(1,6,10,11,12,13)]) # let's remove CWM.Leaf.N
vif(parkgrass[,-c(1,6,7,10,11,12,13)]) # let's remove CWM.Leaf.C.N
vif(parkgrass[,-c(1,6,7,8,10,11,12,13)]) # let's remove CWM.Plant.Height
vif(parkgrass[,-c(1,2,6,7,8,10,11,12,13)]) # # ok so all of our variable now have VIFs under 3! This is our final set of continuous covariates.

#We have reduced down our variables using VIF and have our final variables to fit:

# Variance Inflation Factor (VIF): A measure used to detect multicollinearity 
# among predictor variables in a regression model. High VIF values indicate 
# that a predictor is highly correlated with other predictors, which can 
# inflate the standard errors of the coefficients and make the model unstable.


#Biodiversity measures: community-weighted means of leaf dry matter content, specific
#leaf area and seed mass; and species richness.

#Environmental measures: ammonium sulphate addition (0=nil, 1=low and 2=high),
#sodium nitrate addition (0=nil, 1=low, 2=medium, 3=high), mineral fertiliser addition
#(e.g. potassium, sodium etc.; 0=no, 1=yes), pH.

#WE WILL NOW DO THE FOLLOWING STEPS: 
#FIT MODEL AND INTERPRET REGARDLESS
#FIT MAXIMAL MODEL AND IMPLEMENT HYPOTHEISS TESTING AND INFORMATION CRITERIA APPROACHES
#CONTRUCT A RANGE OF MODELS AND ANALYSE VIA THE INFORMATION THEORETIC APPROACH


#when we have multiple continous explanatory variables on different scales it is best practice to z standardise them (this is what scale is used for). 
M1<- lm(Harvest~scale(CWM.LDMC)+scale(CWM.SLA)+scale(CWM.Seed.Mass)
        +scale(SpRich)+factor(Ammonium)+factor(Nitrate)+factor(Minerals)
        +scale(pH), data = parkgrass)

#the additive model assesses the independent effect of each predictor on harvest, assuming no interaction between predictors (it looks at how each variable influences harvest while holding other variables constant)
#If a larger sample size were available, it would be more feasible to explore a more complex model that includes interaction terms.
#something like this: M2 <- lm(Harvest ~ scale(CWM.LDMC) * scale(CWM.SLA) + scale(SpRich) * scale(pH) +
#                     factor(Ammonium) * factor(Minerals), data = parkgrass)


anova(M1)
# ANOVA Summary: Significant variables affecting Harvest (ranked by sum of squares, indicating 
# their importance in explaining variation in Harvest) are: 
# 1. CWM.Seed.Mass
# 2. SpRich
# 3. CWM.LDMC
# 4. Minerals
# 5. Ammonium

# Interpretation: Botanical composition variables (e.g., CWM.Seed.Mass, SpRich, CWM.LDMC) 
# have a greater impact on Harvest compared to environmental factors (e.g., Minerals, Ammonium).


