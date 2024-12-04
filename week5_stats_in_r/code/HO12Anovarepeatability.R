
######UNFINSIHED HANDOUT, THERE IS STILL MORE TO DO ############

rm(list=ls())
require(ggplot2)
d<-read.table("../data/SparrowSize.txt", header=TRUE)
########Anovas (Analysis of variance) ############
#Anovas test for differences in variance that requires: 

#A continous response
#a categorical predictor (explanatory variable)

# ANOVAs test for differencs in variances,
# between and within groups (the groups are determined by the levels of the factor)
# ANOVA actually analyzes the variances between and within these groups to see if the observed group means differ more than would be expected by chance

d1<-subset(d, d$Wing!="NA")
summary(d1$Wing)
hist(d1$Wing)
#outliers seem to come from missing or young birds, lets leave them in for now

model1<-lm(Wing~Sex.1,data=d1)

summary(model1)
#intercept is when wing is left at reference level, eg female (0), slop is the increase in length that males have which is statistically significant


boxplot(d1$Wing~d1$Sex.1, ylab="Wing length (mm)")
anova(model1)
#For Sex.1: 2722.0 — This is the total variation in Wing length explained by differences in sex.
#For Residuals: 7165.3 — This is the remaining variation in Wing length that is not explained by sex.
#For Sex.1: 2721.98 — This is the average variance explained by sex.
#For Residuals: 4.23 — This is the average unexplained variance within each group.
#F value: 643.15 — This tests if the variation explained by sex is significantly larger than the unexplained variation. A high value suggests a strong effect of sex on Wing length.
#Pr(>F): < 2.2e-16 — This very small p-value means the effect of sex on Wing length is statistically significant.

#sex has a significant effect on wing length, explaining some variation, but there is a lot of variability within each group (males and females)

##########post hoc test ##########
#we now do a t test to find out exactly how much wing length does differ between the two sexes
#is run after the main analysis and can check which group differs and how much
#since ANOVA assumed groups have similar variances (homogeneity) if ANOVA results are valid, we can generally assume variances are equal.
#ANOVA is fairly robust to small deviations in variance equality, especially with large sample sizes. In this case, since the ANOVA found a significant effect and the test was robust, it suggests the assumption of equal variances holds reasonably well for further analysis.

t.test(d1$Wing~d1$Sex.1, var.equal=TRUE)
#statistically significant difference in wing length between male and females (p-value < 2.2e-16).
# Mean Difference: The mean Wing length is 76.1 mm for females and 78.6 mm for males
# Confidence Interval: The true difference in means is estimated to be between -2.73 and -2.34 mm, indicating that males have a slightly longer average Wing length than females.


########testing multiple groups###########
#lets test differences between years


boxplot(d$Mass~d$Year)
m2<-lm(Mass~as.factor(Year),data=d)
anova(m2)
summary(m2)
#only gives is the difference between every year and the reference year (2000) and not between years

?TukeyHSD 
?aov

am2<-aov(Mass~as.factor(Year),data=d)
summary(am2)
#RETURNS THE SAME INFO A THE ABOVE LM CALL

TukeyHSD(am2)
#creates a complete table, with all combinations and if there are significant differences
#probability of false positives increases when running so many tests, Tukey HSD accounts for this, but adjusting p values



######FINSIHED HANDOUT HERE, THERE IS STILL MORE TO DO ############