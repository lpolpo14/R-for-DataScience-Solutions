# We will be using the ggplot2 library to do most of the exercises.
library(tidyverse) # Must be installed (RStudio does it automatically).

#Exercise 1
ggplot2::ggplot(data = ggplot2::mpg) # Creates an empty graph.
# Exercise 2
mtcars # It is 11 columns and 32 rows (Using ?mtcars)
# Exercise 3 Using ?ggplot2::mpg - drv symbolizes the type of drive train.

# Exercise 4
ggplot2::ggplot(data = ggplot2::mpg) +
  ggplot2::geom_point(mapping = ggplot2::aes(x = hwy, y = cyl))

# Exercise 5
ggplot(data = mpg) +
  geom_point(mapping = aes(x =class, y = drv))
# It is not useful due to overlapping values.

# Exercise 1 - The color = "blue" Should be passed as a parameter to geom_point, not aes.

# Exercise 2 - using ?mpg we can see the various values. Yes, we can see the values using simply mpg.

# Exercise 3 
ggplot(data = mpg) +
  geom_point(mapping = aes(color = displ, x = class, y = cty, size = hwy, shape = model))
# Conclusion : color and size handle continuous values well, shape accepts only discrete values
# and with difficulty at that.

# Exercise 4
ggplot(data = mpg) +
  geom_point(mapping = aes(color = displ, x = class, y = cty, size = displ))
# Conclusion : There will be analogous.

# Exercise 5 : The stroke aesthetic modifies the width of the border.

# Exercise 6
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = cty, color = displ < 5))
# Conclusion : It treats the last parameter as a Boolean!

# Exercise 1 : Let's find out!
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = hwy)) +
  facet_wrap (~ displ, nrow = 2)
# Conclusion : It will check exhaustively every single value that the variable may have.

# Exercise 2 : It means that there is not a row in the data Frame for which those two variables
# Take on the values of the specific graph. The mentioned code confirms that.

# Exercise 3:
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y =hwy)) +
  facet_grid (drv ~ .)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y =hwy)) +
  facet_grid (. ~ cyl)
# Conclusion : the first 3 lines splits the data set into graphs partitioned based on the values of
# the drv variable into rows. The last 3 lines do the same but into column with respect to cyl.

# Exercise 4 : With a lot of data the colors may overlap. With little data we have a single graph.
# With a lot of graphs we can notice the properties for each value of the variable we are examining.
# With one graph we can take all the properties of all the variables into consideration easier.

# Exercise 5 : nrow is the number of rows and ncol the number of columns.
# facet_grid takes into consideration solely the values of the inputed as parameters variables.

# Exercise 6 : It is simply more discernible. Take the following example.
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y =hwy)) +
  facet_grid (class ~ manufacturer)

# Exercise 1 : I would use an area chart, changing the colour of the area and keeping only the main line.

# Exercise 2 : Prediction = We get two plots with x = displ and y = hwy using color = drv.
# One plot is geom_point, and the other is geom_smooth. se = false means we don't get a confidence interval.
# Confidence interval is the shadowy area close/surrounding the main line. Let's see!

ggplot(data = mpg, mapping = aes(x = displ, y =hwy, color = drv)) +
  geom_point()+
  geom_smooth(se = FALSE)
# Correct! (The prediction could have included the amount of lines generated. Can you guess?)

# Exercise 3 : Using ?geom_smooth() ->  Should this layer be included in the legends?
# NA, the default, includes if any aesthetics are mapped. FALSE never includes, 
# and TRUE always includes. It can also be a named logical vector to finely 
# select the aesthetics to display.

# Exercise 4 : See Exercise 2 (Display confidence interval around smooth? 
# (TRUE by default, see level to control.)

# Exercise 5 : The plots will be exactly the same, See for yourself!

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = mpg,
    mapping = aes(x = displ, y = hwy)
  ) +
  geom_smooth(
    data = mpg,
    mapping = aes(x = displ, y = hwy)
  )

# Exercise 6 - Execute each pack of commands seperately for each graph.

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point()+
  geom_smooth(se = FALSE)

ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point()+
  geom_smooth(se = FALSE, aes(group = drv))

ggplot(data = mpg, aes(x = displ, y = hwy, colour = drv))+
  geom_point()+
  geom_smooth(se = FALSE)

ggplot(data = mpg, aes(x = displ, y = hwy))+
  geom_point(aes(colour = drv))+
  geom_smooth(se = FALSE)

ggplot(data = mpg, aes(x = displ, y = hwy))+
  geom_point(aes(colour = drv))+
  geom_smooth(se = FALSE, aes(linetype = drv))

ggplot(data = mpg, aes(x = displ, y = hwy))+
  geom_point(aes(colour = drv)) # Don't know how to get the white border around points.

# Exercise 1 Using ?stat_summary we see it uses geom = "pointrange"
ggplot(data = diamonds, mapping = aes(x = cut, y = depth)) +
  geom_pointrange(stat = "summary", fun.min = min, fun.max = max, fun = median)
# Sadly ymin and ymax are deprecated, so we had to change up the code.

# Exercise 2 (To be continued..)
