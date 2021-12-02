# ---- Function-writing ----
## Functions are operations we run in R, usually specified with one or more arguments
?log

## A summing function, with no built-in arguments

2+3

my_sum <- function(number1, number2){
  the_sum <- number1 + number2
  return(the_sum)
}

my_sum(number1 = 10, number2 = 5)
my_sum(10,5)


## A summing function again, but with default values for arguments

my_sum2 <- function(number1 = 5, number2 = 10){
  the_sum <- number1 + number2
  return(the_sum)
}

my_sum2()
my_sum2(number1 = 10)


## Temperature conversion

F_to_K <- function(tempF){
  K <- ((tempF - 32) * (5/9)) + 273.15
  return(K)
}

F_to_K(32)


## Gapmind data set: Average GDP per capita over a range of years
library(tidyverse)
library(gapminder)

summary(gapminder)

gapminder %>% 
  filter(country == "Canada", year %in% 1970:1980) %>% 
  summarize(mean(gdpPercap, na.rm = T))

avgGDP <- function(cntry, yr.range){
  gapminder %>% 
    filter(country == cntry, year %in% yr.range) %>% 
    summarize(mean(gdpPercap, na.rm = T))
}

avgGDP(cntry = "Iran", yr.range = 1985:1990)
avgGDP(cntry = "Zambia", yr.range = 1900:2020)





