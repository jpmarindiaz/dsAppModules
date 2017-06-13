library(shiny)
library(tidyverse)

## Data upload module



ui <- fluidPage(
  tableInputUI("dataIn", tableInputChoices = c("pasted",
                                               "fileUpload",
                                               "sampleData"),
               tableInputChoiceNames = c("Copiar y pegar",
                                          "File Upload",
                                          "Sample")
  ),
  verbatimTextOutput("debug")
)

server <- function(input,output,session){
  inputData <- callModule(tableInput, "dataIn",
                          sampleFile =
                            list("File1"="sample1.csv","Archivo2"="sample2.csv"))
  output$debug <- renderPrint({
    inputData()
  })
}
shinyApp(ui,server)





