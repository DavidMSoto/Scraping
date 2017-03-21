
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

library('httr')
url <- 'http://etfdb.com/type/sector/all/'
page <- GET(url)
print(http_status(page)) 
page_text <- content(page, as='text')

grepl('VGT', page_text, ignore.case=T)

grepl('Vanguard', page_text, ignore.case=T)


library('RSelenium')
checkForServer() # search for and download Selenium Server java binary.  Only need to run once.
startServer() # run Selenium Server binary
remDr <- remoteDriver(browserName="firefox", port=4444) # instantiate remote driver to connect to Selenium Server
remDr$open(silent=T) # open web browser



library('XML')
master <- c()
n <- 5 # number of pages to scrape.  80 pages in total.  I just scraped 5 pages for this example.
for(i in 1:n) {
  site <- paste0("http://etfdb.com/type/sector/all/#etfs__overview&sort_name=assets_under_management&sort_order=desc&page=",i) # create URL for each page to scrape
  remDr$navigate(site) # navigates to webpage
  
  elem <- remDr$findElement(using="id", value="tbody") # get big table in text string
  elem$highlightElement() # just for interactive use in browser.  not necessary.
  elemtxt <- elem$getElementAttribute("outerHTML")[[1]] # gets us the HTML
  elemxml <- htmlTreeParse(elemtxt, useInternalNodes=T) # parse string into HTML tree to allow for querying with XPath
  fundList <- unlist(xpathApply(elemxml, '//input[@title]', xmlGetAttr, 'title')) # parses out just the fund name and ticker using XPath
  master <- c(master, fundList) # append fund lists from each page together
}




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