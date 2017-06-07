library(shiny)
library(tidyverse)

## Data upload module



ui <- fluidPage(
  tableInputUI("dataIn", tableInputChoices =
                list(
                  "Copiar y pegar"="pasted",
                  "File Upload"="fileUpload",
                  "Sample" = "sampleData"
                )),
  verbatimTextOutput("debug")
)

server <- function(input,output,session){
  inputData <- callModule(tableInput, "dataIn",
                          sampleFile =
                            list("File1"="sample1.csv","File2"="sample2.csv"))
  output$debug <- renderPrint({
    inputData()
  })
}
shinyApp(ui,server)





