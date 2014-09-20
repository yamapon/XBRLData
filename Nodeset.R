library(XML)

accountsTitle <- read.csv('C:/Users/kikuchi/Downloads/1f_copy.csv',header=TRUE)
workDir <- "c:/Users/kikuchi/Downloads/xbrl/work/XBRLData/Attachment/"
fileNameBS <- "0101010-acbs01-tse-acedjpfr-67560-2014-03-31-01-2014-04-24-ixbrl.htm"
fileNamePL <- "0102010-acpl01-tse-acedjpfr-67560-2014-03-31-01-2014-04-24-ixbrl.htm"
fileNameCF <- "0104010-accf01-tse-acedjpfr-67560-2014-03-31-01-2014-04-24-ixbrl.htm"

instanceFileParser <- function(fullFileName){
  
  fileAttrs <- strsplit(fileName,"-")
  
  column <- xpathSApply(xmlData,context,xmlAttrs)
  
  if( length(column) > 0 ){
    value <- xpathSApply(xmlData,context,xmlValue)
    if( length(value) > 0 ){
      columnValue <- c()
      for( j in seq_along(column)){
        if(is.na(match("footnoteRefs",names(strsplit(column[j,],"\n"))))){
          columnValue <- append(columnValue,strsplit(column[j,],"\n"))
        }
      }
      if( is.na(match("sign", names(columnValue))) ){
        columnValue <- append(columnValue,list(sign=c('')))        
      }
      #columnValue <- append(columnValue,list(value=c(as.numeric(sub(",","",value)))))
      columnValue <- append(columnValue,list(value=c(value)))
      accountsDf <- rbind(accountsDf,as.data.frame.list(columnValue,stringsAsFactors = FALSE))
      print(columnValue)         
    }
  
  }
}