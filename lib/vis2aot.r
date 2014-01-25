vis2aot_vermote <- function(vis) {
  aot = (3.9449 / vis) + 0.08498
  
  return(aot)
}

vis2aot_k <- function(vis) {
  aot = (3.912 / vis)
  
  return(aot)
}

vis2aot_sixs <- function(vis) {
  # vertical repartition of aerosol density for v=23km
  #                 (in number of particles per cm3)
   an23 = c(2.828e+03,1.244e+03,5.371e+02,2.256e+02,1.192e+02
  ,8.987e+01,6.337e+01,5.890e+01,6.069e+01,5.818e+01,5.675e+01
  ,5.317e+01,5.585e+01,5.156e+01,5.048e+01,4.744e+01,4.511e+01
  ,4.458e+01,4.314e+01,3.634e+01,2.667e+01,1.933e+01,1.455e+01
  ,1.113e+01,8.826e+00,7.429e+00,2.238e+00,5.890e-01,1.550e-01
  ,4.082e-02,1.078e-02,5.550e-05,1.969e-08,0.000e+00)
  
  # vertical repartition of aerosol density for v=5km
  #                 (in number of particles per cm3)
   an5 = c(1.378e+04,5.030e+03,1.844e+03,6.731e+02,2.453e+02
  ,8.987e+01,6.337e+01,5.890e+01,6.069e+01,5.818e+01,5.675e+01
  ,5.317e+01,5.585e+01,5.156e+01,5.048e+01,4.744e+01,4.511e+01
  ,4.458e+01,4.314e+01,3.634e+01,2.667e+01,1.933e+01,1.455e+01
  ,1.113e+01,8.826e+00,7.429e+00,2.238e+00,5.890e-01,1.550e-01
  ,4.082e-02,1.078e-02,5.550e-05,1.969e-08,0.000e+00)
  
   # Altitude (z) levels
   z = c(0.,    1.,    2.,    3.,    4.,    5.,    6.,    7.,    8.,
   9.,   10.,   11.,   12.,   13.,   14.,   15.,   16.,   17.,
  18.,   19.,   20.,   21.,   22.,   23.,   24.,   25.,   30.,
  35.,   40.,   45.,   50.,   70.,  100.,99999.)
     
   aot = 0.0
   sigma = 0.056032
   
#    if (any(vis <= 0))
#    {
#      return()
#    }
   
   # Numerically integrate over each layer of the atmosphere summing the
   # calculated AOT
   
   for (k in 1:32)
   {
     # Calculate dz (the difference on the x axis)
     dz = z[k+1] - z[k]
     
     # Get the points on the curve for both ends of dz
     point_left_5 = an5[k]
     point_right_5 = an5[k+1]
     
     point_left_23 = an23[k]
     point_right_23 = an23[k+1]
     
     # Calculate the difference
     diff_left = (115.0/18.0) * (point_left_5 - point_left_23)
     diff_right = (115.0/18.0) * (point_right_5 - point_right_23)
     
     # Convert from per Km back to Km
     diff_left_km = (5.0 * point_left_5/18.0) - (23.0 * point_left_23/18.0)
     diff_right_km = (5.0 * point_right_5/18.0) - (23.0 * point_right_23/18.0)
     
     # Use interpolation formula from the docs (uses -b(z) as shown in FORTRAN code rather than +b(z) as in manual)
     interp_left = diff_left/vis - diff_left_km
     interp_right = diff_right/vis - diff_right_km
     
     # Calculate AOT for this level
     ev = dz * exp( (log(interp_left)+log(interp_right)) * 0.5)
     aot = aot + (ev * sigma * 1.0e-03)
   }
   return(aot)
}

data <- read.csv("data/MODTRAN_VisAOT.csv")
vis2aot_modtran <- approxfun(data$vis, data$aot)
