
#' @title SQL Editor Addin
#'
#' @description Write SQL queries and execute them.
#'
#' @param conn A \code{DBIConnection} object, as returned by \code{dbConnect()}.
#' @param schema Schema's name, by default \code{NULL}.
#'
#' @export
#'
#' @importFrom shiny dialogViewer browserViewer runGadget paneViewer
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#' sql_query_app()
#'
#' }
#'
#' }
sql_query_app <- function(conn = NULL, schema = NULL) {

  db_infos <- get_db_infos(conn = conn, schema = schema)

  display <- getOption("sqlquery.display.mode", default = "pane")

  if (display == "browser") {
    inviewer <- browserViewer(browser = getOption("browser"))
  } else if (display == "pane") {
    inviewer <- paneViewer()
  } else {
    inviewer <- dialogViewer(
      "SQL Queries",
      width = 1000, height = 750
    )
  }

  sqlquery.env$conn <- conn
  sqlquery.env$db_infos <- db_infos
  sqlquery.env$pane <- display == "pane"

  runGadget(
    app = sql_query_app_ui(),
    server = sql_query_app_server,
    viewer = inviewer
  )
}




