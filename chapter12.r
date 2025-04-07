library(tidyverse)
library(forcats)

# Exercise 1
ggplot(gss_cat, aes(rincome)) +
  geom_bar()
# Too many levels. We could group some levels and have less bars.

# Exercise 2
ggplot(gss_cat, aes(relig)) +
  geom_bar() # Protestant
ggplot(gss_cat, aes(partyid)) +
  geom_bar() # Independent

# Exercise 3

gss_cat %>% count(relig, sort = TRUE)
gss_cat %>% filter(denom != 'Not applicable' & denom != 'No denomination' &
                     denom != 'Don\'t Know' & 'No Answer' != denom &
                     'Other' != denom) # 7194 lines. Therefore Protestant

# Exercise 1

gss_cat %>% filter(relig == 'Don\'t know') # Result is only 15 lines, half NA!

# Exercise 2 : 
gss_cat %>% ggplot(aes(marital)) + geom_bar() + coord_flip() # There is some logic.
# Similarly for the rest.

# Exercise 3 It becomes the first level (levels = c("Not applicable"))

# Exercise 1

grouped <- gss_cat %>%
  mutate(partyid = fct_collapse(partyid,
                               other = c("No answer", "Don't know", "Other party"),
                               rep = c("Strong republican", "Not str republican"),
                               ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                               dem = c("Not str democrat", "Strong democrat"))
         )
grouped %>% group_by(year) %>%
  count(partyid, name = 'c') %>% ggplot(aes(year, c, colour = partyid)) + geom_line()

# Exercise 2 Using fct_collapse with 0-5k range.

