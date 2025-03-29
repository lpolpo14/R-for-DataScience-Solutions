library(tidyverse)

# Exercise 1
# I'd use read_delim with delimiter set to '|'

# Exercise 2 : ?read_csv and ?read_tsv have in c common:  file, col_names = TRUE, col_types = NULL, 
# col_select = NULL, id = NULL, locale = default_locale(), na = c("", "NA"), quoted_na = TRUE, quote = "\"",
# comment = "", trim_ws = TRUE, skip = 0, n_max = Inf, guess_max = min(1000, n_max), name_repair = "unique", 
# num_threads = readr_threads(), progress = show_progress(), show_col_types = should_show_types(),
# skip_empty_rows = TRUE, lazy = should_read_lazy()

# Exercise 3 : Using ?read_fwf : File is a must, col_positions using fwf_empty or widths or 
# positions, and col_names.

# Exercise 4: 

read_delim("x,y\n1,'a,b'", delim = ',', quote = "\'")


# Exercise 5:
# a - name of third column is missing
# b : second and third row have wrong number of columns
# c : Missing Parameter since not seperated by, Also it starts a quote that never ends.
read_csv("a,b\n\"1")
# d : Different variable type, still works though.
read_csv("a,b\n1,2\na,b")
# e : Wrong delimiter, Still works in a way.
read_csv("a;b\n1;3")

# Exercise 1 : encoding, data_names, decimal_marl (for the time being)

# Exercise 2 - Let's find out

parse_double("100000.534", locale = locale(grouping_mark = ".")) # Parsing Failure
parse_double("100000,534", locale = locale(decimal_mark = ",")) # Parsing Failure
# It ultimately depends on how you use them. They may overwrite or not. Experiment

# Exercise 3 Example :
parse_date("01/02/15", locale = locale(date_format = "%m/%d/%y")) # doesn't work

# Exercise 4 : I live in Europe, but the university most of the time gives us Locale
# files based on the american system due to the amount of data available there.

# Exercise 5 : Like we said before, csv2 uses ; as a delimeter for countries that use
# , instead of . for the decimal point.

# Exercise 6 : UTF8 Beats all.

# Exercise 7
parse_date("January 1, 2010", "%B %d, %Y")
parse_date("2015-Mar-07", "%Y-%b-%d")
parse_date("06-Jun-2017", "%d-%b-%Y")
parse_date(c("August 19 (2015)", "July 1 (2015)"), "%B %d (%Y)")
parse_date("12/30/14", "%m/%d/%y") 
parse_time("1705", "%H%M")
parse_time("11:15:10.12 PM", "%I:%M:%OS %p")




