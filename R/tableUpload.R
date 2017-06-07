
#' @export
tableInputUI <- function(id,
                         tableInputChoices =
                           list("Copy & Paste"="pasted",
                                "File Upload"="fileUpload",
                                "Sample Data"="sampleData"),
                         selected = "pasted"
){
  # UI
  ns <- NS(id)
  tagList(
    radioButtons(ns("tableInput"), "upload Data",
                 choices = tableInputChoices, selected = selected),
    uiOutput(ns("tableInputControls"))
  )
}

#' @export
tableInput <- function(input,output,session, sampleFiles = c()){
  output$tableInputControls <- renderUI({
    ns <- session$ns
    message("\n\n",input$tableInput,"\n\n")
    if(input$tableInput == "sampleData"){
      if(!all(map_lgl(sampleFiles,file.exists)))
        stop("All Sample Files must exist")
    }
    tableInputControls <- list(
      "pasted" = textAreaInput(ns("inputDataPasted"),label = "Paste",
                               placeholder = "placeholder",
                               rows = 5),
      "fileUpload" =  fileInput(ns('inputDataUpload'), 'Choose CSV File',
                                accept=c('text/csv',
                                         'text/comma-separated-values,text/plain',
                                         '.csv','.xls')),
      "sampleData" = selectInput(ns("inputDataSample"),"Seleccione Datos de Muestra",
                                 choices = sampleFiles)
    )
    tableInputControls[[input$tableInput]]
  })

  inputData <- reactive({
    inputType <- input$tableInput
    #readDataFromInputType(inputType)
    if(inputType == "pasted"){
      if(input$inputDataPasted == "")
        return()
      df <- read_tsv(input$inputDataPasted)
    }
    if(inputType ==  "fileUpload"){
      if(is.null(input$inputDataUpload)) return()
      old_path <- input$inputDataUpload$datapath
      path <- file.path(tempdir(),input$inputDataUpload$name)
      file.copy(old_path,path)
      df <- rio::import(path)
    }
    if(inputType ==  "sampleData"){
      file <- input$inputDataSample
      df <- read_csv(file)
    }
    return(df)
  })

  inputData
}

