library(httr)
library(jsonlite)
library(future)

baseUrl <- "https://api.weatherapi.com/v1/"
apiKey <- "148193efcfce480cb9591848222809"

#' FetchWeatherData
#'
#' @param queryCity A String
#'
#' @return DataFrame
#' @export FetchWeatherData
#'
#' @examples
#' fetchWeatherData("pakistan")
#'
fetchWeatherData <- function(queryCity) {
  stopifnot(is.character(queryCity))

  url <- paste(baseUrl,"forecast.json?key=",apiKey, "&q=",queryCity, sep="")
  getFutureRes <- future(GET(url))
  resValue <- value(getFutureRes)
  content <- content(resValue, "text")
  dat <- jsonlite::fromJSON(content, flatten = TRUE)$forecast$forecastday$hour
  dataframeObj <- as.data.frame(dat)[ ,2:3]
  return(dataframeObj)
}


#' FetchCurrentWeather
#'
#' @param queryCity A String
#'
#' @return A DataFrame
#' @export FetchCurrentWeather
#'
#' @examples
#' fetchCurrentWeather("Pakistan")
#'
fetchCurrentWeather <- function(queryCity) {

  stopifnot(is.character(queryCity))

  url <- paste(baseUrl,"current.json?key=",apiKey, "&q=",queryCity, sep="")
  getFutureRes <- future(GET(url))
  resValue <- value(getFutureRes)
  content <- content(resValue, "text")
  dat <- jsonlite::fromJSON(content, flatten = TRUE)$current$temp_c
   dataframeObj <- as.data.frame(dat)
   colnames(dataframeObj) <- c("Current Temperature In Degree")
  return(dataframeObj)
}


