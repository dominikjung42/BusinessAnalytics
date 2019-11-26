# 7 Deployment of Data Products
# Contact: Dominik Jung, d.jung@kit.edu

library(shiny)

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
      textOutput("selected_var")
    )
  )
)

# server logic
server <- function(input, output) {
  output$selected_var <- renderText({ 
    "You have selected this"
  })
}

# Run the app
shinyApp(ui = ui, server = server)




