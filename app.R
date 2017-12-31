library(fullPage)
library(shiny)

options <- list(
  loopBottom = TRUE
)

ui <- pagePiling(
  sections.color = c('#f2f2f2', '#2C3E50', '#39C'),
  opts = options,
  menu = c("Pills" = "section1",
           "Utils" = "section2",
           "Plots" = "section3",
           "Layers" = "section4",
           "More" = "more"),
  pageSection(
    center = TRUE,
    menu = "section1",
    h1("pagePiling.js meets Shiny.")
  ),
  pageSection(
    menu = "section2",
    center = TRUE,
    pageContainer(
      h2("Grid system"),
      pageRow(
        pageColumn(
          h3("Buttons"),
          pageButtonDown("Move section down")
        ),
        pageColumn(
          plotOutput("somePlot")
        )
      )
    )
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
    h1("Want more stuff like that for shiny?"),
    pageButton(
      "More",
      outline = TRUE,
      href = "http://john-coene.com"
    )
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
  
  output$somePlot <- renderPlot({
    par(bg = "#2C3E50")
    plot(mtcars$qsec, mtcars$drat)
  })
}

shinyApp(ui, server)

