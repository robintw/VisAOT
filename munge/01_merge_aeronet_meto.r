aeronet <- import_aeronet_data("data/AERONET/lev20/050101_131231_Chilbolton.lev20")
meto <- import_meto_data("data/MetOffice/MetoData_2003_2013.csv")

index(meto) <- as.POSIXct(index(meto))
index(aeronet) <- as.POSIXct(index(aeronet))

ind <- index(aeronet)
rounded <- round_date(ind, 'hour')
time_diffs <- abs(ind - rounded) / 60
aeronet_sub <- aeronet[time_diffs < 15]
index(aeronet_sub) <- round_date(index(aeronet_sub), "hour")

# Options::
# Remove duplicates
#aeronet_sub <- aeronet_sub[!duplicated(aeronet_sub)]
# Use mean of observations at the same time
aeronet_sub <- aggregate(aeronet_sub, index(aeronet_sub), mean)
merged <- merge(aeronet_sub, meto, all=FALSE)

names(merged) <- c('aeronet', 'meto')


merged = merged[merged$meto >= 0.5]

cache('merged')