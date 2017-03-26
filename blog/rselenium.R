# TODO: Add comment
# 
# Author: davidmonteagudo
###############################################################################


library('RSelenium')

"docker run -d -p 4445:4444 selenium/standalone-firefox:2.53.0"

remDr <- remoteDriver(port = 4445L)

library('XML')

for (i in 1:20) 
{
 url =  paste0("http://etfdb.com/type/sector/all/#etfs__overview&sort_name=assets_under_management&sort_order=desc&page=1",i)
 remDr$open()
 remDr$navigate(url)
 html <- unlist(remDr$getPageSource())
 tbl<-rbind(readHTMLTable(html)[[2]])
 print(head(tbl$`\nSymbol\n`))
 print(i)
 
}


 saveRDS(tbl, file.path(getwd(), "tbl.rds"))
 
 train <- readRDS(paste0(getwd(),"/tbl.rds"))