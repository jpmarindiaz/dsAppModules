library(shiny)
library(tidyverse)
library(dsAppModules)
library(DT)

## Data upload module



ui <- fluidPage(
  selectizeInput("data","Data", c("cars","mtcars")),
  downloadHtmlwidgetUI("download", "Iris"),
  downloadHtmlwidgetUI("download2", "cars or mtcars"),
  verbatimTextOutput("debug")
)

widget <- DT::datatable(iris)

server <- function(input,output,session){

  wdata <- reactive({
    if(input$data == "cars")
      return(DT::datatable(cars))
    else
      return(DT::datatable(mtcars))
  })

  callModule(downloadHtmlwidget,"download", widget)
  callModule(downloadHtmlwidget,"download2", wdata)
  output$debug <- renderPrint({
    wdata()
  })
}
shinyApp(ui,server)

