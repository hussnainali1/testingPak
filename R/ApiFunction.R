library(httr)
library(jsonlite)
library(future)

baseUrl <- "https://api.weatherapi.com/v1/forecast.json"

fetchWeatherData <- function(queryCity) {
  apiKey <- "148193efcfce480cb9591848222809"
  url <- paste(baseUrl,"?key=",apiKey, "&q=",queryCity, sep="")
  getFutureRes <- future(GET(url))
  resValue <- value(getFutureRes)
  content <- content(resValue, "text")
  dat <- jsonlite::fromJSON(content, flatten = TRUE)$forecast$forecastday$hour
  dataframeObj <- as.data.frame(dat)[ ,2:3]
  return(dataframeObj)
}

fetchWeatherData("sweden")

