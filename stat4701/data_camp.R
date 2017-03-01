#https://www.datacamp.com/community/blog/coursera-course-on-computational-finance-with-r#gs.SDsZe7M


# Assign the URL to the CSV file
data_url <- "http://assets.datacamp.com/course/compfin/sbuxPrices.csv"

# Load the data frame using read.csv
sbux_df <- read.csv(data_url,stringsAsFactors = FALSE, header = TRUE)