#test script
library(testthat)

#source in functions to be tested
source('functions.R')

#Vectors to be used throughout
a <- c(1, 4, 7, NA, 10)
b <- c(1, 4, 7, NA, 10, 13, 16, NA, 19, NA, NA, 22, NA)
c <- c(NA, NA, 4, 5, 1, NA)
d <- c(18, 15, 16, 4, 17, 9)

context("Minimum")

test_that("get_minimum returns the smallest number in a vector", {
  expect_equal(get_minimum(a, na.rm = TRUE), 1)
  expect_equal(get_minimum(b, na.rm = TRUE), 1)
  expect_equal(get_minimum(c, na.rm = TRUE), 1)
  expect_equal(get_minimum(d, na.rm = TRUE), 4)
})

test_that("get_minimum")