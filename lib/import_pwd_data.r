# Imports data from the PWD21 Present Weather Detector at
# Chilbolton Facility for Atmospheric and Radar Research
import_pwd_data <- function(filename, agg=TRUE)
{
  # Open the NetCDF file
  nc = open.ncdf(filename)
  
  # Get the time
  t = get.var.ncdf(nc, "time")
  # Get the visiblity
  v = get.var.ncdf(nc, "vis_10min")
  
  close.ncdf(nc)
  
  # Visibility is provided in metres - we want it in Km.
  v = v/1000  
  
  # Get time as a fraction of the day
  tf = t / max(t)
  
  # Get date bit from the filename
  date_str = substr(filename, nchar(filename)-10, nchar(filename)-3)

  
  # Make in to chron object
  tc = chron(date_str, tf, format=c(dates="ymd", times="h:m:s"),out.format=c(dates = "m/d/y", times = "h:m:s"))
  
  # Convert to zoo object
  z = zoo(v, tc)
  
  if (agg == TRUE) z = aggregate(z, wholemin, head, 1)
  
  return(z)
}