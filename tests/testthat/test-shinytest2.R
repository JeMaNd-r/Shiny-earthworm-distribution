library(shinytest2)

test_that("app starts", {
  app <- AppDriver$new(
    app_dir = here::here(),
    load_timeout = 300000
  )
})
