test_that("richness cells with no value are excluded from dataset", {
  data <- data.frame(
    x = c(1, 2, 3, 4),
    y = c(2, 3, 4, 5),
    FutureRichness = c(10, 11, 0, 12),
    Richness = c(0, 10, 11, 12),
    Change = c(-1, NA, 1, 2)
  )

  result <- filter_richness_cells_exclude_no_value(data)

  expect_false(
    nrow(data) == nrow(result)
  )
  expect_equal(
    result$Richness,
    c(12)
  )
})
