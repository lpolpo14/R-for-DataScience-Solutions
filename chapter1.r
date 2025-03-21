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

# Exercise 1 - The color = "blue" Should be passed as a parameter to geom_point, not to aes.

# Exercise 2 - using ?mpg we can see the various values. Yes, we can see the values using simply mpg.

# Exercise 3 
ggplot(data = mpg) +
  geom_point(mapping = aes(color = displ, x = class, y = cty, size = hwy, shape = model))
# Conclusion : color and size handle continuous values well, shape accepts only discrete values
# and with difficulty at that.

# Exercise 4
ggplot(data = mpg) +
  geom_point(mapping = aes(color = displ, x = class, y = cty, size = displ))
# Conclusion : They will be analogous.

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
# Sadly ymin and ymax are deprecated, so we had to change up the code. Read the Documentation!

# Exercise 2 Using ?geom_bar we get: "There are two types of bar charts: geom_bar() and 
# geom_col(). geom_bar() makes the height of the bar proportional to the number of cases 
# in each group (or if the weight aesthetic is supplied, the sum of the weights). 
# If you want the heights of the bars to represent values in the data, use geom_col() instead."

# Exercise 3 : We will examine bar charts, boxplots, scatterplots and the line.
# geom_point - stat = identity
# geom_line - stat = identity
# geom_smooth - stat = smooth
# geom_bar - stat = count
# geom_boxplot - stat = boxplot
# One common identity is the name (geometrical items start with geom, while the statistical
# transformations with stat)

# Exercise 4: Using ?stat_smooth we get: These are calculated by the 'stat' part of layers and can be accessed with delayed evaluation.
# stat_smooth() provides the following variables, some of which depend on the orientation:
# after_stat(y) or after_stat(x)
# Predicted value.
# after_stat(ymin) or after_stat(xmin)
# Lower pointwise confidence interval around the mean.
# after_stat(ymax) or after_stat(xmax)
# Upper pointwise confidence interval around the mean.
# after_stat(se)
# Standard error.
# To summarize: it can be accessed with delayed evaluation and it calculates the above variables.

# Exercise 5: Let's find out using code!
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = after_stat(prop))) # ..prop.. is deprecated.
# We can see that the percentages are all 1!
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = color, y = after_stat(prop),
    )
)
# Conclusion : Group is needed so as to apply the statistical transformation properly to each discrete partition.

# Exercise 1: Overplotting may be present, so lets add jittering.
ggplot(data = mpg, mapping = aes(x = cty, y = hwy))+
  geom_point(position = "jitter")

# Exercise 2: using ?geom_jitter we can see it is width and height, which default to
# 40% of the resolution of the data.

# Exercise 3: Both use dots to make scatterplots, geom_count doesn't use randomness though,
# it simply makes increments the size of a point where there are overlapping points.
# geom_jitter on the other hand uses random variation to the location.

# Exercise 4: Using ?geom_boxplot we can see it is dodge2.
# y must be continuous and x should be discrete (or partitioned correctly)
ggplot(data = mpg) +
  geom_boxplot(aes(x = class, y = cty))

# Exercise 1 - We will solve this with a better way in the future
bar <- ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut),
           show.legend = FALSE, width=1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
bar + coord_polar()

# Exercise 2 - Changes the names of the x and y labels

# Exercise 3 - coord_map() projects a portion of the earth, 
# which is approximately spherical, onto a flat 2D plane using any 
# projection defined by the mapproj package. Map projections do not, 
# in general, preserve straight lines, so this requires considerable 
# computation. coord_quickmap() is a quick approximation that does 
# preserve straight lines. It works best for smaller areas closer
# to the equator.
#Both coord_map() and coord_quickmap() are superseded by coord_sf(),
# and should no longer be used in new code.

# Exercise 4 : coord_fixed -> A fixed scale coordinate system forces a specified ratio between the physical
# representation of data units on the axes.
# geom_abline -> These geoms add reference lines (sometimes called rules) to a plot, either horizontal,
# vertical, or diagonal (specified by slope and intercept).
# These are useful for annotating plots.
# Conclusion : There is a linear relation between x and y. geom_abline() allows
# us to see more clearly by drawing a reference line with slope 1 and intercept = 0
