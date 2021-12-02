
# ---- HOMEWORK ----
## Data import
library(tidyverse)
library(lubridate)

mloa <- read_csv("https://raw.githubusercontent.com/gge-ucd/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

mloa2 <- mloa %>%
  # Remove NA's
  filter(rel_humid != -99) %>%
  filter(temp_C_2m != -999.9) %>%
  filter(windSpeed_m_s != -999.9) %>%
  # Create datetime column (README indicates time is in UTC)
  mutate(datetime = ymd_hm(paste0(year,"-", 
                                  month, "-", 
                                  day," ", 
                                  hour24, ":", 
                                  min), 
                           tz = "UTC")) %>%
  # Convert to local time
  mutate(datetimeLocal = with_tz(datetime, tz = "Pacific/Honolulu"))

## Aggregate and plot
mloa2 %>%
  # Extract month and hour from local time column
  mutate(localMon = month(datetimeLocal, label = TRUE),
         localHour = hour(datetimeLocal)) %>%
  # Group by local month and hour
  group_by(localMon, localHour) %>%
  # Calculate mean temperature
  summarize(meantemp = mean(temp_C_2m)) %>%
  # Plot
  ggplot(aes(x = localMon,
             y = meantemp)) +
  # Color points by local hour
  geom_point(aes(col = localHour)) +
  # Use a nice color ramp
  scale_color_viridis_c() +
  # Label axes, add a theme
  labs(x = "Month", y = "Mean temperature (degrees C)") +
  theme_classic()

# What could we do to this plot to make it look better?

# Can anyone see an opportunity for function-writing here?
## Reminder: Functions help you repeat something you want to do over and over again by packaging up the operations into something reproducible

rpl_9s_with_nas <- function(x){
  ifelse(x %in% c(-99, -999.9, -99.9), NA, x)
}

colnames(mloa)
head(mloa)

mloa2 = map_df(mloa, rpl_9s_with_nas)

summary(mloa$rel_humid)
summary(mloa2$rel_humid)

# ---- Challenge: function-writing from last week ----
## Write a new function that takes two arguments, the gapminder data.frame (d) and the name of a country (e.g. "Afghanistan"), and plots a time series of the country’s population. That is, the return value from the function should be a ggplot object. 
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
plotPopGrowth(unique(gapminder$country))

# Iterating for for-loops
for(i in unique(gapminder$country)){
  plotPopGrowth(i)
}

# iterating map functions
map(unique(gapminder$country), plotPopGrowth)



## Iterations also help you repeat something you want to do over and over again by performing that thing on multiple files, columns, rows... whatever unit you want to repeat across. 


# Why does iteration actually help?

## 1. Reading in data
### List all the file names you have in a folder
filenames <- list.files("data/flood_example")
filenames


for(i in filenames){ # For every file name
  filepath <- paste0("data/flood_example/",i) # Identify the filepath
  file <- read.csv(filepath) # They read in the filepath and call this new data.frame file
  assign(i, file, envir = .GlobalEnv)# Put the file (which is a dataframe) into our empty list called docs.compiled, and place it in the index named after i, which in this case are the filenames
}

flood_table <- function(data){
  data.frame(
    fema.2020.total = round(sum(data$FEMA.Properties.at.Risk.2020..total.), digits=0),
    fema.2020.pct = round(mean(data$FEMA.Properties.at.Risk.2020..pct.), digits=1),
    fs.2020.total = round(sum(data$FS.Properties.at.Risk.2020..total.), digits=0),
    fs.2020.pct = round(mean(data$FS.Properties.at.Risk.2020..pct.), digits=1)
  )
}


flood_table(data = idaho.csv)

flood_master_table <- data.frame()
for(i in filenames){
  table <- flood_table(get(i))
  flood_master_table <- rbind(table, flood_master_table)
}

flood_master_table$state <- filenames



df <- read.csv("data/mockingbird_adult_pb_data.csv")

# Convert ug/dl to ng/ml (times 10)

df$blood_ng_dl <- df$blood_ug_dl*10

# Which feather measurement has the lead concentrations most closely asigned to the blood levels?
df$cal_dff <- NA
df$mv_dff <- NA
df$tip_dff <- NA

diff.fx <- function(x){
  diff <- abs(x - df$blood_ng_dl)
  
}

df[10:12] <- map_df(df[6:8], diff.fx)

for(i in nrow(df)){
  df$min[i] <- colnames(df[10:12])[which.min(df[i, 10:12])]
}

# OR

df$min <- colnames(df[10:12])[apply(df[10:12], 1, which.min)]







