#Effect of girth on Budburst? dataset creation 

#create a dataframe by quercus.robur, tree ID (random effect), location (random effect), (year fixed)-convert to julian date? , bud burst (only get values that are 2 or less than 2, definitive bud burst has occured)

#step 1: select species to compare: check which has the highest sample size (trees.csv), make a dataframe with Tree ID, location as a random effect? tree ID  
#step 2: step 2 dataset phenology: budburst score (convert all scores to 2), date,
#step 3 get girth column, remove columns except year, tree id and dates
#step 3: merge by tree ID, remove all other species, remove all scores that aren't 2 or less than 2, convert date julian days, fixed effect is year
########################Libraries required ######################################################

require(dplyr)
library(sqldf)
########################DATA WRANGLING TO GET FINAL DATASET #######################################

#READING IN DATA
girth<- read.csv("../data/girth.csv")
phenology <-read.csv("../data/phenology.csv")
weather<- read.csv("../data/SilwoodWeatherDaily.csv")
trees <- read.csv("../data/trees.csv")

head(trees)
head(phenology)

str(phenology)
str(trees)

########################setting seed
# Start your script by setting the seed for reproducability 
set.seed(12346)  # Replace 123 with your chosen seed number

##########################

######REMOVING UNNECCESARY COLUMNS
trees1 <- trees[, -c(3, 4, 5, 6, 8)]
phenology1 <- phenology[, -c(1, 5)]
girth1 <- girth[, -c(2, 4, 5, 6)]
str(phenology1)
str(trees1)
str(girth1)

##########Renaming column header to date range in girth dataset to avoid confusion

names(girth1)[names(girth1) == "Date"] <- "DateRange"


##########merging data
merge1 <- merge(x= trees1, y= phenology1, by = "TreeID") 


########### REFINING DATA, REMOVING NAs and such
merge1 <- merge(x= trees1, y= phenology1, by = "TreeID") 
merge1noNAs <- merge1[complete.cases(merge1), ] #remove any rows With NAs
merge1noNAs$Score <- gsub("<", "", merge1noNAs$Score) #remove less than symbols
filtered_data <- merge1 %>% filter(Score %in% c("<2", "2")) #filter out all scores apart from <2 and 2 
filtered_data$Score <- gsub("<", "", filtered_data$Score) #remove less than symbols
#filtered_data <- as.factor(filtered_data$Score) 
str(filtered_data)

###Order years in Julian order, but seperated by years?, julian days on y axis, year on x ,compare tree ID and Location as random effects? 
filtered_data$Date <- as.Date(filtered_data$Date, format = "%d/%m/%Y") 
filtered_data$Year <- format(filtered_data$Date, "%Y")
filtered_data$JulianDay <- as.numeric(format(filtered_data$Date, "%j"))

###### count species and select most frequent one

species_count <- table(filtered_data$species)
species_count ###lmao select for quercus.robur
Q.R_filtered_data <- filtered_data %>% filter(species %in% c("quercus.robur"))
species_count <- table(Q.R_filtered_data$species)
species_count ###lmao select for quercus.robur

###############remove repeats of years in Tree ID and select the earlier budbursts if there are any ####################

finaldata <- Q.R_filtered_data %>%
  group_by(Year, TreeID) %>%  # Group by Year and TreeID
  filter(JulianDay == min(JulianDay)) %>%  # Keep only the row(s) with the lowest Julian Day
  ungroup()  # Ungroup after filtering

############## merge this data with girth data and have girth fall into year


# Extract start and end years from DateRange in girth1 and copy girth cm rows for each value which falls into range
girth1 <- girth1 %>%
  mutate(Start_Year = as.numeric(sub(".*?(\\d{4})-.*", "\\1", DateRange)),
         End_Year = as.numeric(sub(".*-(\\d{4}).*", "\\1", DateRange)))
girth1noNAs <- girth1[complete.cases(girth1), ] #remove NAS



##############merging this data togetehr by the year rnages

girthtreesandphenology <- finaldata %>%
  left_join(girth1noNAs, by = "TreeID") %>%
  filter(Year >= Start_Year & Year <= End_Year)


#######ADD another row called period relating to the date ranges for tree girth and coverting this to categorical 

girthtreesandphenology$Period <- ifelse(girthtreesandphenology$Start_Year >= 2007 & girthtreesandphenology$End_Year <= 2015, 1, 2) #assigns 1 if assumption is met, 2 if not
girthtreesandphenology$Period <- as.factor(girthtreesandphenology$Period)

str(girthtreesandphenology)

############ Sample one observation per Tree ID within each period
sampled_data <- girthtreesandphenology %>%
  group_by(TreeID, Period) %>%
  sample_n(size = 1) %>%
  ungroup()





sort(unique(girthtreesandphenology$Year)) #ALL THE YEARS ARE THERE
length(unique(sampled_data$TreeID))



##############################MAKE IT SO THE DATA HAS NO SINGLE POINTS FOR YEARS 

