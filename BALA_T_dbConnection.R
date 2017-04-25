#Loads library to connect with MySQL DB
library(RMySQL)

#creates DB connection
mydb = dbConnect(
  MySQL(),
  user = 'root',
  password = 'root',
  dbname = 'ds4100_project',
  host = 'localhost'
)
#Test that proper db is loaded
dbListTables(mydb)

dbWriteTable(
  mydb,
  value = teamData,
  name = "Teams",
  overwrite = TRUE,
  row.names = F,
  header = FALSE
)

dbWriteTable(
  mydb,
  value = playerData,
  name = "Players",
  overwrite = TRUE,
  row.names = F,
  header = FALSE
)


#get calls
winPct <- dbGetQuery(mydb, "SELECT `WIN %` FROM Teams")
teamGRIT <- dbGetQuery(mydb, "SELECT `Team GRIT` FROM Teams")
normPlayerGRIT <- dbGetQuery(mydb, "SELECT `Normalized GRIT` FROM Players")

