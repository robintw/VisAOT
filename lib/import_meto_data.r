import_meto_data <- function(filename)
{
  df = read.table(filename, sep=",", header=T, na.strings=c("", " "), blank.lines.skip=T, quote="", as.is=T, comment.char="", flush=T)
  
  dups = duplicated(df$ob_time)
  
  # Keep the ones which AREN'T duplicated
  df <- subset(df, !dups)
  
  df$ob_date <- substr(df$ob_time, 0, 10)
  df$ob_time_clock <- substr(df$ob_time, 11,16)
  df$ob_time_clock <- paste(df$ob_time_clock, "00", sep=":")
  
  #browser()
  
  z = zoo(df$visibility/100, chron(df$ob_date, df$ob_time_clock, format=c(dates = "d/m/y", times="h:m:s")))

  return(z)  
}