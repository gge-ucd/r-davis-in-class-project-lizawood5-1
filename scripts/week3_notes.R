# Goals:
## Using the read.csv() function to read in data
## Expore and subset dataframes
## Packages and base R vs the tidyverse

# Reading in data
surveys <- read.csv("data/portal_data_joined.csv")

# Inspecting the data
nrow(surveys)
ncol(surveys)

# What kind of data is surveys
class(surveys)

# Look at the top or bottom entries
head(surveys)
tail(surveys)

# Look at the data in its entirety
View(surveys)

# More about the data
str(surveys)
summary(surveys)


# Indexing
## Inside the brackets, it [row, column]

surveys[1,1]
surveys[1,6]
# Extracts a vector
surveys[,6]
# Maintains the data.frame
surveys[6]
# Check my work
class(surveys[,6])
class(surveys[6])


# Special signs for subsetting: colon (:) presents a range, and negative sign (-) subtracts

surveys[1:6,]
surveys[-(1:6),]
surveys[-1,]

# Subsetting with column name
## Output is a data.frame
surveys["species_id"]
colnames(surveys)
## Output is a vector
surveys[,"species_id"]
## Preferred subset -- gives us a vector
surveys$species_id


# Loading the tidyverse
#install.packages("tidyverse")

# load a package into a session (do this each time)
library(tidyverse)

surveys_t <- read_csv("data/portal_data_joined.csv")
# This is a tibble
surveys_t
# This is a data.frame
surveys

# Inspections
class(surveys_t)

# Subsetting is a little different
surveys[,1] ## Gives us a vector
surveys_t[,1] ## Gives us a tibble













