
## rvest data ----
library(rvest)

Sys.setenv(http_proxy="http://dia2.santanderuk.gs.corp:80")
Sys.getenv("http_proxy")

#rvest for scrappping ? 

x <- read_html("http://etfdb.com/type/sector/materials/")

#

#So, this package only works for static web page, should i use rselenim ?

x %>% html_node("script") %>% html_text()

grepl('GDX', x, ignore.case=F)

pos = regexpr('GDX', x) # Returns position of 1st match in a string


substr(x, first, last)


#http://brooksandrew.github.io/simpleblog/articles/scraping-with-selenium/


library('RSelenium')
checkForServer() # search for and download Selenium Server java binary.  Only need to run once.
startServer() # run Selenium Server binary
remDr <- remoteDriver(browserName="firefox", port=4444) # instantiate remote driver to connect to Selenium Server
remDr$open(silent=T) # open web browser


## yahoo data -----

TES = c("CHOC")
data.source = c("yahoo")

library(quantmod, warn.conflicts = FALSE, quietly = TRUE)
library(PerformanceAnalytics, warn.conflicts = FALSE, quietly = TRUE)
library(knitr, warn.conflicts = FALSE, quietly = TRUE)

TES = c("CHOC")
data.source = c("yahoo")
suppressWarnings(getData(TES, data.source))


getData<-function(tickers,datasrc){
  for (i in 1:length(tickers)){
    cat(tickers[i],i,"\n")
    getSymbols(tickers[i],src=datasrc,
               auto.assign=getOption("getSymbols.auto.assign",TRUE),
               env=parent.frame())
  }
}