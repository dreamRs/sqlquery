#' Adds the content of www to sqlquery/
#'
#' @importFrom shiny addResourcePath
#'
#' @noRd
.onLoad <- function(...) {
  shiny::addResourcePath("sqlquery", system.file('www', package = "sqlquery"))
}
