filter_richness_cells_exclude_no_value <- function(data) {
  data <- data %>%
    dplyr::filter(!is.na(Change)) %>%
    dplyr::filter(FutureRichness != 0 & Richness != 0)
  return(data)
}
