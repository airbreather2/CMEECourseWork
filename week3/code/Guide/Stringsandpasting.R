#manipulating strings for effective data handling

species.name <- "Quercus robur" #You can alo use single quotes
species.name

#'Quercus robur'

paste("Quercus", "robur")

paste("Quercus", "robur",sep = "") #Get rid of space
#'Quercusrobur'

paste("Quercus", "robur",sep = ", ") #insert comma to separate
#'Quercus, robur'


paste('Year is:', 1990:2000)
# pastes 'the year is: 1990 to 2000' in succession

#Functions for strings

strsplit(x,';')

#Split the string x at ‘;’

nchar(x)

#Number of characters in string x

toupper(x)

#Set string x to upper case

tolower(x)

#Set string x to lower case

paste(x1,x2,sep=';')

#Join the two strings using ‘;’

