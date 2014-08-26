library("RSQLite")
library("RJSONIO")

dbd <- dbDriver("SQLite")
dbFile <- "C:/Users/kikuchi/Downloads/accountsDb.db"
dbCon<-dbConnect(dbd,dbFile)

statement = paste( "Select elements from t_accounts where code = ",code , sep="")
rst<-dbSendQuery(dbCon,statement)

data<-fetch(rst)
accountsDf<-fromJSON(data.frame(data))

dbDisconnect(dbCon)
