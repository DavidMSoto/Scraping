library(rvest)
library(pbapply)
library(TTR)
library(dygraphs)
library(lubridate)

Sys.setenv(http_proxy="http://dia2.santanderuk.gs.corp:80")
Sys.getenv("http_proxy")



stock.list<-'https://www.tradingeconomics.com/'

session <- html_session(stock.list)
form <- html_form(session)[[1]]
form <- set_values(form, q = query, l = loc)



stocks<-read_html(stock.list)
stocks.names<-html_nodes(stocks,'.company-name')
stocks.names<-html_text(stocks.names)