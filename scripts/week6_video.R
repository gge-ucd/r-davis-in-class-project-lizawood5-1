## Data Visualization Part1 a
# Goals: Introduction ggplot package, scatter plots and boxplots
library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv") %>% 
  filter(complete.cases(.))

## General format: ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) + <GEOM_FUNCTION>()
# geom_point() for scatter plots (continuous x continuous variables)
# geom_boxplot() for boxplots (categorical x continuous variables)
# geom_line() for trend lines

# gives you a blank canvas
ggplot(data = surveys)

# now we axes
ggplot(data = surveys, mapping = aes(x = weight, y = surveys$hindfoot_length))

# add in geom for shape
ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) + 
  geom_point()

base_plot <- ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length))
base_plot

base_plot + geom_point()

# adding plot elements: transparency = alpha, color = color, infill = fill
base_plot + geom_point(alpha = 0.2)
base_plot + geom_point(color = "blue")
base_plot + geom_point(color = "aquamarine")
base_plot + geom_point(alpha = 0.5, color = "red")

# color by categorical

ggplot(data = surveys, mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point(mapping = aes(color = species_id))

# geom_boxplot

ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot()

base_plot2 <- ggplot(data = surveys, mapping = aes(x = species_id, y = weight))

base_plot2 +
  geom_boxplot(color = "purple") +
  geom_point()

base_plot2 +
  geom_boxplot() +
  geom_jitter(alpha = 0.2, mapping = aes(color = species_id))
  
  










