
## Data visualization Part 2
## Plots for publication with cowplot()
library(tidyverse)

summary(diamonds)
summary(iris)
summary(mpg)

diamonds.plot <- ggplot(diamonds, aes(clarity, fill = cut)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5))
diamonds.plot

mpg.plot <- ggplot(mpg, aes(cty, hwy, color = factor(cyl))) +
  geom_point(size = 2.5)
mpg.plot

iris.plot <- ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) +
  geom_point(alpha = 0.3)
iris.plot

# cowplot package to combine many plots
#install.packages("cowplot")
library(cowplot)

# use plot_grid to line up many plots in even boxes
plot_grid(diamonds.plot, iris.plot, mpg.plot, labels = c("A", "B", "C"), nrow = 1)

# use ggdraw + draw_plot to line up plots 
final.plot <- ggdraw() + draw_plot(iris.plot, x = 0, y = 0, width = 1, height = 0.5) +
  # iris will take up the hwole bottom of row
  draw_plot(mpg.plot, x = 0, y = 0.5, height = 0.5, width = 0.5) +
  # mpg will take up top left
  draw_plot(diamonds.plot, x = 0.5, y = 0.5, width = 0.5, height = 0.5)
# diamonds is top right


# ggsave
getwd()
dir.create("figures")
ggsave("figures/finalplot.png", plot = final.plot, width = 6, height = 4, units = "in")

# interactive plots
library(plotly)
plotly::ggplotly(iris.plot)




