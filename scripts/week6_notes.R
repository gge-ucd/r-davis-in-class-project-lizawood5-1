# --------------------------------------
## You do not need to type this code -- this is how we get the live code working 
source('functions/livestreamSetup.R')
livestreamSetup(password = 'vulcans',user = 'rdavis',port = 4040)

# --------------------------------------
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

# EXPLORING the NA situation with conditional statements
## leaving the last "else" argument in case_when assigns the 'large' value to EVERYTHING else, including NAs

surveys %>% 
  mutate(weight_cat = case_when(
    weight >= 20.00 ~ "small",
    weight > 20.00 & weight < 48.00 ~ "medium",
    T ~ "large" 
  )) %>% 
  select(weight, weight_cat) %>% 
  filter(is.na(weight))


# leaving the last "else" argument in ifelse assigns the 'large' value to everything else, BUT DOES NOT INCLUDE NAs
surveys %>% 
  mutate(weight_cat = ifelse(weight >= 20.00, "small",
                      ifelse(weight > 20.00 & weight < 48.00, "medium" 
                             ,"large"))) %>% 
  select(weight, weight_cat) %>% 
  filter(is.na(weight))

# specify the final argument in case_when()
surveys %>% 
  mutate(weight_cat = case_when(
    weight >= 20.00 ~ "small",
    weight > 20.00 & weight < 48.00 ~ "medium",
    weight >= 48.00 ~ "large" 
  )) %>% 
  select(weight, weight_cat) %>% 
  filter(is.na(weight))

# Manipulate surveys to create a new dataframe called surveys_wide with:
# 1. column for genus and a column named after every plot type (step 2)
# 2. each of these columns containing the mean hindfoot length of animals in that plot type and genus. So every row has a genus and then a mean hindfoot length value for every plot type. (step 1)
# 3. The dataframe should be sorted by values in the Control plot type column. (step 3)

# Step 1:
surveys2 <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(plot_type, genus) %>% 
  summarize(mean_hindfoot = mean(hindfoot_length))
surveys2

# Step 2 & 3:
surveys_wide <- pivot_wider(surveys2, names_from = "plot_type", values_from = "mean_hindfoot")
surveys_wide

# arrange
surveys_wide %>% 
  arrange(Control)

surveys_wide %>% 
  arrange(desc(Control))
  

# What if we wanted to reverse this back into the longer version of what we made before
?pivot_longer
surveys_reverse <- surveys_wide %>% 
  pivot_longer(cols = c(Control:`Spectab exclosure`), 
               names_to = "plot_type", 
               values_to = "mean_hindfoot") 
# cols:  which columns I want to pivot
# names_to: takes the column name and puts them into a column. What do you want to name the column of column names?
# values_to: takes the values from each of these columns cells. What do you want to name the column of cell values?

# Use what you just learned to create a scatter plot of weight and species_id with weight on the Y-axis, and species_id on the X-axis. Have the colors be coded by plot_type. Is this a good way to show this type of data? What might be a better graph

surveys_complete <- surveys %>% 
  filter(complete.cases(.))

plot <- ggplot(data = surveys_complete, mapping = aes(y = weight, x = species_id)) +
  geom_point(alpha = 0.5, aes(color = plot_type))

# switches axes
ggplot(data = surveys_complete, 
       mapping = aes(y = weight, x = plot_type)) +
  geom_point(alpha = 0.5, aes(color = species_id))

# plot types as panels
ggplot(surveys_complete, aes(x = species_id, y = weight)) +
  geom_point() +
  facet_wrap(~plot_type)

# don't like the theme
ggplot(surveys_complete, aes(x = species_id, y = weight)) +
  geom_point() +
  theme_classic()

ggplot(surveys_complete, aes(x = species_id, y = weight)) +
  geom_boxplot() +
  geom_jitter(mapping = aes(color = plot_type))


ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato") #notice our color needs to be in quotations 

# adding violin
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.1, color = "tomato") +
  geom_violin(alpha = 0)

# adding
base <- ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight))

base +
  geom_jitter(alpha = .1) +
  geom_violin() +
  scale_y_log10()

?scale_y_log10  

# Make a new plot to explore the distrubtion of hindfoot_length just for species NL and PF. Overlay a jitter plot of the hindfoot lengths of each species by a boxplot. Then, color the datapoints according to the plot from which the sample was taken.

surveys_complete %>% 
  # inclusive is & vs "or" |
  filter(species_id == "NL" | species_id == "PF") %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = plot_id))

# plotis is numeric but want it to be categorical

hindfoot_survey <- surveys_complete %>% 
  # inclusive is & vs "or" |
  filter(species_id == "NL" | species_id == "PF")

hindfoot_survey$plot_factor <- as.factor(hindfoot_survey$plot_id)

ggplot(data = hindfoot_survey,
       mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = plot_factor))


surveys_complete %>% 
  # inclusive is & vs "or" |
  filter(species_id == "NL" | species_id == "PF") %>% 
  mutate(plot_factor = as.factor(plot_id)) %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = plot_factor))

surveys_complete %>% 
  # inclusive is & vs "or" |
  filter(species_id == "NL" | species_id == "PF") %>% 
  ggplot(mapping = aes(x = species_id, y = hindfoot_length)) +
  geom_boxplot(alpha = 0.1) +
  geom_jitter(alpha = 0.3, mapping = aes(color = as.factor(plot_id))) +
  labs(x = "Species ID",
       y = "Hindfoot Length", 
       title = "Boxplot",
       color = "Plot ID") +
  theme_classic() +
  theme(axis.title.x = element_text(angle = 45))











