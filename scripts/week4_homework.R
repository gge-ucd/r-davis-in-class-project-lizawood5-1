# --------------------------------------
## You do not need to type this code -- this is how we get the live code working 
source('functions/livestreamSetup.R')
livestreamSetup(password = 'vulcans',user = 'rdavis',port = 4040)

# --------------------------------------

## HOMEWORK FOR WEEK 4 REVIEW ##

# 1. Create a tibble named surveys from the portal_data_joined.csv file.
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

# 2. Subset surveys to keep rows with weight between 30 and 60, and print out the first 6 rows.
filter(surveys, weight > 30 & weight < 60)

# cmd + shift + m to create pipe
surveys %>% filter(weight > 30 & weight < 60)


# How to print all columns of the data frame?
surveys %>% filter(weight > 30 & weight < 60) %>% head()
?head
surveys %>% filter(weight > 30 & weight < 60) %>% head(n = 300,13)
# can always use View() to take a look
View(surveys)
# or check out the column function to see the columns
colnames(surveys)

# 3. Create a new tibble showing the maximum weight for each species + sex combination and name it biggest_critters. Sort the tibble to take a look at the biggest and smallest species + sex combinations. 

biggest_critters <- surveys %>% 
  filter(!is.na(weight) & !is.na(sex) & !is.na(species)) %>% 
  group_by(species, sex) %>% 
  summarize(maximum_weight = max(weight))
biggest_critters

# 4. Try to figure out where the NA weights are concentrated in the data

# what we proposed
surveys %>% 
  filter(is.na(hindfoot_length)) %>% # get all of the NAs in hindfoot
  group_by(species) %>% 
  tally() # generates a column n which is a count

# same as n
surveys %>% 
  filter(is.na(hindfoot_length)) %>% 
  group_by(species) %>% 
  summarize(count = n(), mean = mean(weight, na.rm = T))

# saw use of sum(is.na()) for certain columns
sum(is.na(surveys$weight))

# colSums(is.na())
colSums(is.na(surveys))


# 5. Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight.

# group_by and mutate approach

# group_by and summarize approach. What is different?

# 6. Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).


# Conditional statements

surveys %>% 
  filter(!is.na(weight)) %>% # get rid of NAs
  mutate(weight_cat = case_when(weight > mean(weight) ~ "big", 
                                weight < mean(weight) ~ "small")) %>% # assign column values
  select(weight, weight_cat) %>% # select just take make our viewing better
  tail() # look at the bottom 6

# Using the iris data frame (this is built in to R), create a new variable that categorizes petal length into three groups:
#small (less than or equal to the 1st quartile)
#medium (between the 1st and 3rd quartiles)
#large (greater than or equal to the 3rd quartile)
#Hint: Explore the iris data using summary(iris$Petal.Length), to see the petal #length distribution. Then use your function of choice: ifelse() or case_when() to #make a new variable named petal.length.cat based on the conditions listed above. #Note that in the iris data frame there are no NAs, so we don’t have to deal with #them here.

data(iris)

summary(iris)

iris %>% 
  mutate(length_cat = ifelse(Petal.Length <= 1.6, "small",
                             ifelse(Petal.Length >= 5.1, "large",
                                    "medium")))
# if the first statement is true, small, then go to nested. if nested is true, go to large and if still not true, go to medium

iris %>% 
  mutate(length_cat = case_when(Petal.Length <= 1.6 ~ "small",
                                Petal.Length > 1.6 & Petal.Length < 5.1 ~ "medium",
                                Petal.Length >= 5.1 ~ "large"))





