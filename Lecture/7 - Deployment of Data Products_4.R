# 7 Deployment of Data Products
# Contact: Dominik Jung, d.jung@kit.edu

library(shiny)
library(ggplot2)
load("./Datasets/whiskies.RData")  # read the whiskies from the data folder
load("./Datasets/scotland_ggmapp.RData")  # read the map for plotting

# ui
ui <- fluidPage(
  titlePanel("WhiskyVisualizer"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create maps with information about whisky distilleries"),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = list("Body", "Smoky"),
                  selected = "Smoky"),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 1, max = 5, value = c(2, 3))
    ),
    
    mainPanel(
      plotOutput(outputId = "selected_var")
    )
  )
)

# server logic
server <- function(input, output) {
  output$selected_var <- renderPlot({
    
    if(input$var == "Body"){
      selection = whiskies[whiskies$Body >= input$range[1] & whiskies$Body <= input$range[2],]
      whiskyMap + geom_point(data = selection, aes(x = lon,y = lat,color=Body))
    }
    else{
      selection = whiskies[whiskies$Smoky >= input$range[1] & whiskies$Smoky <= input$range[2],]
      whiskyMap + geom_point(data = selection, aes(x = lon,y = lat, color=Smoky))
    }
  })
}

# run the app
shinyApp(ui = ui, server = server)