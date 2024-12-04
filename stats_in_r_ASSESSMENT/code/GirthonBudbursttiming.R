set.seed(1234)

#############################REFIT MODEL WITH ADJUSTED TREE IDS WHERE TREES ARE NOT SINGLE




#########requirements################

require(ggplot2)
library(lme4)
require(ggeffects)
library(car)
require(usdm)
require(psych)
require(lmerTest)
require(sjPlot)


################
budburst <-read.csv("../data/girthandbudburst.csv")
budburst <-read.csv("../data/stratifiedgirthdata.csv")

#pairs.panels(budburst[,c(1,7,8,12)])
#vif(budburst[,c(1,7,8,12)])



####lets check if julian days is normally distributed

hist(budburst$JulianDay, breaks = 50)
qqnorm(budburst$JulianDay) ###qq plot suggests normality to me 


####plotting a linear model

# Updated GLM model with Location added as a predictor
glm_model <- glm(JulianDay ~ Girth_cm + factor(Period) + factor(SPlocation), 
                 data = budburst,
                 family = poisson(link = "log"))


summary(glm_model)


# Fit a mixed-effects model  (TREEID REMOVED AS A RANDOM EFFECT AS NOT ENOUGH SAMPLES FOR VARIABILITY)
mixed_model <- lmer(JulianDay ~ Girth_cm + factor(Period) + (1 | SPlocation), 
                    data = budburst)
summary(mixed_model)


########Model assumptions
plot_model(mixed_model, type = "est", show.values = TRUE, show.p = TRUE)

plot_model(mixed_model, type = "re")


########check for overdispersion

#dispersion is residual deviance divided by DF 
#it is underdispersed but not enough for us to need to use a quasi-Poisson


# Key Assumptions for a Poisson GLM:

# 1. Informal check : Response Variable: Count data (non-negative integers) with mean ≈ variance.
# 2. Link Function: Correctly specified (usually "log" for Poisson GLMs).
# 3. Independence: Observations should be independent (check study design).
# 4. Linearity: Predictors should have a linear relationship with the log of the expected response.
# 5. Dispersion: Variance should be close to the mean (check residual deviance / degrees of freedom ≈ 1).
#    - Use a quasi-Poisson model if dispersion is significantly off.
# 6. Homoscedasticity: Residuals should have constant variance (check Scale-Location Plot).
# 7. Influential Points: Check Residuals vs Leverage Plot for high-leverage observations.

# Use diagnostic plots and tests to assess these assumptions.

#########VIF score 

car::vif(mixed_model)
# Girth_cm factor(Period) 
#1.007196       1.007205 

#no multicolinnearity between girth and period


#######plots


ggplot(budburst, aes(x = Girth_cm, y = JulianDay)) +
  geom_jitter(width = 0.2, height = 0, aes(color = as.factor(Period))) +  # Adds jitter and colors each year differently
  geom_smooth(method = "lm", color = "RED", se = FALSE) +
  labs(x = "Budburst Day", y = "Girth(Cm)", title = "Budburst Day vs. Girth", color = "Year") +
  scale_y_continuous(limits = c(50, 150)) +
  theme_minimal()
######Making a boxplot to see difference within years
boxplot_plot<- ggplot(budburst, aes(x= Period, y=JulianDay, group = Period)) +
  geom_boxplot()+
  theme_classic()+
  labs(x="Period", y="JulianDays")
boxplot_plot


boxplot#plotting a graph with SE lines comparing julian days, girth and years(Could sub year into this?)

predictions <- ggpredict(glm_model, terms = c("Girth_cm", "Period"))

ggplot(predictions, aes(x = x, y = predicted, color = group)) +  # Map x and predicted values, and color by group (Year)
  geom_line() +  # Add lines to show predicted values for each year
  geom_point(data = predictions, aes(x = x, y = predicted), alpha = 0.5) +  # Add semi-transparent points for clarity
  geom_smooth(method = "loess", se = FALSE) +  # Add a LOESS smoothing line without a confidence interval
  theme_minimal() +  # Use a minimal theme for a cleaner look
  labs(x = "Girth (cm)", y = "Predicted Julian Day", title = "Predicted counts of JulianDay") +  # Add labels and title
  scale_color_viridis_d()  # Use a colorblind-friendly color palette

plot(ggpredict(glm_model, terms=c("Girth_cm", "Period")), show_data=T) #what the fuck is this
plot(ggpredict(mixed_model, terms = c("Girth_cm", "Period")), show_data = TRUE)

#######find a way to get points on there in a non overwhelming way, go through the model validation worksheet and see If I'm missing anything
