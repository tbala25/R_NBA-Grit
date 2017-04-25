#Scrape and transform data
#Sets directory to my folder to load data set
setwd("/Users/Tejas/Documents/NEU/Fall 2016/DS 4100/project")

#Scraped using Import.io from stats.nba.com

#team data first
teamData <- read.csv("team_stats.csv", header = TRUE, sep = ",")
#get relevant columns: name, win, loss, win pct, min
teamData <- teamData[,c(2,5,6,7,8,42)]

#create team abbreviations
teamAbrv <- list("ATL", "BOS", "BKN", "CHA", "CHI", "CLE", "DAL", "DEN", "DET", 
                 "GSW", "HOU", "IND", "LAC", "LAL", "MEM", "MIA", "MIL", "MIN", "NOP", "NYK", 
                 "OKC", "ORL", "PHI", "PHX", "POR", "SAC", "SAS", "TOR", "UTA", "WAS")
#add team abbreviations to df
teamData$Abrv <- teamAbrv

#reorder columns
teamData <- teamData[,c(7,2,3,4,5,6)]
#rename columns
colnames(teamData) <- c("Team", "Wins", "Losses", "Win %", "MPG", "+/-")
teamData$Team <- as.character(teamData$Team)
#teamData$Team <- as.factor(teamData$Team)

####################################################################################################

#player hustle data

playerData <- read.csv("player_hustle.csv")
playerData <- playerData[,c(2,3,4,5,6,7,8,9,10,11)]
playerData[,2] <- as.character(playerData[,2])
colnames(playerData) <- c("Name", "Team", "Age", "MPG", "Screen Assists", "Deflections", 
                          "Looseballs Recovered", "Charges Drawn", "Contested 2FG", "Contested 3FG")

#rebound data
#created its own DF for data integrity purposes, 
#to make sure all the players line up before integrating columns with playerData
reboundData <- read.csv("rebound_stats.csv")
reboundData <- reboundData[,c(2,4,5,7)]
colnames(reboundData) <- c("Name", "GP", "MPG", "Contested Rebounds")

playerData$`Contested Rebounds` <- reboundData$`Contested Rebounds`
playerData[is.na(playerData)] <- 0

####################################################################################################

calculatePlayerGrit <- function() {
  # #create GRIT statistic
  # 
  playerGrit <- list()
  playerNormGrit <- list()
  
  # arbitrary weights: 1,2,3,3,1,2,1
  
  playerData[,5] <- as.numeric(as.character(playerData[,5]))
  playerData[,6] <- as.numeric(as.character(playerData[,6]))
  playerData[,7] <- as.numeric(as.character(playerData[,7]))
  playerData[,8] <- as.numeric(as.character(playerData[,8]))
  playerData[,9] <- as.numeric(as.character(playerData[,9]))
  playerData[,10] <- as.numeric(as.character(playerData[,10]))
  
  #making GRIT
  for(i in 1:nrow(playerData)) {
    mpg <- playerData[i,4]
    grit <- (playerData[i,5] + 2 * playerData[i,6] + 3 * playerData[i,7] + 
               3 * playerData[i,8] + playerData[i,9] + 2 * playerData[i,10] + playerData[i,11])
    normGrit <- 48 * grit / mpg
    
    playerGrit[[i]] <- grit
    playerNormGrit[[i]] <- normGrit
  }
  
  #adding grit to playerData
  playerData$`GRIT` <- playerGrit
  playerData$`GRIT` <- as.numeric(playerData$`GRIT`)
  playerData$`Normalized GRIT` <- playerNormGrit
  playerData$`Normalized GRIT` <- as.numeric(playerData$`Normalized GRIT`)
  playerData[is.na(playerData)] <- 0
  return(playerData)
}
playerData <- calculatePlayerGrit()

####################################################################################################

calculateTeamGrit <- function() {
  #summing team GRIT
  teamGrit <- list()
  
  for(i in 1:nrow(teamData)) {
    teamName <- teamData[i,1]
    teamGrit[[i]] <- sum(unlist(playerData[playerData[,2] == teamName,12]))
  }
  
  #adding to team data
  teamData$`Team GRIT` <- teamGrit
  teamData$`Team GRIT` <- as.numeric(teamData$`Team GRIT`)
  return(teamData)
}
teamData <- calculateTeamGrit()

#removing objects from workspace
# rm(grit)
# rm(i)
# rm(mpg)
# rm(normGrit)
# rm(playerGrit)
# rm(playerNormGrit)
# rm(teamAbrv)
# rm(teamGrit)
# rm(teamName)

####################################################################################################

#sum other playerData for teamData

calculateTeamStats <- function() {
  sa <- list()
  df <- list()
  lr <- list()
  cd <- list()
  c2 <- list()
  c3 <- list()
  cr <- list()
  
  for(i in 1:nrow(teamData)) {
    teamName <- teamData[i,1]
    sa[[i]] <- sum(unlist(playerData[playerData[,2] == teamName,5]))
    df[[i]] <- sum(unlist(playerData[playerData[,2] == teamName,6]))
    lr[[i]] <- sum(unlist(playerData[playerData[,2] == teamName,7]))
    cd[[i]] <- sum(unlist(playerData[playerData[,2] == teamName,8]))
    c2[[i]] <- sum(unlist(playerData[playerData[,2] == teamName,9]))
    c3[[i]] <- sum(unlist(playerData[playerData[,2] == teamName,10]))
    cr[[i]] <- sum(unlist(playerData[playerData[,2] == teamName,11]))
  }
  
  #adding to team data
  teamData$`Screen Assists` <- sa
  teamData$`Screen Assists` <- as.numeric(teamData$`Screen Assists`)
  teamData$`Deflections` <- df
  teamData$`Deflections` <- as.numeric(teamData$`Deflections`)
  teamData$`Looseballs Recovered` <- lr
  teamData$`Looseballs Recovered` <- as.numeric(teamData$`Looseballs Recovered`)
  teamData$`Charges Drawn` <- cd
  teamData$`Charges Drawn` <- as.numeric(teamData$`Charges Drawn`)
  teamData$`Contested 2FG` <- c2
  teamData$`Contested 2FG` <- as.numeric(teamData$`Contested 2FG`)
  teamData$`Contested 3FG` <- c3
  teamData$`Contested 3FG` <- as.numeric(teamData$`Contested 3FG`)
  teamData$`Contested Rebounds` <- cr
  teamData$`Contested Rebounds` <- as.numeric(teamData$`Contested Rebounds`)
  
  return(teamData)
}

teamData <- calculateTeamStats()




