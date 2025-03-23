library(tidyverse)

# Exercise 1
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = x), binwidth = 0.5) +
  coord_cartesian(ylim = c(0,20))
# Main outlier can be seen on 0. (Meaning diamond has 0 length in mm)
# For y we have the book example. 

ggplot(diamonds) +
  geom_histogram(mapping = aes(x = z), binwidth = 0.5) +
  coord_cartesian(ylim = c(0,20))
# Outliers on 0, and ~ 32. 

# Exercise 2
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 5000)
# We can see that more expensive diamonds get rarer.
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 1000)
# We get suspicious of price ~ 0
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 20) +
  coord_cartesian(ylim = c(0,130), xlim = c(0,2000))
# We can see no diamonds that go for the price of ~ 1500.

# Exercise 3

diamonds %>%
  filter(carat == 0.99 | carat == 1) %>%
  group_by(carat) %>%
  summarise(count = n()) 
# Sounds better to the ear, and for 1 carat to be the base unit it should be more common.

# Exercise 4
# Using the solution for exercise 2, instead of ylim and xlim we will use the
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 20) +
  ylim(0,200) + xlim(0,2000) # It removed a lot of rows!

# Exercise 1 : In a histogram missing values are removed with a warning
# The Bar_chart has the same effects. The importance is when we take percentages.
# We want to be aware if the total_population includes the removed values/rows.

# Exercise 2 : a logical evaluating to TRUE or FALSE indicating whether NA values
# should be stripped before the computation proceeds.
# If an included value is NA or NaN, the result will be NA/NaN


# Exercise 1 : We can use a normalized column and use it as y in a geom_freqpoly.
# Alternatively, we can use a boxplot.

# Exercise 2
ggplot(data = diamonds, mapping = aes(x = price, y = after_stat(density))) +
  geom_freqpoly(mapping = aes(color = clarity), binwidth = 500)
# We can see the cut and clarity variables are connected. (And for color)
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_point(mapping = aes(color = cut))
# Bingo, the carat is what increases the value. We can see that diamonds with an ideal cut
# increase in value much faster than those with lesser quality
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_smooth(mapping = aes(color = cut))
# The reason is therefore stated just below
diamonds %>%
  filter(carat > 4) %>%
  count(cut)

# Exercise 3 : Skipping this one

# Exercise 4 : Skipping this one

# Exercise 5 : A violin plot is a compact display of a continuous distribution.
# It is a blend of geom_boxplot() and geom_density(): a violin plot is a mirrored
# density plot displayed in the same way as a boxplot.

# Exercise 6 : skipping this one.

# Exercise 1 Solution from https://jrnold.github.io/r4ds-exercise-solutions/exploratory-data-analysis.html

diamonds %>%
  count(color, cut) %>%
  group_by(color) %>%
  mutate(prop = n / sum(n)) %>% # Use prop.
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = prop))

# Exercise 2 Personally skipping it, I will provide the solution from the same link though.

flights %>%
  group_by(month, dest) %>%                                 # This gives us (month, dest) pairs
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  group_by(dest) %>%                                        # group all (month, dest) pairs by dest ..
  filter(n() == 12) %>%                                     # and only select those that have one entry per month 
  ungroup() %>%
  mutate(dest = reorder(dest, dep_delay)) %>%
  ggplot(aes(x = factor(month), y = dest, fill = dep_delay)) +
  geom_tile() +
  labs(x = "Month", y = "Destination", fill = "Departure Delay")

# Exercise 3
# It feels better for the eye due to the larger amount of columns.
diamonds %>%
  count(color, cut) %>%
  group_by(color) %>%
  mutate(prop = n / sum(n)) %>% # Use prop.
  ggplot(mapping = aes(x = cut, y = color)) +
  geom_tile(mapping = aes(fill = prop))

# Exercise 1

ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_freqpoly(mapping = aes(color = cut_width(carat, 1))) +
  labs(color = "Cut Width (Carat)")

# Exercise 2

ggplot(data = diamonds, mapping = aes(x = price, y = carat)) +
  geom_boxplot(mapping = aes(group = cut_width(price, 1000)))

# Exercise 3 : Prediction, they will be cheap.

ggplot(data = diamonds, mapping = aes(x = depth, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(depth, 4))) # As Predicted.

# Exercise 4 : Here is one

ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_smooth(mapping = aes(color = cut)) # Coincidentally the same as before!

# Exercise 5 : If the amount of bins is small, it may not catch the outliers.
# Also, because there is a relation between x and y. 
