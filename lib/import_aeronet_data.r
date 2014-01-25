# Function to take the first two cols of data and convert to one Date/Time
f <- function(d, t) as.chron(paste(as.Date(chron(d, format='d:m:y')), t))

# Takes aeronet data and returns a zoo class.
# If agg is TRUE then the data is aggregated to the nearest minute.
import_aeronet_data <- function(filename, agg=TRUE)
{
  colClasses <- c("character", "character", rep("NULL", 10), "numeric", rep("NULL",32))
  r = read.zoo(filename, sep=',', na.strings = "N/A", header=T, skip=4, index = 1:2, FUN=f, colClasses=colClasses, as.is=F, dec=".")
  
  #plot(mw16s$hour, mw16s$newAOT, type='l')
if (agg == TRUE) r = aggregate(r, wholemin, head, 1)
  
  return(r)
}

