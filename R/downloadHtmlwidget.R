#' @export
downloadHtmlwidgetUI <- function(id, text = "Download", class = NULL){
  ns <- NS(id)
  tagList(
    downloadButton(ns("downloadHtmlwidget"),text, class = class)
  )
}

#' @export
downloadHtmlwidget <- function(input,output,session, widget = NULL){
  #ns <- session$ns
  output$downloadHtmlwidget <- downloadHandler(
    filename = function() {
      paste0("widget-",gsub(" ","_",as.POSIXct(Sys.time())), ".html")
    },
    content = function(file) {
      if(is.reactive(widget))
        widget <- widget()
      saveWidget(widget, file = file, selfcontained = TRUE)
    }
  )
}
