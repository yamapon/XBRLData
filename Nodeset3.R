library(XML)

accountsTitle <- read.csv('C:/Users/kikuchi/Downloads/1f_copy.csv',header=TRUE)
fileName = "C:/Users/kikuchi/Downloads/xbrl/work/XBRLData/Attachment/0201010-anbs01-tse-acedjpfr-95310-2014-03-31-01-2014-04-28-ixbrl.htm"

makeAccountsDataFrameNewver <- function( fullFileName ){
  
  fileInformation <- strsplit(fullFileName, "-")
  doc <- xmlInternalTreeParse(fullFileName,useInternalNodes = TRUE)
  xmlData <- xmlRoot(doc)
  
  accountsDf <- data.frame()
  for( i in seq_along(accountsTitle$element)){
    item <- paste(accountsTitle$prefix[i],':',accountsTitle$element[i],sep="")  
    
    context <- paste("//*[@name='",item,"' and @contextRef='CurrentYearDuration' and not(@xsi:nil) ]",sep="")
    
    column <- xpathSApply(xmlData,context,xmlAttrs)
    
    if( length(column) > 0 ){
      value <- xpathSApply(xmlData,context,xmlValue)
      if( length(value) > 0 ){
        columnValue <- c()
        columnValue <- append(columnValue,list(name=c(as.character(accountsTitle$element[i]))))
        for( j in seq_along(column)){
          if(is.na(match("footnoteRefs",names(strsplit(column[j,],"\n"))))
             && is.na(match("contextRef",names(strsplit(column[j,],"\n"))))             
             && is.na(match("name",names(strsplit(column[j,],"\n"))))
             && is.na(match("scale",names(strsplit(column[j,],"\n"))))
             && is.na(match("format",names(strsplit(column[j,],"\n"))))){
            columnValue <- append(columnValue,strsplit(column[j,],"\n"))
          }
        }
        if( is.na(match("sign", names(columnValue))) ){
          columnValue <- append(columnValue,list(sign=c('')))        
        }
        columnValue <- append(columnValue,list(value=c(as.numeric(gsub(",","",value)))))
        accountsDf <- rbind(accountsDf,as.data.frame.list(columnValue,stringsAsFactors = FALSE))
      }
      
    }
  }
  print(accountsDf)
}

result <- makeAccountsDataFrameNewver(fileName)
print(result)
