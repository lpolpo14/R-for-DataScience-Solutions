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

# Exercise 1
str_view(words, "^[aeyuio]")
str_view(words, "^[^aeyuio]+$")
str_view(words, "[^e]ed$")
str_view(words,"(ize|ing)$")

# Exercise 2
str_view(words, ".*ie.*")
str_view(words, ".*cei.*")

# Exercise 3
str_view(words, ".*q[^u].*")  # Always false
str_view(words, ".*q[u].*")

# Exercise 4
str_view(words, ".*or$")

# Exercise 5 Skipping this one.

# Exercise 1 ? = {0,1} * = {0,}, + = {1,} 

# Exercise 2

str_view(words, "^.*$") # Anything
str_view("{anything}", "\\{.+\\}")
str_view("1999-99-99","\\d{4}-\\d{2}-\\d{2}") # Date albeit weird
str_view("\\\\\\\\","\\\\{4}")

# Exercise 3

str_view(words, "^[^euioa]{3,}.*")
str_view(words, ".*[euioa]{3,}.*")
str_view(words, ".*([^euioa][euioa]){2}.*")

# Exercise 4 https://regexcrossword.com

# Exercise 1
str_view("aaabca","(.)\\1\\1") # Three repeating characters (Or number 1s if you don't change \1)
str_view("abba", "(.)(.)\\2\\1")
str_view("abab","(..)\\1")
str_view("aXaXa", "(.).\\1.\\1")
str_view("ABC_anythinghere_CBA","(.)(.)(.).*\\3\\2\\1")

# Exercise 2

str_view(words, "^(.).*\\1$")
str_view(words, ".*(..).*\\1.*")
str_view(words, ".*(.).*\\1.*\\1.*")
