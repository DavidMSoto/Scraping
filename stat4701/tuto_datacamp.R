
#https://www.datacamp.com/community/tutorials/r-trading-tutorial#gs.am56FrE

rm(list = ls())


library(rvest)
library(pbapply)
library(TTR)
library(dygraphs)
library(lubridate)

Sys.setenv(http_proxy="http://dia2.santanderuk.gs.corp:80")
Sys.getenv("http_proxy")

stock.list<-'http://www.tradingeconomics.com/'
stocks<-read_html(stock.list)
stocks.names<-html_nodes(stocks,'.company-name')
stocks.names<-html_text(stocks.names)


session <- html_session("http://www.tradingeconomics.com/")
form <- html_form(session)[[1]]
form <- set_values(form, q = query, l = loc)
