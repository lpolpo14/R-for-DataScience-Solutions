library(tidyverse)
library(nycflights13) # May need install.packages("nycflights13")

# Exercise 1
filter(flights, arr_delay >= 2) # a.
filter(flights, dest == "IAH" | dest == "HOU") # b.
airlines # DL = Delta, AA = American, and UA = United. Therefore
filter(flights, carrier %in% c("DL","AA", "UA")) # c.
flights["month"] # To learn how month is presented.
filter(flights, month >=9 & month <= 11) # d
filter(flights, dep_delay == 0, arr_delay >= 2) # e
filter(flights, dep_delay >= 1, arr_delay <= (dep_delay - 30)) # f (Recheck once I have more knowledge)
flights["dep_time"]
filter(flights, dep_time >= 1200 & dep_time <= 1800) # g

# Exercise 2 : Let's use the answer for question d from the previous exercise.
filter(flights, between(month,9,11)) # Shortcut for month>=9 & month<=11

# Exercise 3
filter(flights, is.na(dep_time)) # 8,255 lines. It could indicate cancelled flights.

# Exercise 4
NA ^ 0 # Any number raised to the power of 0 is 1! (Except for 0)
NA | TRUE # it means Something OR Something TRUE. The second part of the expression always holds.
FALSE | NA # The answer depends solely on what NA is. 
NA * 0 # NA could be infinite (Practically it still should have been 0, just for the sake of mathematics)

# Exercise 1
to_add <- filter(arrange(flights, dep_time), dep_time>0)
null_values <- filter(flights, is.na(dep_time))
(rbind(null_values,to_add)) # rbind appends the second tibble at the end of the first one.

# Exercise 2

arrange(flights,desc(dep_delay))
arrange(flights,dep_delay) # Negative times represent early departures (?flights)

# Exercise 3
arrange(flights,air_time)

# Exercise 4 - Use ["column_name"] to verify the results.

arrange(flights,desc(air_time))
arrange(flights,distance)

# Exercise 1 - One interesting way to do it is
select(flights, starts_with("dep"), starts_with("arr"))

# Exercise 2 - Like with the book's example with everything(), they will not be included again.
select(flights, time_hour, air_time, time_hour)

# Exercise 3 one_of() is superseded in favour of the more precise any_of() and all_of() selectors.
vars <- c("year", "month","day", "dep_delay", "arr_delay")
select(flights, one_of(vars))

# Exercise 4
select(flights, contains("TIME")) # It is case-insensitive.
# Reading ?contains, we can see ignore.case = TRUE. Therefore we can do this:
select(flights, contains("TIME", ignore.case = FALSE)) # Result has 0 columns.

# Exercise 1
temp <- select(flights, dep_time, sched_dep_time)
dept <- mutate(temp,
                  new_dep_time = ((dep_time%/%100)*60 + dep_time%%100),
                  new_sched_dep_time = ((sched_dep_time%/%100)*60 + sched_dep_time%%100))
dept

# Exercise 2

transmute(flights, a_time = air_time, res = arr_time - dep_time)
# Different Metrics. Using the logic from the first exercise we can fix it:
transmute(flights, a_time = air_time, 
          #res = ((arr_time%/%100)*60 + arr_time%%100) - ((dep_time%/%100)*60 + dep_time%%100))
          res = ((arr_time - dep_time)%/%100)*60 +(arr_time - dep_time)%%100)
# The issue now is the time zones.

# Exercise 3 dep_time must be >= sched_dep_time, and dep_time - sched_dep_time = dep_delay

# Exercise 4 From ?min_rank min_rank() gives every tie the same (smallest) value
# so that c(10, 20, 20, 30) gets ranks c(1, 2, 2, 4). It's the way that ranks
filter(flights, min_rank(desc(dep_delay)) <= 10) # We have got no ties in this example.
# To deal with hypothetical ties we could use ties.method = "random" which
# random: Assigns every tied element to a random rank 
# (either element tied for the 3rd and 4th position could receive either rank)

# Exercise 5 
1:3 + 1:10 # Different Lengths
1:3 # Length is 3
1:10 # Length is 10

# Exercise 6 Using ?sin we can see that it provides us with
#cos(x) sin(x) tan(x) acos(x) asin(x) atan(x) atan2(y, x) cospi(x) sinpi(x) and tanpi(x).

# Exercise 1 - We can try the median, the variance, the percentage of on time arrivals,
# the percentage of on time arrivals and departures, and the percentage of on time departures.
# Most important for us is the arrival time.

# Exercise 2 

not_cancelled <- flights %>% filter(!is.na(dep_delay), !is.na(arr_delay))
#(not_cancelled %>% group_by(dest) %>% summarize(n())) The Same
(not_cancelled %>% group_by(tailnum) %>% summarize(sum(distance)))
#(not_cancelled %>% count(tailnum, wt = distance)) The Same

# Exercise 3 : is.na(arr_delay) is enough. (Some flights may never reach the destination sadly..)

# Exercise 4 : I will leave it for another day. (!!!)

# Exercise 5
mean_delay_by_carrier <- flights %>% group_by(carrier) %>% 
  summarize(mean_delay = mean(arr_delay, na.rm = TRUE))
mean_delay_by_carrier %>% arrange(desc(mean_delay)) # Result is F9 AirTran Airways
# Depends. I will only check for F9 and all the airports it departs from.
# If the mean is similar for every airport, then we can say that F9 has an excuse.
flights %>% filter(carrier == "F9") %>% group_by(origin) %>% summarize(n())
# We can see the specific carrier supports only one flight LGA to DEN. Let's see the mean for the airport.
(mean_F9_depart <- flights %>% filter(origin == "LGA") %>% group_by(origin) %>%
  summarize(mean(dep_delay, na.rm = TRUE)))
(mean_F9_arrive <- flights %>% filter(origin == "LGA") %>% group_by(origin) %>%
    summarize(mean(arr_delay, na.rm = TRUE)))

# We can see that the carrier's delay is much more often than the airports.

# Exercise 6 (The solution was found online and it is pretty neat.)
# What personally helps me is employing a logic similar to that of sql queries, give it a try!
# link is : https://jrnold.github.io/r4ds-exercise-solutions/workflow-basics.html
# (Truth be told, I got extremely dissapointed such a great site with solutions already exists..
# ruins the joy of solving in a way. Oh well, it is what it is.)
flights %>%
  # sort in increasing order
  select(tailnum, year, month,day, dep_delay) %>%
  filter(!is.na(dep_delay)) %>%
  arrange(tailnum, year, month, day) %>%
  group_by(tailnum) %>%
  # cumulative number of flights delayed over one hour
  mutate(cumulative_hr_delays = cumsum(dep_delay > 60)) %>%
  # count the number of flights == 0
  summarise(total_flights = sum(cumulative_hr_delays < 1)) %>%
  arrange(total_flights)

# Exercise 7 - If TRUE, it will show the largest groups at the top.
# We could use it instead of arrange with desc().

# Exercise 1 - a Window function returns n values when given n inputs, and include variations on
# aggregate functions, functions for ranking and ordering, and functions for taking offsets (lag())
# The given command vignette("window-functions") contains a lot of examples.

# Exercise 2 - Once more, I will use the provided solution by the same site due to its efficiency.
flights %>%
  filter(!is.na(tailnum)) %>%
  mutate(on_time = !is.na(arr_time) & (arr_delay <= 0)) %>%
  group_by(tailnum) %>%
  summarise(on_time = mean(on_time), n = n()) %>%
  filter(min_rank(on_time) == 1) # The interesting idea!

