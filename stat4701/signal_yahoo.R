
# Analizar ibex 35, nasdaq .. ftse 100



rm(list = ls())


library(TTR) #  **
library(rvest)
library(pbapply)
library(TTR)
library(dygraphs)
library(lubridate)



startDate<-Sys.Date()
endDate<-Sys.Date()-years(3)

startDate<-gsub('-','', startDate)
endDate<-gsub('-','', endDate)

tickers = c("BRF", "SAN.MC")


stocksTS<-pblapply(tickers,getYahooData,endDate, startDate)


plot(stocksTS[[1]]$Close)
bbands <- BBands( stocksTS[[1]][,c("High","Low","Close")] )


dygraph(stocksTS[[1]]$Close, main = "TWTR Stock Price") %>%    dyRangeSelector(dateWindow = c("2013-12-18", "2016-12-30"))

head(SMA(stocksTS[[1]]$Close, 200))
head(SMA(stocksTS[[1]]$Close, 50))

bbands <- BBands( stocksTS[[1]][,c("High","Low","Close")] )

mov.avgs<-function(stock.df){
  stock.close<-stock.df[,4]
  ifelse((nrow(stock.df)<(2*260)),
         x<-data.frame(stock.df, 'NA', 'NA'),
         x<-data.frame(stock.df, SMA(stock.close, 200), SMA(stock.close, 50)))
  colnames(x)<-c(names(stock.df), 'sma_200','sma_50')
  x<-x[complete.cases(x$sma_200),]
  return(x)
}


stocksTS <- pblapply(stocksTS, mov.avgs)


dygraph(stocksTS[[1]][,c('sma_200','sma_50')],main = 'brf Moving Averages') %>%
  dySeries('sma_50', label = 'sma 50') %>%
  dySeries('sma_200', label = 'sma 200') %>%
  dyRangeSelector(height = 30) %>%
  dyShading(from = '2016-4-28', to = '2016-7-27', color = '#CCEBD6') %>%
  dyShading(from = '2016-7-28', to = '2016-12-30', color = '#FFE6E6')


