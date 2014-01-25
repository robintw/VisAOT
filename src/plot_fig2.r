# Figure 2 - Present Weather Detector (PWD) at Chilbolton, vs. local Met O station

pwd <- import_pwd_data("data/PWD/2009/09/cfarr-pwd21_chilbolton_20090919.nc")
meto <- import_meto_data("data/MetOffice/MetOData_All.csv")



index(meto) <- as.POSIXct(index(meto))

meto_day <- as.xts(meto)
meto_day <- meto_day["2009-09-19"]
plot(meto_day)


index(pwd) <- as.POSIXct(index(pwd))
pwd <- as.xts(pwd)

merged <- merge(meto_day, pwd, all=F)
plot(merged, xaxt='n', ylab="Visibility (km)", xlab="Hours", main="")
lines(merged[,2], col='blue', lty=2)
legend("topright", c("UKMO Middle Wallop", "CFARR"), col=c("black", "blue"), lty=c(1, 2))
axis(1, at=index(merged), labels=1:23)
