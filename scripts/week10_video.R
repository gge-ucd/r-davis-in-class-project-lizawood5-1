# ---- Iteration
## 1. Walk through 'for loops'
## 2. Walk through map functions
## 3. In class: apply and practice why these can be so powerful

# ---- Remembering square brackets and data types
head(iris)
head(mtcars)

iris[1]
iris[[1]]
iris$Sepal.Length
iris[,1]
iris[1,1]
iris$Sepal.Length[1]

# ---- For loops

for(i in 1:10){
  print(i)
}

i

for(i in 1:10){
  print(iris$Sepal.Length[i])
}
head(iris$Sepal.Length, n = 10)

for(i in 1:10){
  print(iris$Sepal.Length[i])
  print(mtcars$mpg[i])
}

# store output
results <- rep(NA, nrow(mtcars))
results

for(i in 1:nrow(mtcars)){
  results[i] <- mtcars$wt[i]*100
}
results
mtcars$wt









# ---- Map family of functions
## map takes an input and a function argument
library(tidyverse)
head(iris)
map(iris, mean)
map_df(iris, mean)
map_df(iris[1:4], mean)

## Mapping with 2 arguments with a pre-written function
mtcars
print_mpg <- function(x, y){
  paste(x, "gets", y, "miles per gallon")
}

map2_chr(rownames(mtcars), mtcars$mpg, print_mpg)

## Mapping with 2 arguments with an embedded "anonymous" function

map2_chr(rownames(mtcars), mtcars$mpg, function(x,y) paste(x, "gets", y, "miles per gallon"))







# ---- Full worked example
# 1. Scale a single number


# 2. Scale a whole vector


# 3. Make it into a function so that we can scale any column


# 4. Iterate to scale on all the columns

