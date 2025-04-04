library(tidyverse)
library(nycflights13)

# Exercise 1 : We need only the flights table with origin and dest and tailnum.

# Exercise 2 : faa of airports connected with origin of weather.

# Exercise 3: Destination too.

# Exercise 4: primary keys are year,month,day and contain the sum of travelers on that day.

# Exercise 1 : The most common way to do this is through and ID key. Sort Year, Month, and Day
# and for every flight increment the ID.

# Exercise 2 : Skipping this one (Got a perfect grade for the Data Bases Course!)

# Exercise 3 : Skipping this one too.

# Exercise 1

flights2 <- flights %>%
  group_by(dest) %>%
  summarise(mean_delay = mean(arr_delay, na.rm = TRUE)) %>% 
  filter(mean_delay > 0) %>%
  left_join(airports, c("dest" = "faa")) %>%
  filter(lon > -130)

ggplot(flights2, aes(lon,lat, color = mean_delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# Exercise 2

flights_with_dep <- flights %>%
  inner_join(airports,c("origin" = "faa")) %>%
  rename(lat_origin = lat, lon_origin = lon) %>%
  inner_join(airports,c("dest" = "faa")) %>%
  rename(lat_dest = lat, lon_dest = lon) %>%
  select(year:time_hour, lat_origin, lon_origin, lat_dest, lon_dest)

# Exercise 3

mean_delay_plane <- flights %>%
  select(!year) %>%
  inner_join(planes, by = "tailnum") %>%
  filter(!is.na(arr_delay)) %>%
  group_by(tailnum,year) %>%
  summarize(mean_delay = mean(arr_delay)) %>% 
  filter(mean_delay > 0 )

ggplot(mean_delay_plane,mapping = aes(year, mean_delay)) +
geom_jitter() # not really.

# Exercise 4 : This one is an interesting question. I will provide the solution from this link:
# https://jrnold.github.io/r4ds-exercise-solutions/relational-data.html

flight_weather <-
  flights %>%
  inner_join(weather, by = c(
    "origin" = "origin",
    "year" = "year",
    "month" = "month",
    "day" = "day",
    "hour" = "hour"
  ))
flight_weather %>%
  group_by(precip) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = precip, y = delay)) +
  geom_line() + geom_point()
flight_weather %>%
  ungroup() %>%
  mutate(visib_cat = cut_interval(visib, n = 10)) %>%
  group_by(visib_cat) %>%
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = visib_cat, y = dep_delay)) +
  geom_point()
# Note: Check the above website for detailed reports. I just provide my solutions here!

# Exercise 5

June <- flights %>%
  inner_join(weather) %>%
  filter(year == 2013, day == 13, month == 6) %>%
  group_by(dest) %>%
  summarize(mean_delay = mean(arr_delay, na.rm = TRUE)) %>%
  filter(mean_delay >= 0)   %>% 
  left_join(airports, c("dest" = "faa")) %>%
  filter(lon > -130)

ggplot(June, aes(lon,lat, color = mean_delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# Exercise 1

no_tail <- flights %>%
  filter(is.na(tailnum))
no_tailanti <- flights %>%
  anti_join(planes, by = "tailnum")
# American Airways (AA) and Envoy Air (MQ) report fleet numbers rather than tail 
# numbers so can't be matched.

# Exercise 2
flights %>%
  group_by(tailnum) %>%
  mutate(n = n()) %>%
  filter(n >= 100) %>%
  select(!n)

# Exercise 3 Skipping this one

# Exercise 4 : Very hard exercise. I will provide the solution from the link
worst_hours <- flights %>%
  mutate(hour = sched_dep_time %/% 100) %>%
  group_by(origin, year, month, day, hour) %>%
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ungroup() %>%
  arrange(desc(dep_delay)) %>%
  slice(1:48)
# Note : There are multiple solutions and interpretations depending on the hypothesises one makes.

# Exercise 5
view(anti_join(flights,airports,by = c("dest" = "faa")))
# Destination is not in America
view(anti_join(airports,flights, by = c("faa" = "dest")))
# Destinations that weren't the destination of any flight.

# Exercise 6

multiple <- flights %>%
  filter(!is.na(tailnum)) %>%
  group_by(tailnum,carrier) %>%
  summarise(n = n()) %>%
  count(tailnum, sort = TRUE)
# Can also use distinct(tailnum,carrier)