# TODO: Add comment
# 
# Author: davidmonteagudo
###############################################################################



setwd("/Users/davidmonteagudo/git/")

url = 		 "http://etfdb.com/type/sector/all/#etfs__overview&sort_name=assets_under_management&sort_order=desc&page="

for (i in 1:5) {system(sprintf("./phantomjs-2.1.1-macosx/bin/phantomjs ./Scraping/blog/scrape_etf.js %s%d", url, i))}









