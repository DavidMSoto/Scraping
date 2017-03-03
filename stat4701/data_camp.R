#http://www.quantmod.com/examples/charting/

library(TTR)   **
rm(list = ls())

 getSymbols("GS") #Goldman OHLC from yahoo

 chartSeries(GS) 