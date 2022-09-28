library(testthat)
library(httr)
library(jsonlite)
library(future)

test_that("Input check doesnot works for fetchWeatherData()", {
  expect_error(fetchWeatherData(12))
})

test_that("Output check works for fetchWeatherData()", {
  # a <- 3
  # repeat {
  #   result <- fetchWeatherData("sweden")
  #   a <- a - 1
  #   if (a < 1) {
  #     stop()
  #   }
  # }
  result <- fetchWeatherData("sweden")
  expect_true(is.data.frame(result))
  expect_true(is.data.frame(result))
  expect_equal(colnames(result)[1],"time")
})
