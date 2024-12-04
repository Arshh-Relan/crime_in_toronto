#### Preamble ####
# Purpose: Tests the cleaned hate crimes data for validity and readiness for analysis.
# Author: Arshh Relan
# Date: December 3, 2024
# Contact: arshh.relan@mail.utoronto.ca
# License: MIT

#### Workspace setup ####
library(tidyverse)
library(testthat)

# Load the cleaned dataset
analysis_data <- read_parquet("~/Desktop/starter_folder-main-2/data/02-analysis_data/hate_crimes_data_for_analysis.parquet")

#### Test data ####

# Test that the dataset has rows (non-empty)
test_that("dataset has rows", {
  expect_gt(nrow(analysis_data), 0)
})

# Test that the dataset has 5 columns
test_that("dataset has 5 columns", {
  expect_equal(ncol(analysis_data), 5)
})

# Test that critical columns are present
test_that("critical columns are present", {
  expect_true(all(c("occurrence_year", "occurrence_date", "bias_type", "location_type", "arrest_made") %in% colnames(analysis_data)))
})

# Test that `bias_type` has valid categories
valid_bias_types <- c("Race", "Religion", "Gender", "Sexual Orientation", "Language", "Ethnicity", "Age", "Disability", "Multiple")
test_that("bias_type contains valid categories", {
  expect_true(all(analysis_data$bias_type %in% valid_bias_types))
})

# Test that `location_type` is not empty
test_that("location_type is not empty", {
  expect_false(any(analysis_data$location_type == ""))
})

# Test that `arrest_made` is binary
test_that("arrest_made is binary", {
  expect_true(all(analysis_data$arrest_made %in% c(0, 1)))
})

# Test that `occurrence_year` is within a reasonable range (e.g., 2000 to 2023)
test_that("occurrence_year is in a valid range", {
  expect_true(all(analysis_data$occurrence_year >= 2000 & analysis_data$occurrence_year <= 2023))
})

# Test for missing values
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# Test for duplicate rows
test_that("no duplicate rows in dataset", {
  expect_equal(nrow(analysis_data), nrow(distinct(analysis_data)))
})
