#http://www.quantmod.com/examples/charting/

library(TTR)  
library(quantmod)
rm(list = ls())

 getSymbols("TSLA") #Goldman OHLC from yahoo

 chartSeries(TSLA) 
 
 barChart(SAN.MC,theme='white.mono',bar.type='hlc')
 candleChart(SAN.MC,multi.col=TRUE,theme='white')
 candleChart(TSLA,subset='2013-12::2017') 
 
 hartSeries(GS, theme="white") #draw the chart
 addVo() #add volume
 addBBands() #add Bollinger Bands
 addCCI() #add Commodity Channel Index 