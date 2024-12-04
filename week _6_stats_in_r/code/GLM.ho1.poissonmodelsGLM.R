require(ggplot2)
require(MASS)
require(ggpubr)
fish<- read.csv("../data/fisheries.csv", stringsAsFactors = T)
str(fish)

#for our first check lets see if total abundance changes with mean depth of water column
ggplot(fish, aes(x=MeanDepth, y=TotAbund))+ geom_point()+ labs(x= "Mean Depth (km)", y="Total Abundance")+ theme_classic()
hist(fish$MeanDepth)

#Our basic model consists of total abundance as our response variable and mean depth as our explanatory variable. With the basic model equation
M1<- glm(TotAbund~MeanDepth, data = fish, family = "poisson")
summary(M1)
#chatgpt the output for a breakdown of the summary,  essentially depth has a strong association with abundance

######Initial Interpretation ############

#From this summary we can build our initial model equation and infer that as mean depth increases the total abundance of fish decreases. We can also calculate the Pseudo-R^2.

#ln(TotAbund) = 6.64 -0.63*Meandepth
#PseudoR^2= 1- (15770/27779) =0.43

###### Model Validation ###########

par(mfrow=c(2,2)) 
plot(M1)

#Std Pearson resid Vs leverage plot highligts we potentially have a large number of outliers, lets explore these
#A cooks distance of more than 1 is considered to be an outlier so lets see how many we have

sum(cooks.distance(M1)>1)
## [1] 29
# since we have quite a lot of outliers we can just look into it and drop is so lets leave it alone for now
#the model is overdispersed: Overdispersion occurs when the observed variance in the response variable is greater than what the model expects based on the assumed distribution
mean(fish$TotAbund)
var(fish$TotAbund) #
# dispersion_parameter <- residual deviance / df_residual
# Residual deviance: 15770  on 144  degrees of freedom
#Dispersion parameter = 15770/144 =109.5
####Explations of overdispersion could be: (outside of outliers) ######
#transformation of covariates
#missing covariates
#zero inflation
#inherent dependency potentially (could explore random effect of the year)


####A possible avenue to explore from these options would be including additional covariates and/or fixed factors. We could fit “Year” as a fixed-factor but there are 13 levels and we would lose far too many degrees of freedom, thus statistical power, or we could fit “Period” as a fixed factor, but let’s explore this first through plotting.

scatterplot<-ggplot(fish, aes(x=MeanDepth, y=TotAbund, color=factor(Period)))+
  geom_point()+
  labs(x= "Mean Depth (km)", y="Total Abundance")+
  theme_classic()+
  scale_color_discrete(name="Period", labels=c("1979-1989", "1997-2002"))
boxplot<- ggplot(fish, aes(x=factor(Period, labels=c("1979-1989", "1997-2002")), y=TotAbund))+
  geom_boxplot()+
  theme_classic()+
  labs(x="Period", y="Total Abundance")
ggarrange(scatterplot, boxplot, labels=c("A","B"), ncol=1, nrow=2)

#as we can see, period can affect abundance and thus affect the relationship and dispersion parameter

####Adding period as a Fixed Factor ######
fish$Period<- factor(fish$Period)
M2<- glm(TotAbund~MeanDepth*Period, data = fish, family="poisson")
summary(M2) # -0.66 + 0.12
anova(M2, test="Chisq")
#The interaction term, MeanDepth
#, is also significant (p = 1.713e-14), suggesting that the relationship between MeanDepth and the response variable depends on Period.
#period does have a significant effect on the abundance at differing depths

#we can now write two linear equations
#Period2:ln(TotAbund)= ((6.83 - 0.67)-<-M1 + (-0.66 +0.12)) * MeanDepth = 6.16 -0.51 *MeanDepth

#Lets look at the dispersion parameter
#14293/142 =100.65

#as our model is still overdispersed we will fit a quasi-possion model or negative binomial model


####Fitting a negative binomial #######
M3<- glm.nb(TotAbund~MeanDepth*Period, data = fish)
summary(M3)
anova(M3, test = "Chisq")   
#fitting a negative binomial has changed our model output significantly,
#the biggest difference is the change in significance of the model term: MeanDepth:factor(Period)2 suggesting no difference between slopes of each period, but a dig difference between intercepts
#we will run a reduced model (without the interaction)

