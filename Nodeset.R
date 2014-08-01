library(SQLite)
library(XML)

accountsTitle <- read.csv('C:/Users/kikuchi/Downloads/1f_copy.csv',header=TRUE)
workDir <- "c:/Users/kikuchi/Downloads/xbrl/work/XBRLData/Attachment/"
fileName <- "0101010-acbs01-tse-acedjpfr-67560-2014-03-31-01-2014-04-24-ixbrl.htm"

fileAttrs <- strsplit(fileName,"-")

fullFileName <- paste(workDir,fileName,sep="")
doc <- xmlInternalTreeParse(fullFileName,useInternalNodes = TRUE)
xmlData <- xmlRoot(doc)

for( i in 1:length(accountsTitle$element)){
  item <- paste(accountsTitle$prefix[i],':',accountsTitle$element[i],sep="")  
  context <- paste("//*[@name='",item,"']",sep="")
  attrs <- xpathSApply(xmlData,context,xmlAttrs)
  if( lenght(attrs) > 0 ){
    value <- xpathSApply(result,xmlValue)
  }
}
