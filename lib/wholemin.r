# Converts a time to the previous time in whole minutes. Eg: 15:41:40 goes to 15:41:00.
wholemin <- function(x) trunc(x, units="minutes")