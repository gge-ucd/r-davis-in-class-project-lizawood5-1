# --------------------------------------
## You do not need to type this code -- this is how we get the live code working 
source('functions/livestreamSetup.R')
livestreamSetup(password = 'vulcans',user = 'rdavis',port = 4040)
# --------------------------------------
## HOMEWORK FOR WEEK 2 REVIEW ##

set.seed(15)
?set.seed()
hw2 <- runif(50, 4, 50)
?runif
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2

# -- Remove the NAs 
## NAs are a special value in R and don't behave like other data types (e.g. character)
hw2[hw2 != NA]
hw2[hw2 != "NA"]

## important functions: na.omit(), is.na(), complete.cases()
prob1 <- hw2[!is.na(hw2)]


# -- Select all the numbers between 14 and 38 inclusive, call this vector prob1.
## subsetting with [] and use of subsetting symbols
prob1 <- prob1[prob1 >= 14 & prob1 <= 38] #AND does not work
prob1

## Some used which() function in here


## you could do it all at once, nest functons



# -- Multiply each number in the prob1 vector by 3 to create a new vector called times3.
## vector math

times3 <- prob1 * 3
times3

# -- Then add 10 to each number in your times3 vector to create a new vector called plus10
## more vector math

plus10 <- times3 + 10


# -- Select every other number in your plus10 vector by selecting the first number, not the second, the third, not the fourth, etc. 
## Various approaches: manual, logical with vector recycling, seq(), 

?seq
length(plus10)
odds <- seq(from = 1, to = 23, by = 2)
odds
final <- plus10[odds]
final

# Making code "better"/more robust (aka. soft-coding)

seq(from = 1, to = length(plus10), by = 2)
# these 2 are the same, because you don't always need to sepcify arguments
seq(1,23,2)
# soft-coded version without specifying arguments
seq(1, length(plus10), 2)

# vector recycling
plus10[c(TRUE, FALSE)]

# NAs?
hw2[c(T, F)]

# tab completion
mean()


# hard-coded long form version
arg_from <- 1
arg_to <- 100
arg_by <- 5


seq(arg_from, arg_to, arg_by)



# -- Misc notes:
## objects go on the left side of the assignment arrow (e.g. new_object <- )
## objects do not need to be put into quotations -- it doesn't make an error but it isn't necessary and is a little confusing
## No need to concatenate in vector math
## Don't need to put results into homework


# Reading in spreadsheets

surveys <- read.csv("data/portal_data_joined.csv")

# look at first 6 rows
head(surveys)
# how to look at more or fewer rows?
head(surveys, n=1)

# look at the structure of the data
str(surveys)

summary(surveys)

# subsetting from a data frame
surveys[1,2] # row 1 and column 2

# unique
surveys$species
unique(surveys$species)
# nest functions
length(unique(surveys$species))
# table is great
table(surveys$species)

# reverse unique, so something that is not duplicated, then sum it (personally i think this is confusing)
sum(!duplicated(surveys$species))

# levels as a way to identifying unique character factors, but this does not work for just characters
# starting with characters is good
levels(surveys$species)

?factor()

# converting to factor
species_factor <- factor(surveys$species)
# it is kind of like a number
typeof(species_factor)
# but also it is a character
class(species_factor)
# levels usually default to alphabetical order
levels(species_factor)


# Challenges with subsetting

surveys_200 <- surveys[200,]
surveys_200

# duplicate head
surveyshead <- surveys[-(7:nrow(surveys)),]
surveyshead


