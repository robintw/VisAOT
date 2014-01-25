merged$kosch = vis2aot_k(merged$meto)
merged$sixs <- vis2aot_sixs(merged$meto)
merged$modtran <- vis2aot_modtran(merged$meto)

merged$err_kosch <- merged$kosch - merged$aeronet
merged$err_sixs <- merged$sixs - merged$aeronet
merged$err_modtran <- merged$modtran - merged$aeronet

ranges = seq(0, 40, 10)

ranges <- c(ranges, 100)

rmses <- data.frame(kosch_rmse=rep(NA, length(ranges)-1),
                    kosch_avg=rep(NA, length(ranges)-1),
                    kosch_m=rep(NA, length(ranges)-1),
                    kosch_prop_over=rep(NA, length(ranges)-1),
                    sixs_rmse=rep(NA, length(ranges)-1),
                    sixs_avg=rep(NA, length(ranges)-1),
                    sixs_m=rep(NA, length(ranges)-1),
                    sixs_prop_over=rep(NA, length(ranges)-1),
                    modtran_rmse=rep(NA, length(ranges)-1),
                    modtran_avg=rep(NA, length(ranges)-1),
                    modtran_m=rep(NA, length(ranges)-1),
                    modtran_prop_over=rep(NA, length(ranges)-1),
                    avg_vis=rep(NA, length(ranges)-1),
                    sd_aot=rep(NA, length(ranges)-1),
                    avg_aot=rep(NA, length(ranges)-1))

for (i in 2:length(ranges)-1)
{
  if (ranges[i] == 999)
  {
    low = 0
    high = 9999
  }
  else
  {
    low <- ranges[i]
    high <- ranges[i+1]
  }

  
  sub_df <- subset(merged, merged$meto >= low & merged$meto < high)
  
  rmses[i,]$kosch_rmse <- rmse(sub_df$err_kosch)
  rmses[i,]$kosch_avg <- mean(sub_df$err_kosch)
  rmses[i,]$kosch_m <- as.numeric(coef(lm(sub_df$kosch ~ sub_df$aeronet + 0))[1])
  rmses[i,]$kosch_prop_over <- sum(sub_df$err_kosch > 0)/nrow(sub_df)
  
  rmses[i,]$sixs_rmse <- rmse(sub_df$err_sixs)
  rmses[i,]$sixs_avg <- mean(sub_df$err_sixs)
  rmses[i,]$sixs_m <- as.numeric(coef(lm(sub_df$sixs ~ sub_df$aeronet + 0))[1])
  rmses[i,]$sixs_prop_over <- sum(sub_df$err_sixs > 0)/nrow(sub_df)
  
  rmses[i,]$modtran_rmse <- rmse(sub_df$err_modtran)
  rmses[i,]$modtran_avg <- mean(sub_df$err_modtran)
  rmses[i,]$modtran_m <- as.numeric(coef(lm(sub_df$modtran ~ sub_df$aeronet + 0))[1])
  rmses[i,]$modtran_prop_over <- sum(sub_df$err_modtran > 0)/nrow(sub_df)
  
  rmses[i,]$avg_vis <- mean(sub_df$meto)
  rmses[i,]$avg_aot <- mean(sub_df$aeronet)
  rmses[i,]$sd_aot <- sd(sub_df$aeronet)
}

cache('rmses')
