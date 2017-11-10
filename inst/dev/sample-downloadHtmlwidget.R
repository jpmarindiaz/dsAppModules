library(shiny)
library(tidyverse)
library(dsAppModules)
library(DT)

## Data upload module



ui <- fluidPage(
  useShinyjs(),
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

  inputDataName <- reactive(input$data)

  callModule(downloadHtmlwidget,"download", widget = widget)
  callModule(downloadHtmlwidget,"download2", widget = wdata, name = inputDataName)
  output$debug <- renderPrint({
    wdata()
  })
}
shinyApp(ui,server)

