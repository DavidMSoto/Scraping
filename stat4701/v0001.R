
rm(list = ls())


library(rvest)
library(pbapply)
library(TTR)
library(dygraphs)
library(lubridate)

stock.list<-'https://www.loyal3.com/stocks'
stocks<-read_html(stock.list)
stocks.names<-html_nodes(stocks,'.company-name')
stocks.names<-html_text(stocks.names)

