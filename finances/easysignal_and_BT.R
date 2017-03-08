rm(list = ls())
#https://www.quantinsti.com/blog/an-example-of-a-trading-strategy-coded-in-r/

#good good 
#http://faculty.washington.edu/gyollin/docs/rFinancialData.pdf


#Monitoring an ETF Portfolio in R
#http://gtog.github.io/finance/2013/07/22/implementing-swensen-in-R/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+FromGuinnessToGARCH+%28From+Guinness+to+GARCH%29

require(quantmod)
require(PerformanceAnalytics)

getSymbols('TSLA')
#chartSeries(NSEI, TA=NULL)

data=TSLA[,4]
macd = MACD(data, nFast=12, nSlow=26,nSig=9,maType=SMA,percent = FALSE)
#chartSeries(data, TA='addMACD()')
signal = Lag(ifelse(macd$macd < macd$signal, -1, 1))
returns = ROC(data)*signal
returns = returns['2016-01-01/2016-12-31']
portfolio = exp(cumsum(returns))
plot(portfolio)
table.Drawdowns(returns, top=10)
table.DownsideRisk(returns)
charts.PerformanceSummary(returns)


#Monitoring an ETF Portfolio in R
#http://gtog.github.io/finance/2013/07/22/implementing-swensen-in-R/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+FromGuinnessToGARCH+%28From+Guinness+to+GARCH%29



library(quantmod)
library(PerformanceAnalytics)

s <- get(getSymbols('SPY'))["2012::"]
s$sma20 <- SMA(Cl(s) , 20)
s$position <- ifelse(Cl(s) > s$sma20 , 1 , -1)
myReturn <- lag(s$position) * dailyReturn(s)  # http://www.quantmod.com/documentation/Lag.html
charts.PerformanceSummary(cbind(dailyReturn(s),myReturn))