mtcars
setwd("~/Desktop/R_DAVIS_2021/r-davis-in-class-project-lizawood5-1")
df <- read.csv("data/portal_data_joined.csv")

# Scale the weight of our rodents:
## Take the weight, minus the min, divded by the total differeny
(df$weight - min(df$weight, na.rm = T))/
  (max(df$weight, na.rm = T) - min(df$weight, na.rm = T))

# Great, we can make a new, scaled column
df$weight_scaled <- (df$weight - min(df$weight, na.rm = T))/
  (max(df$weight, na.rm = T) - min(df$weight, na.rm = T))

# Instead of pasting this over and and over with different column values, we can make a function and then iterate. Replace the column with a generic object name like x

x_scaled <- (x - min(x, na.rm = T)) /
  diff(range(x, na.rm = T))

# Make make this a function
rescale <- function(x) {
  (x - min(x, na.rm = T)) /
    diff(range(x, na.rm = T))
}

rescale(df$weight)
rescale(df$hindfoot_length)

# iterating with map functions
library(purrr)
library(tidyverse)
df %>% map_df(select(weight, hindfoot_length), rescale)




