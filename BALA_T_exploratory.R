winPct <- unlist(winPct)
winPct <- as.numeric(winPct)
winHist <- hist(winPct)
winPctMean <- mean(winPct)

teamGRIT <- unlist(teamGRIT)
teamGRIT <- as.numeric(teamGRIT)
teamGritHist <- hist(teamGRIT)
teamGritMean <- mean(teamGRIT)

gritWin <- plot(teamGRIT,winPct)
regression <- lm(winPct ~ teamGRIT)
abline(regression)
summary(regression)