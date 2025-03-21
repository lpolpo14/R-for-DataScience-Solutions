library(tidyverse)
# Exercise 1: my_variable is typed wrong.
# Exercise 2
ggplot(data = mpg) + geom_point(mapping = aes(x = displ, y = hwy)) # data, not dota.

filter(mpg, cyl == 8) # Becareful, == not =. (Also filter, not fliter)
filter(diamonds, carat>3) # diamonds, not diamond.

# Exercise 3 I don't have Windows..