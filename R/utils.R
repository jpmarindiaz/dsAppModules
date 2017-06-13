is.reactive <- function(obj){
  all(class(obj) %in% c("reactiveExpr","reactive"))
}
