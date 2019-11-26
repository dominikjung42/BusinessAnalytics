# 7 Deployment of Data Products
# Contact: Dominik Jung, d.jung@kit.edu


library(shiny)

# ui 1
ui <- fluidPage(
  titlePanel("title panel"),
  
  sidebarLayout(
    sidebarPanel("sidebar panel"),
    mainPanel("main panel")
  )
)

# server logic
server <- function(input, output) {
  
}

# Run the app
shinyApp(ui = ui, server = server)


# ui 2
ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      h1("First level title"),
      h2("Second level title"),
      h3("Third level title"),
      h4("Fourth level title"),
      h5("Fifth level title"),
      h6("Sixth level title")
    )
  )
)

# ui 3
ui <- fluidPage(
  titlePanel("My Star Wars App"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      h6("Episode XXVI", align = "center"),
      h6("A NEW HOPE FOR ANALYTICS", align = "center"),
      h5("It is a period of war and torture.", align = "center"),
      h4("Rebel spaceships of analysts, striking", align = "center"),
      h3("from a hidden base, have won", align = "center"),
      h2("their first victory...", align = "center")
    )
  )
)



