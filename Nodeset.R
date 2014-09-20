library(XML)

accountsTitle <- read.csv('/Users/yasuaki/Documents/XBRLData/1f_copy.csv',header=TRUE,fileEncoding = 'cp932')

instanceFileParser <- function(fullFileName){
  
  fileAttrs <- strsplit(fileName,"-")
  
  #fullFileName <- paste(workDir,fileName,sep="")
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
      }
    
    }
  }
  return(accountsDf)
}