# Plots Fig 1 - AOTs calculated by all methods for a range of visibilities

vis = seq(1, 50, 0.1)
k <- vis2aot_k(vis)
plot(vis, k, type='l', xlab="Horizontal visibility (km)", ylab="AOT", lty=1, col='red')
v6s <- vis2aot_sixs(vis)
lines(vis, v6s, lty=2, col='blue')
vv <- vis2aot_modtran(vis)
lines(vis, vv, lty=5, col='black')
legend('topright', c("Koschmieder", "6S", "MODTRAN"), lty=c(1, 2, 5), col=c('red', 'blue', 'black'))