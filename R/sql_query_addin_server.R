
#' @importFrom shiny insertUI removeUI observeEvent
#' @importFrom DBI dbSendQuery
sql_query_addin_server <- function(input, output, session) {

  if (is.null(sqlquery.env$conn)) {
    insertUI(
      selector = "#result-query",
      ui = alert(
        tags$b("No connection"), "Define a connection to run queries",
        status = "warning", id = "alert-query"
      )
    )
    toggleInputServer(session, "run_query", enable = FALSE)
  }

  output$SQLquery <- renderSqlquery({
    sql_query(raw = TRUE, autocomplete = sqlquery.env$db_infos)
  })

  observeEvent(input$run_query, {
    rs <- try(dbSendQuery(conn = sqlquery.env$conn, statement = input$SQLquery_value), silent = TRUE)
    if ("try-error" %in% class(rs)) {
      removeUI(selector = "#alert-query")
      insertUI(
        selector = "#result-query",
        ui = alert(
          tags$b("Error"), error_msg(rs),
          status = "danger", id = "alert-query"
        )
      )
    } else {
      removeUI(selector = "#alert-query")
      insertUI(
        selector = "#result-query",
        ui = alert(
          tags$b("Success"), "Click to view first rows",
          status = "success", id = "alert-query"
        )
      )
    }
  }, ignoreInit = TRUE)
}


error_msg <- function(x) {
  x <-  as.character(x)
  x <- gsub(pattern = ".*\\s:\\s", replacement = "", x = x)
  trimws(x)
}

