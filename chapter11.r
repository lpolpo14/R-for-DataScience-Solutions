library(tidyverse)
library(stringr)

# Exercise 1
# paste converts its arguments (via as.character) to character strings,
# and concatenates them (separating them by the string given by sep).
# paste0(..., collapse) is equivalent to paste(..., sep = "", collapse), slightly more efficiently.
# Note that paste() coerces NA_character_, the character missing value, to "NA"
# which may seem undesirable, e.g., when pasting two character vectors,
# or very desirable, e.g. in paste("the value of p is ", p).
# They are equivelant to str_c

# Exercise 2 : sep is what to put between the strings and collapse is if there ought to be space.

# Exercise 3
str <- c("HeyYou!")
str_sub(str,str_length(str)/2,str_length(str)/2)
str <- c("HeyYou")
str_sub(str,str_length(str)/2,str_length(str)/2)
# Experiment however you want.

# Exercise 4 : Wrap words into paragraphs, minimizing the "raggedness" of the lines
# (i.e. the variation in length line) using the Knuth-Plass algorithm.
# Link to wikipedia page: https://en.wikipedia.org/wiki/Knuth–Plass_line-breaking_algorithm

# Exercise 5 : str_trim() removes whitespace from start and end of string; str_squish()
# removes whitespace at the start and end, and replaces all internal whitespace
# with a single space. str_pad() to add white_space

# Exercise 6: I don't know how to write functions. Logic is to concatinate with str_c all
# the parameters except for the last one. then we concatinate the two remaining strings.

# Exercise 1:

str_view("\\","\"") # added extra " since it considers " the escape character
str_view("\\","\\") # Unrecognized backslash escape sequence
str_view("\\","\\\"") # For the same reason as before with one \

# Exercise 2

str_view("\"\'\\","\"'\\\\")

# Exercise 3

str_view(".X.X.X","\\..\\..\\..") # Put anything in X.

# Exercise 1
str_view("$^$", "^\\$\\^\\$$")
# Exercise 2
str_view(words, "^y", match = TRUE)
str_view(words, "x$")
str_view(words, "^...$")
str_view(words,".{7,}")

