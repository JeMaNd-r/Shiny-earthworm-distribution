filter_richness_cells_exclude_no_value <- function(data) {
  data <- data %>%
    filter(!is.na(Change)) %>%
    filter(FutureRichness != 0 & Richness != 0)
  return(data)
}
