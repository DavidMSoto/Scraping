rm(list = ls())

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