M4<- glm.nb(TotAbund~MeanDepth+Period, data = fish)
summary(M4)
anova(M4, test = "Chisq")
#dispersion parameter is 158/142=11 
par(mfrow=c(2,2)) #partitioning the plot window into a 2X2
plot(M4)

#########negative Biomial Interpretation ###########
#So finally we have the model we can interpret that has two linear equations with different intercepts but the same slope of MeanDepth.
#Period2: ln(TotAbund) = (6.96 - 0.39) - 0.73*MeanDepth 
# We can therefore interpret that “for every kilometer increase in mean depth total abundance decreased by a factor of e^-0.73 or 0.48-fold”. But what does this mean? Let’s look at the exponentiated coefficients for Period 1.

#The last concept to think about is the pseudo-R^2 for our negative binomial model, which is: PSEUDO R^2 = 1-(158.23/334.13)=0.53 ,residual divided by null deviance

######PLOTTING THE NEGATIVE BINOMIAL MODEL #########
range(fish$MeanDepth) #Find the range of Depth

period1 <- data.frame(MeanDepth=seq(from=0.804, to=4.865, length=100), Period="1")
period2 <- data.frame(MeanDepth=seq(from=0.804, to=4.865, length=100), Period="2")
period1_predictions<- predict(M4, newdata = period1, type = "link", se.fit = TRUE) # the type="link" here predicted the fit and se on the log-linear scale. 
period2_predictions<- predict(M4, newdata = period2, type = "link", se.fit = TRUE)
period1$pred<- period1_predictions$fit
period1$se<- period1_predictions$se.fit
period1$upperCI<- period1$pred+(period1$se*1.96)
period1$lowerCI<- period1$pred-(period1$se*1.96)
period2$pred<- period2_predictions$fit
period2$se<- period2_predictions$se.fit
period2$upperCI<- period2$pred+(period2$se*1.96)
period2$lowerCI<- period2$pred-(period2$se*1.96)
complete<- rbind(period1, period2)

# Making the Plot 
ggplot(complete, aes(x=MeanDepth, y=exp(pred)))+ 
  geom_line(aes(color=factor(Period)))+
  geom_ribbon(aes(ymin=exp(lowerCI), ymax=exp(upperCI), fill=factor(Period), alpha=0.3), show.legend = FALSE)+ 
  geom_point(fish, mapping = aes(x=MeanDepth, y=TotAbund, color=factor(Period)))+
  labs(y="Total Abundance", x="Mean Depth (km)")+
  theme_classic()+
  scale_color_discrete(name="Period", labels=c("1979-1989", "1997-2002"))

#for a simpler way of plotting
require(ggeffects)
plot(ggpredict(M4, terms=c("MeanDepth", "Period")), show_data=T)


########FINISH LAST SECTION WITH MITES ###############
#how does increasing concentration of aracides impact number of dead mites
#irregardless of aracide how does increasing the conentration impact number of dead mites

#fitting poisson model
mites<- read.csv("../data/bee_mites.csv")
head(mites)
mites_m1<- glm(Dead_mites~Concentration, data = mites, family = "poisson")
summary(mites_m1)

# Summary of Poisson Regression Model for Dead_mites ~ Concentration

# Model Call:
# This model investigates the relationship between 'Dead_mites' and 'Concentration'
# using a Poisson regression. 'Dead_mites' is the count response variable, and
# 'Concentration' is the predictor, which may represent acaricide levels.

# Coefficients:
# (Intercept): 0.52820 (Estimate) - This is the log-expected count of dead mites
# when Concentration is zero. A positive intercept suggests a baseline count of
# dead mites even when no concentration of acaricide is applied.
#
# Concentration: 0.57181 (Estimate) - For each one-unit increase in Concentration,
# the log count of dead mites increases by approximately 0.57. This suggests a
# positive association between concentration and dead mites, implying higher
# concentrations result in more dead mites.

