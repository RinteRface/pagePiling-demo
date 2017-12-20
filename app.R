library(fullPage)
library(shiny)

options <- list(
  loopBottom = TRUE
)

ui <- pagePiling(
  sections.color = c('#f2f2f2', '#2C3E50', '#39C'),
  opts = options,
  menu = c("Section 1" = "section1",
           "Piling" = "section2",
           "Plots" = "section3",
           "Layers" = "section4",
           "More" = "more"),
  pageSection(
    center = TRUE,
    menu = "section1",
    h1("pagePiling.js for Shiny.")
  ),
  pageSection(
    menu = "section2",
    center = TRUE,
    h1("Section 2")
  ),
  pageSectionPlot(
    "plot",
    center = TRUE,
    menu = "section3",
    h1("Plot background")
  ),
  pageSectionPlot(
    "plot2",
    center = TRUE,
    menu = "section4",
    pageContainer(
      h1("Layer anything"),
      sliderInput(
        "bins",
        "Data Points",
        min = 100,
        max = 500,
        step = 25,
        value = 200
      )
    )
  ),
  pageSection(
    menu = "more",
    center = TRUE,
    h1("More stuff like that for shiny"),
    pageButton(
      "More",
      outline = TRUE,
      href = "http://john-coene.com"
    ),
    p("This runs fine... the issue is with Shiny showcase mode.")
  )
)

server <- function(input, output){
  
  output$plot <- renderPlot({
    par(bg = "grey60")
    plot(mtcars$wt, mtcars$mpg)
  })
  
  output$plot2 <- renderPlot({
    par(bg = "grey80")
    hist(rnorm(input$bins, 100, 250))
  })
}

shinyApp(ui, server)

