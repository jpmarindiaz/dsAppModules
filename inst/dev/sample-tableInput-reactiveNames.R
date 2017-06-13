library(shiny)
library(tidyverse)

## Data upload module



ui <- fluidPage(
  textInput("text","Text"),
  uiOutput("tableInputSection"),
  verbatimTextOutput("debug")
)

server <- function(input,output,session){

  text <- reactive(input$text)

  inputData <- callModule(tableInput, "dataIn",
                          sampleFile =
                            list("File1"="sample1.csv","Archivo2"="sample2.csv"))
  output$debug <- renderPrint({
    inputData()
  })

  output$tableInputSection <- renderUI({
    tableInputChoiceNames <- c(text(),
      "File Upload",
      "Sample")
    tagList(
      tableInputUI("dataIn", tableInputChoices = c("pasted",
                                                   "fileUpload",
                                                   "sampleData"),
                   tableInputChoiceNames = tableInputChoiceNames
      )
    )
  })

}
shinyApp(ui,server)





