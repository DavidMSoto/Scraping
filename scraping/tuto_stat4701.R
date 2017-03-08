
# Scraping the web, 
# - experiments about ? sentimientos 

#http://stat4701.github.io/edav/2015/04/02/rvest_tutorial/


#remove.packages("stringi")
#install.packages("curl")


#rm(list = ls())



#**************************************IMDB

library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")


lego_movie %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()


lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()

lego_movie %>%  html_nodes("table") %>%   .[[1]] %>%   html_table()


# Scrape the website for the cast
cast <- lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()
cast


poster <- lego_movie %>%
  html_nodes("#img_primary img") %>%
  html_attr("src")
poster


review <- lego_movie %>%
  html_nodes("#titleUserReviewsTeaser p") %>%
  html_text()
review

######################## indeed.com 
# # # http session 
# # # # # # # # # # # # 

#rm(list = ls())

Sys.setenv(http_proxy="http://dia2.santanderuk.gs.corp:80")
Sys.getenv("http_proxy")


query = "data science"
loc = "New York"
session <- html_session("http://www.indeed.com")
form <- html_form(session)[[1]]
form <- set_values(form, q = query, l = loc)


submit_form2 <- function(session, form){
  library(XML)
  url <- XML::getRelativeURL(form$url, session$url)
  url <- paste(url,'?',sep='')
  values <- as.vector(rvest:::submit_request(form)$values)
  att <- names(values)
  if (tail(att, n=1) == "NULL"){
    values <- values[1:length(values)-1]
    att <- att[1:length(att)-1]
  }
  q <- paste(att,values,sep='=')
  q <- paste(q, collapse = '&')
  q <- gsub(" ", "+", q)
  url <- paste(url, q, sep = '')
  html_session(url)
}

library(httr)


appendList <- function (x, val)
{
  stopifnot(is.list(x), is.list(val))
  xnames <- names(x)
  for (v in names(val)) {
    x[[v]] <- if (v %in% xnames && is.list(x[[v]]) && is.list(val[[v]]))
      appendList(x[[v]], val[[v]])
    else c(x[[v]], val[[v]])
  }
  x
}


submit_geturl <- function (session, form)
{
  query <- rvest:::submit_request(form)
  query$method <- NULL
  query$encode <- NULL
  query$url <- NULL
  names(query) <- "query"
  
  relativeurl <- XML::getRelativeURL(form$url, session$url)
  basepath <- parse_url(relativeurl)
  
  fullpath <- appendList(basepath,query)
  fullpath <- build_url(fullpath)
  fullpath
}


# Submit form and get new url
session1 <- submit_form2(session, form)

# Get reviews of last company using follow_link()
session2 <- follow_link(session1, css = "#more_9 li:nth-child(3) a")
reviews <- session2 %>% html_nodes(".description") %>% html_text()
reviews


