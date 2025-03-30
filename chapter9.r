library(tidyverse)
library(ggplot2)
# Exercise 1:
# table1 : For each country for every year write cases and population.
# table2: For each coutry for every year write 2 rows with the count of population and cases respectively.
# table 3: Concatinate cases and population into single string.
# table 4: make two tables for the given years and with respective data input.

# Exercise 2:
table2a <- table2 %>%
  filter(type == 'cases') %>%
  rename(cases = count) %>%
  select(country,year,cases)
table2b <- table2 %>%
  filter(type == 'population') %>%
  rename(population = count) %>%
  select(population)
table2c <- table2a %>% mutate(table2b)
# We brought the table 2 to the design of table 1. 
# Table 4 is a bit easier
table4c <- table4b %>% select(`1999`,`2000`) %>% rename(`1999b` = `1999`, `2000b`= `2000` )
table4final <- table4a %>% mutate(table4c)
# Now we can use the Formula

# Exercise 3 : We have to redo exercise 2
ggplot(table2c, aes(year,cases)) +
  geom_line(aes(group = country), color = "grey50") +
  geom_point(aes(color = country))

# Exercise 1 : Let's find out!
stocks <- tibble(
  year = c(2015,2015,2016,2016),
  half = c(1,2,1,2),
  return = c(1.88,0.59,0.92,0.17)
)
stocks
stocks %>%
  spread(year,return) # as expected, year becomes variable name.
stocks %>%
  spread(year,return) %>%
  gather("year","return",`2015`:`2016`)
# The columns are in switched places, and year is now char instead of dbl: 
# If TRUE, type.convert() with asis = TRUE will be run
# on each of the new columns. This is useful if the value column was a mix of variables
# that was coerced to a string. If the class of the value column was factor or date,
#note that will not be true of the new columns that are produced,
# which are coerced to character before type conversion.
stocks %>%
  spread(year,return) %>%
  gather("year","return",`2015`:`2016`, convert = TRUE)
# year is now int.

# Exercise 2 : variable names are wrong

# Exercise 3 : There are repeating names. We could add an id

# Exercise 4:
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes", NA, 10,
  "no", 20, 12
)
preg %>% gather("male", "female", key = "sex", value = "amount")
# I have no idea what the data means.

# Exercise 1 :  Fill = 	If sep is a character vector, this controls what happens when there
# are not enough pieces.
# extra = f sep is a character vector, this controls what happens when there are too many pieces.

# Exercise 2 : 	If TRUE, remove input column from output data frame.
# In the example with year, i would use it to remove it when separating into century and year.

# Exercise 3 : extract is superseded. Given a regular expression with capturing groups,
# extract() turns each group into a new column. If the groups don't match, or the input is NA,
# the output will be NA. Unite can do all of those things with different parameters.

# Exercise 1:
# spread : 	
# If set, missing values will be replaced with this value. Note that there are two types of
# missingness in the input: explicit missing values (i.e. NA), and implicit missings,
# rows that simply aren't present. Both types of missing value will be replaced by fill.
# complete : 	
# A named list that for each variable supplies a single value to use instead of
# NA for missing combinations.

# Exercise 2:
# Direction in which to fill missing values. Currently either "down" (the default),
# "up", "downup" (i.e. first down and then up) or "updown" (first up and then down).

# Exercise 1: Yes it is logical. One must begin from somewhere. The value column must be NA
# for it to remove the row. That means that in the starting table, if one value of a row is null,
# it will remove all the values of new_sp_m014:newrel_f65 as well, removing a lot of rows in the final table.
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = FALSE) %>%
  mutate(code = stringr::str_replace(code, "newrel", "new_rel"))  %>%
  separate(code, c("new", "var", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)
# Our guess was correct - most values as a result are NA, when only one value was probably missing
# in one column of the starting table.

# Exercise 2 :
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>%
  filter(code == "newrel_f1524") %>%
  separate(code, c("new", "var", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)
# The results are all wrong!

# Exercise 3

who %>%
  group_by(country,iso2,iso3) %>%
  select(country:iso3) %>%
  summarize(n = n())

# Exercise 4
who_final <- who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>%
  mutate(code = stringr::str_replace(code, "newrel", "new_rel"))  %>%
  separate(code, c("new", "type", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)

who_final

who_final %>% 
  filter(year > 1994) %>% # Outliers
  group_by(country, year, sex) %>% summarize(n = sum(value)) %>%
  ggplot(mapping = aes(year, n)) + geom_line(aes (color = sex))
# It is best to split the graph to multiple ones since there are so many countries.