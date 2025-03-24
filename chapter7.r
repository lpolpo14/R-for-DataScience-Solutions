library(tidyverse)

#Exercise 1

diamonds # Mentions that it is a tibble.
iris # It does not mention anything
class(iris)
class(diamonds)
# Exercise 2

df <- data.frame(abc =1, xyz = "a")
df$x
df[, "xyz"]
df[, c("abc","xyz")]
# We can see that the above is very leisurely and not strict at all in its use
df2 <- tibble(abc = 1, xyz = "a")
df2$x #doesn't run now.
df2$xyz # Works now
df2[, "xyz"] # Works correctly
df2[, c("abc", "xyz")] #Also Works

# Exercise 3
df3 <- tibble(df4 = "mpg")
var <- "df4"
# We could use this
df3[[var]] # Not df3$var


# Exercise 4

annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)

annoying[[1]] # a
annoying$`1`
ggplot(data = annoying, mapping = aes(annoying[[1]], annoying[[2]])) +
  geom_point() #b

annoying <- tibble(
  `1` = annoying[[1]],
  `2` = annoying[[2]],
  `3` = annoying[[2]] / annoying[[1]]
) # c
annoying

annoying <- tibble(
  one = annoying$`1`,
  two = annoying$`2`,
  three = annoying$`3`
) # d

# Exercise 5 : enframe() converts named atomic vectors or lists to one- or two-column data frames.
# For a list, the result will be a nested tibble with a column of type list.
# For unnamed vectors, the natural sequence is used as name column.
typeof(enframe(1:5, name = "test"))
typeof(deframe(enframe(1:5, name = "test")))

# Exercise 6 max_extra_cols: 	Number of extra columns to print abbreviated information for,
# if the width is too small for the entire tibble. If NULL, the max_extra_cols option is used.
# The previously defined n_extra argument is soft-deprecated.
