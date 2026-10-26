library(shinytest2)

test_that("Species selection changes species plot", {
  app <- AppDriver$new(
    app_dir = here::here(),
    load_timeout = 300000
  )
  app$expect_values()
  
  app$set_inputs(species = "Dendr_octa")
  app$expect_values()
})
