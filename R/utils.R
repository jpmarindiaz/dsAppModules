is.reactive <- function(obj){
  all(class(obj) %in% c("reactiveExpr","reactive"))
}

#' @export
getUrlParameters <- function(session = session) {
  parseQueryString(session$clientData$url_search)
}
