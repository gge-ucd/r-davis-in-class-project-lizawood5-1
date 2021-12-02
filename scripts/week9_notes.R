# --------------------------------------
## You do not need to type this code -- this is how we get the live code working 
source('functions/livestreamSetup.R')
livestreamSetup(password = 'vulcans',user = 'rdavis',port = 4040)

# --------------------------------------
library(tidyverse)

# ---- Function-writing ----
## Function = a bundle of operations, typically with arguments to be specified

my_sum <- function(number1, number2){
  the_sum <- number1 + number2
  return(the_sum)
}

my_sum(number1 = 10, number2 = 5)
my_sum(10,5)

# R actually automatically returns the value but not all coding language do
my_sum <- function(number1, number2){
  number1 + number2
}
my_sum(10,5)

## Gapminder data set: Average GDP per capita over a range of years
library(tidyverse)
library(gapminder)

summary(gapminder)

gapminder %>% 
  filter(country == "Canada", year %in% 1970:1980) %>% 
  summarize(avgGDP = mean(gdpPercap, na.rm = T))

avgGDP <- function(cntry, yr.range){
  gapminder %>% 
    filter(country == cntry, year %in% yr.range) %>% 
    summarize(avgGDP = mean(gdpPercap, na.rm = T))
}

avgGDP(cntry = "Iran", yr.range = 1985:1990)
avgGDP(cntry = "Zambia", yr.range = 1900:2020)

# What if I want to do it over and over again, for every country?
unique(gapminder$country)[1:10]

#Often times when we want to iterate, it can't be vectorized
avgGDP(cntry = unique(gapminder$country)[1:10], yr.range = 1985:1990)

# Iterating for for-loops

for(i in 1:10){
  print(i)
}

# But, items within functions are 'pass by' values and don't save to the environment. Often don't even return
# Could start by printing within loops 
for(i in unique(gapminder$country)){
  print(avgGDP(cntry = i, yr.range = 1985:1990))
}

#What if you want it saved? these do not work
output <- for(i in unique(gapminder$country)[1:10]){
  print(avgGDP(i, yr.range = 1985:1990))
}
output

for(i in unique(gapminder$country)[1:10]){
  output <- avgGDP(i, yr.range = 1985:1990)
}
output
i

#the pass by feature means it will only save the object for the last value of i

# Create an empty container outside the loop, and assign it to an indexed value within the loop
output <- list()
for(i in unique(gapminder$country)[1:10]){
  output[i] <- avgGDP(i, yr.range = 1985:1990)
}
output
# What if I want this to look like a data frame?
object <- do.call(rbind, output) # one way to do this -- makes it a matrix, which is less interesting
object <- data.frame(unlist(output)) # another way to do this, which makes it a dataframe

# Could also make this a data frame, but dataframes are more rigid about columns, but this can be useful if
output <- data.frame()
for(i in unique(gapminder$country)[1:10]){
  df <- data.frame(country = i,
                  output = avgGDP(i, yr.range = 1985:1990))
  colnames
  output <- rbind(df, output)
}
output

# function requires 2 arguments, I'm going to make it one for now
avgGDP <- function(cntry){
  gapminder %>% 
    filter(country == cntry, year %in% 1990:2000) %>% 
    summarize(avgGDP = mean(gdpPercap, na.rm = T))
}

sapply(unique(gapminder$country)[1:10], avgGDP)
map_df(unique(gapminder$country)[1:10], avgGDP)

# Write a new function that takes two arguments, the gapminder data.frame (d) and the name of a country (e.g. "Afghanistan"), and plots a time series of the country’s population. That is, the return value from the function should be a ggplot object. 
library(gapminder)

plotPopGrowth <- function(countrytoplot, dat = gapminder) {
  df <- filter(dat, country == countrytoplot) 
  plot <- ggplot(df, aes(year, pop)) + 
    geom_line() +
    labs(title = countrytoplot)
  print(plot) # return does not return these things
}
plotPopGrowth('Canada')

# If we wan to repeat this, maybe we could vectorize it?
plotPopGrowth(unique(gapminder$country)[1:10])

# Iterating for for-loops
for(i in unique(gapminder$country)[1:10]){
  plotPopGrowth(i)
}

# iterating map functions
map(unique(gapminder$country)[1:10], plotPopGrowth)

# iterating with apply
sapply(unique(gapminder$country)[1:10], plotPopGrowth)