# Statistical Significance:
# Both the intercept and concentration have highly significant p-values (Pr(>|z|) < 0.001),
# indicated by the '***' symbol. This implies that both terms in the model are
# statistically significant predictors of dead mite counts.

# Model Deviance:
# Null Deviance (154.79 on 114 df) - Deviance of a model without any predictors.
# Residual Deviance (109.25 on 113 df) - Deviance of the model with Concentration
# included. The decrease in deviance from the null model to the fitted model
# suggests that Concentration improves model fit.

# AIC (Akaike Information Criterion):
# AIC = 398.71 - The AIC value provides a measure of model quality, balancing
# model fit and complexity. Lower AIC values are preferred when comparing
# multiple models for the same data.

# Convergence:
# Number of Fisher Scoring iterations: 5 - The model converged after 5 iterations,
# indicating that the optimization algorithm successfully found parameter estimates.

# Overall Interpretation:
# The positive and significant effect of Concentration suggests that higher
# concentrations of the substance are associated with increased dead mite counts.
# This model provides evidence that acaricide concentration impacts mite mortality.

anova(mites_m1, test = "Chisq")

# ANOVA Analysis of Deviance Table for Poisson Model

# Model evaluates the effect of 'Concentration' on 'Dead_mites' using a Poisson distribution.

# NULL Model: Deviance = 154.79 (114 df) - Baseline model without predictors.
# Adding Concentration: Deviance reduction = 45.535 (1 df), Residual Deviance = 109.25 (113 df),
# p-value < 0.001, indicating a significant improvement in model fit with Concentration included.

# Conclusion: 'Concentration' significantly contributes to explaining the variability in dead mite counts.

########### Model Interpretation:    #############
# The equation for Dead_mites is:
# ln(Number of Dead Mites) = 0.53 + 0.57 * Concentration
# Number of Dead Mites = exp(0.53 + 0.57 * Concentration)
# Interpretation: Each 1 g/L increase in acaricide concentration raises the expected number of dead mites 
# by a factor of exp(0.57) ≈ 1.77.
# Pseudo-R^2 = 1 - (109.25 / 154.79) ≈ 0.29, suggesting the model explains about 29% of the variation 
# in the number of dead mites.

###########Model Validation ################
# dispersion_parameter <- residual deviance / df_residual
#109.25/113 = 0.97    this is close to 1 and can conclude dispersion is NOT an issue for out model

par(mfrow=c(2,2)) #partitioning the plot window into a 2X2
plot(mites_m1)
# Diagnostic Issues Summary:
# - "Residuals vs Fitted" and "Scale-Location" plots indicate heteroscedasticity, shown by patterning and curvature in the red spline.
# - Likely cause: inappropriate model family (Poisson) chosen due to variation in total mites across trials.
# - Since total mites vary, data may not strictly follow a Poisson distribution, as it's constrained by total counts.
# - Lesson: R does not verify model assumptions; validation requires understanding experimental design, data collection, and data distributions.
# - would need to Reanalyze using a binomial family to compare results with the Poisson model.


########Plotting the model ##############
range(mites$Concentration) # Finding the range of concentration
## [1] 0.00 2.16
new_data <- data.frame(Concentration=seq(from=0, to=2.16, length=100))
predictions<- predict(mites_m1, newdata = new_data, type = "link", se.fit = TRUE) # the type="link" here predicted the fit and se on the log-linear scale. 
new_data$pred<- predictions$fit
new_data$se<- predictions$se.fit
new_data$upperCI<- new_data$pred+(new_data$se*1.96)
new_data$lowerCI<- new_data$pred-(new_data$se*1.96)

# Making the Plot 

#below we will plot the Poisson model

ggplot(new_data, aes(x=Concentration, y=exp(pred)))+ 
  geom_line(col="black")+
  geom_ribbon(aes(ymin=exp(lowerCI), ymax=exp(upperCI), alpha=0.1), show.legend = FALSE, fill="grey")+ 
  geom_point(mites, mapping = aes(x=Concentration, y=Dead_mites), col="blue")+
  labs(y="Number of Dead Mites", x="Concentration (g/l)")+
  theme_classic()

