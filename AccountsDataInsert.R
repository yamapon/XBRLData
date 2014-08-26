library("RSQLite")
library("RJSONIO")

dbd <- dbDriver("SQLite")
dbFile <- "C:/Users/kikuchi/Downloads/accountsDb.db"

accountsDataInsert<-function(accountsDf){

  jsonText<-toJSON(accountsDf)
  dbCon<-dbConnect(dbd,dbFile)
  
  statement = paste( "Insert into t_accounts ( jsonText ) values ('",toJSON(accountsDf),"');",sep="")
  rst<-dbSendQuery(dbCon,statement)
  
  dbDisconnect(dbCon)
  
}
