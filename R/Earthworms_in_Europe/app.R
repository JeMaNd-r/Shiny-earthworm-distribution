#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
load("richness_df.RData") #richness_df

richness_df <- richness_df %>% filter(!is.na(Change)) %>% filter(FutureRichness!=0 & Richness!=0)

# Define parameters used later
year_df <- data.frame("year"=c("Current", "Future (2041-2070)", "Change F-C"),
                      "column"=c("Richness", "FutureRichness", "Change_f"))

world.inp <- map_data("world")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Earthworm species distributions in Europe"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            radioButtons(inputId = "year",
                        label = "Time:",
                        choices = list("Current" = "Richness", 
                                       "Future (2041-2070)" = "FutureRichness", 
                                       "Change C-F" = "Change_f"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("Map")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$Map <- renderPlot({
        
        # plot
        if(input$year == "Change_f"){
          plot_map <- print(ggplot()+
                  geom_map(data = world.inp, map = world.inp, aes(map_id = region), fill = "grey80") +
                  xlim(-23, 60) +
                  ylim(31, 75) +
                  
                  geom_tile(data=richness_df, 
                            aes(x=x, y=y, fill=richness_df[,input$year]))+
                  ggtitle(input$year)+
                  scale_fill_viridis_d(breaks=c("[5,10]", "[0,5]", "[-5,0]", "[-10,-5]", "[-20,-10]"))+
                  theme_bw()+
                  theme(axis.title = element_blank(), legend.title = element_blank(),
                        legend.position = c(0.1,0.4)))
        }else{
          plot_map <- print(ggplot()+
                  geom_map(data = world.inp, map = world.inp, aes(map_id = region), fill = "grey80") +
                  xlim(-23, 60) +
                  ylim(31, 75) +
                  
                  geom_tile(data=richness_df, 
                            aes(x=x, y=y, fill=richness_df[,input$year]))+
                  ggtitle(input$year)+
                  scale_fill_viridis_c()+
                  theme_bw()+
                  theme(axis.title = element_blank(), legend.title = element_blank(),
                        legend.position = c(0.1,0.4)))
}
        print(plot_map)
        
        # save plot if save==TRUE
        #png(file=paste0(here::here(), "/figures/SpeciesRichness_", input$year,"_Lumbricidae.png"),width=1000, height=1000)
        #print(plot_map)
        #dev.off()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
