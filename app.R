#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# - - - - - - - - - - - - - - - - - - - - - - - - - -
# DEAR USER: Running the app will take some seconds due to the size of the
#            datasets that will be loaded before starting the GUI.
# - - - - - - - - - - - - - - - - - - - - - - - - - -

library(shiny)
library(bslib)
library(tidyverse)
library(maps)

cat("# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #\n")
cat("# DEAR USER: Running the app will take some second due to the size  #\n")
cat("#   of the datasets that will be loaded before starting the GUI.    #\n")
cat("# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - #\n")
cat("# If you can't allocate large vectors, clean your environment: gc() #\n")


load("data/richness_df.RData") # richness_df
load("data/species_df.RData") # species_df
load("data/uncertain_df.RData") # uncertain_df

richness_df <- filter_richness_cells_exclude_no_value(richness_df)

# Define parameters used later
year_df <- data.frame(
  "year" = c("Current", "Future (2041-2070)", "Change F-C"),
  "column" = c("Richness", "FutureRichness", "Change_f")
)

world.inp <- map_data("world")

# Define UI for application that draws a histogram
ui <- page_sidebar(
  # Application title
  title = "Distribution of earthworm species in Europe",

  # Sidebar with a slider input for number of bins
  sidebar = sidebar(
    tags$h3("Richness in Europe"),
    radioButtons(
      inputId = "year",
      label = "Time:",
      choices = list(
        "Current" = "Richness",
        "Future*" = "FutureRichness",
        "Change C-F" = "Change_f"
      )
    ),
    tags$p("* Future scenario: 2041-2070, Average"),
    hr(),
    tags$h3("Future richness"),
    selectInput(
      inputId = "scenario",
      label = "Future Scenario:",
      choices = as.list(
        colnames(richness_df %>%
          dplyr::select(
            -x, -y, -Richness,
            -FutureRichness,
            -Change, -Change_f
          ))
      )
    ),
    tags$hr(),
    tags$h3("Species distribution"),
    selectInput(
      inputId = "scenario_sp",
      label = "Scenario:",
      choices = list(
        "Current" = "_current",
        "Future (mean)" = ".future_mean",
        "Future (max)" = ".future_max",
        "Future (min)" = ".future_min",
        "SSP126 gfdl-esm4" = "_future.gfdl-esm4_ssp126",
        "SSP126 ipsl-cm6a-lr" = "_future.ipsl-cm6a-lr_ssp126",
        "SSP126 mpi-esm1-2-hr" = "_future.mpi-esm1-2-hr_ssp126",
        "SSP126 mri-esm2-0" = "_future.mri-esm2-0_ssp126",
        "SSP126 ukesm1-0-ll" = "_future.ukesm1-0-ll_ssp126",
        "SSP370 gfdl-esm4" = "_future.gfdl-esm4_ssp370",
        "SSP370 ipsl-cm6a-lr" = "_future.ipsl-cm6a-lr_ssp370",
        "SSP370 mpi-esm1-2-hr" = "_future.mpi-esm1-2-hr_ssp370",
        "SSP370 mri-esm2-0" = "_future.mri-esm2-0_ssp370",
        "SSP370 ukesm1-0-ll" = "_future.ukesm1-0-ll_ssp370",
        "SSP585 gfdl-esm4" = "_future.gfdl-esm_ssp5854",
        "SSP585 ipsl-cm6a-lr" = "_future.ipsl-cm6a-lr_ssp585",
        "SSP585 mpi-esm1-2-hr" = "_future.mpi-esm1-2-hr_ssp585",
        "SSP585 mri-esm2-0" = "_future.mri-esm2-0_ssp585",
        "SSP585 ukesm1-0-ll" = "_future.ukesm1-0-ll_ssp585"
      )
    ),
    selectInput(
      inputId = "species",
      label = "Species:",
      choices = as.list(c(
        "Allol_chlo", "Allol_eise", "Aporr_cali",
        "Aporr_limi", "Aporr_long", "Aporr_rose",
        "Dendr_atte", "Dendr_illy", "Dendr_octa",
        "Dendr_rubi", "Eisen_feti", "Eisen_tetr",
        "Lumbr_cast", "Lumbr_fest", "Lumbr_rube",
        "Lumbr_terr", "Octol_cyan", "Octol_lact",
        "Octol_tyrt", "Satch_mamm"
      ))
    ),
    hr(),
    tags$h3("Save one map"),
    radioButtons(
      inputId = "plotname",
      label = "Name of the plot to save",
      choices = list(
        "Richness in Europe" = "Map",
        "Future richness" = "FutureMap",
        "Species distribution" = "SpeciesMap"
      )
    ),
    textInput(
      inputId = "filename",
      label = "Name of the .png file",
      placeholder = "Example_name"
    ),
    hr(),
    submitButton(text = "Apply Changes"),
    p("Make sure to hit the button 'Apply Changes' before saving."),
    downloadButton("saving", label = "Save plot as .png")
  ),

  tags$h3("Hints"),
  tags$p("Make sure to hit the button 'Apply Changes' before saving."),
  tags$p(code("Please be patient, maps are LOADING...")),
  
  # Show a plot of the generated distribution
  navset_card_tab(
    nav_panel(
      "Richness in Europe",
      "Number of earthworm species per 5 x 5 km grid cell.",
      plotOutput("Map")
    ),
    nav_panel(
      "Future richness",
      "Number of earthworm species per 5 x 5 km grid cell under 
      future climatic conditions (1 scenario only) or change in 
      number of species (continuous [Change] or categorized [Change_f].", 
      plotOutput("FutureMap")
    ),
    nav_panel(
      "Species distribution",
      "Distribution of 1 species under 1 scenario in 5 x 5 km grid cells.",
      plotOutput("SpeciesMap")
    )
  ),
  
  tags$h3("Reference"),
  tags$p("Zeiss, R., Briones, M. J. I., Mathieu, J., Lomba, A., Dahlke, J., Heptner, L., Salako, G., Eisenhauer, N., & Guerra, C. A. (2024). Effects of climate on the distribution and conservation of commonly observed European earthworms. Conservation Biology, 38, e14187."),
  tags$a("DOI: 10.1111/cobi.14187", href = "https://doi.org/10.1111/cobi.14187")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  plot_map <- reactive({
    withProgress(message = "Preparing map of distribution change", {
      if (input$year == "Change_f") {
        ggplot() +
          geom_map(data = world.inp, map = world.inp, aes(map_id = region), fill = "grey80") +
          xlim(-23, 40) +
          ylim(31, 75) +
          geom_tile(
            data = richness_df,
            aes(x = x, y = y, fill = richness_df[, input$year])
          ) +
          ggtitle("Change C-F as factor") +
          scale_fill_viridis_d(breaks = c("[5,10]", "[0,5]", "[-5,0]", "[-10,-5]", "[-20,-10]")) +
          theme_bw() +
          theme(
            axis.title = element_blank(), legend.title = element_blank(),
            legend.position = c(0.1, 0.4)
          )
      } else {
        ggplot() +
          geom_map(data = world.inp, map = world.inp, aes(map_id = region), fill = "grey80") +
          xlim(-23, 40) +
          ylim(31, 75) +
          geom_tile(
            data = richness_df[richness_df[, input$year] > 0, ],
            aes(x = x, y = y, fill = richness_df[, input$year])
          ) +
          ggtitle(input$year) +
          scale_fill_viridis_c() +
          theme_bw() +
          theme(
            axis.title = element_blank(), legend.title = element_blank(),
            legend.position = c(0.1, 0.4)
          )
      }
    })
  })

  output$Map <- renderPlot(print(plot_map()))

  plot_futuremap <- reactive({
    withProgress(message = "Preparing map of future species richness", {
      if (str_detect(input$scenario, "Change_f")) {
        ggplot() +
          geom_map(data = world.inp, map = world.inp, aes(map_id = region), fill = "grey80") +
          xlim(-23, 40) +
          ylim(31, 75) +
          geom_tile(
            data = richness_df,
            aes(x = x, y = y, fill = richness_df[, input$scenario])
          ) +
          ggtitle("Change C-F as factor") +
          scale_fill_viridis_d(breaks = c("[5,10]", "[0,5]", "[-5,0]", "[-10,-5]", "[-20,-10]")) +
          theme_bw() +
          theme(
            axis.title = element_blank(), legend.title = element_blank(),
            legend.position = c(0.1, 0.4)
          )
      } else {
        ggplot() +
          geom_map(data = world.inp, map = world.inp, aes(map_id = region), fill = "grey80") +
          xlim(-23, 40) +
          ylim(31, 75) +
          geom_tile(
            data = richness_df,
            aes(x = x, y = y, fill = richness_df[, input$scenario])
          ) +
          ggtitle(input$scenario) +
          scale_fill_viridis_c() +
          theme_bw() +
          theme(
            axis.title = element_blank(), legend.title = element_blank(),
            legend.position = c(0.1, 0.4)
          )
      }
    })
  })

  output$FutureMap <- renderPlot(print(plot_futuremap()))

  plot_speciesmap <- reactive({
    withProgress(message = "Preparing map of species distribution", {
      column_sp <- paste0(input$species, input$scenario_sp)
      
      species_plot_df <- species_df[
        !is.na(species_df[[column_sp]]),
        c("x", "y", column_sp),
        drop = FALSE
      ]
      
      ggplot() +
        geom_map(data = world.inp, map = world.inp, aes(map_id = region), fill = "grey80") +
        xlim(-23, 40) +
        ylim(31, 75) +
        geom_tile(
          data = species_plot_df,
          aes(
            x = x, y = y,
            fill = as.factor(.data[[column_sp]])
          )
        ) +
        ggtitle(column_sp) +
        scale_fill_manual(values = c("1" = "#440154", "0" = "grey")) +
        theme_bw() +
        theme(
          axis.title = element_blank(), legend.title = element_blank(),
          legend.position = c(0.1, 0.4)
        )
    })
  })

  output$SpeciesMap <- renderPlot(print(plot_speciesmap()))

  outputOptions(output, "Map", suspendWhenHidden = FALSE)
  outputOptions(output, "FutureMap", suspendWhenHidden = TRUE)
  outputOptions(output, "SpeciesMap", suspendWhenHidden = TRUE)
  
  output$saving <- downloadHandler(
    filename = renderText({
      paste0(input$filename, ".png")
    }),
    content = function(file) {
      withProgress(message = "Saving data", {
        png(filename = file, height = 1000, width = 1000)
        if (input$plotname == "Map") print(plot_map())
        if (input$plotname == "FutureMap") print(plot_futuremap())
        if (input$plotname == "SpeciesMap") print(plot_speciesmap())
        dev.off()
      })
    }
  )

  traceback()
}

# Run the application
shinyApp(ui = ui, server = server)
