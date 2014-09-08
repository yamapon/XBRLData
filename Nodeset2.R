library(XML)

accountsTitle <- read.csv('C:/Users/kikuchi/Downloads/1f_copy.csv',header=TRUE)
fileName = "C:/Users/kikuchi/Downloads/xbrl/work/tdnet-qcedjpfr-43310-2013-09-30-01-2013-11-08.xbrl"

makeAccountsDataFrameOldver <- function( fullFileName ){
  
  doc <- xmlInternalTreeParse(fullFileName,useInternalNodes = TRUE)
  xmlData <- xmlRoot(doc)
  
  accountsDf <- data.frame()
  for( i in seq_along(accountsTitle$element)){
    item <- paste('jpfr-t-cte:',accountsTitle$element[i],sep="")  
    
    context <- paste("//",item,"[@contextRef='CurrentQuarterConsolidatedInstant' and not(@xsi:nil) ]",sep="")
    
    column <- xpathSApply(xmlData,context,xmlAttrs)
    
    if( length(column) > 0 ){
      value <- xpathSApply(xmlData,context,xmlValue)
      if( length(value) > 0 ){
        columnValue <- c()
        columnValue <- append(columnValue,list(name=c(as.character(accountsTitle$element[i]))))
        for( j in seq_along(column)){
          if(is.na(match("footnoteRefs",names(strsplit(column[j,],"\n"))))){
            columnValue <- append(columnValue,strsplit(column[j,],"\n"))
          }
        }
        columnValue <- append(columnValue,list(value=c(as.numeric(value))))
        accountsDf <- rbind(accountsDf,as.data.frame.list(columnValue,stringsAsFactors = FALSE))
      }
      
    }
  }
  print(accountsDf)
}

result <- makeAccountsDataFrameOldver(fileName)
print(result)
