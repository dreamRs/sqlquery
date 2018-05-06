

.sq_proxy <- function(shinyId, data = NULL, session = shiny::getDefaultReactiveDomain()) {

  if (is.null(session)) {
    stop("This function must be called from the server function of a Shiny app")
  }

  if (!is.null(session$ns) && nzchar(session$ns(NULL)) && substring(shinyId, 1, nchar(session$ns(""))) != session$ns("")) {
    shinyId <- session$ns(shinyId)
  }

  structure(
    list(
      session = session,
      id = shinyId,
      x = structure(
        list(data = data)
      )
    ),
    class = "sql_query_Proxy"
  )
}

#' Proxy method for setting editor's value
#'
#' @param shinyId single-element character vector indicating the output ID of the
#'   editor to modify (if invoked from a Shiny module, the namespace will be added
#'   automatically)
#' @param value The new value to use.
#' @param session the Shiny session object to which the editor belongs; usually the
#'   default value will suffice
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinyWidgets)
#'   library(sqlquery)
#'
#'   ui <- fluidPage(
#'     tags$h2("sqlquery example"),
#'     panel(
#'       heading = "SQL editor",
#'       status = "primary",
#'       sqlqueryOutput(outputId = "mySQL", height = "200px")
#'     ),
#'     verbatimTextOutput(outputId = "res"),
#'     textInput(
#'       inputId = "update",
#'       label = "Update editor:",
#'       width = "100%"
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     output$mySQL <- renderSqlquery({
#'       sql_query(raw = TRUE)
#'     })
#'
#'     output$res <- renderPrint({
#'       input$mySQL_value
#'     })
#'
#'     observeEvent(input$update, {
#'       sq_proxy_setvalue("mySQL", input$update)
#'     }, ignoreInit = TRUE)
#'
#'   }
#'
#'   runApp(
#'     appDir = shinyApp(ui, server),
#'     launch.browser = paneViewer()
#'   )
#'
#' }
#'
#' }
sq_proxy_setvalue <- function(shinyId, value = NULL, session = shiny::getDefaultReactiveDomain()) {
  proxy <- .sq_proxy(shinyId, session = session)
  proxy$session$sendCustomMessage(
    type = "sqlquery-setvalue",
    message = list(id = proxy$id, value = value)
  )
}



#' @title Copy Editor's value to clipboard
#'
#' @description Attach an event to a button to copy to clipboard.
#'
#' @param shinyId single-element character vector indicating the output ID of the
#'   editor to modify (if invoked from a Shiny module, the namespace will be added
#'   automatically)
#' @param selector A CSS selector, e.g. : \code{".btn"} or \code{"#my-button"}.
#' @param session the Shiny session object to which the editor belongs; usually the
#'   default value will suffice
#'
#' @export
#'
#' @examples
#' \dontrun{
#'
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinyWidgets)
#'   library(sqlquery)
#'
#'   ui <- fluidPage(
#'     tags$h2("sqlquery example"),
#'     panel(
#'       heading = "SQL editor",
#'       status = "primary",
#'       sqlqueryOutput(outputId = "mySQL", height = "200px")
#'     ),
#'     verbatimTextOutput(outputId = "res"),
#'     actionButton(inputId = "copy", label = "Copy to clipboard")
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'     output$mySQL <- renderSqlquery({
#'       sql_query(raw = TRUE)
#'     })
#'
#'     # No need to use an observe handler
#'     sq_proxy_clipboard("mySQL", selector = "#copy")
#'
#'     output$res <- renderPrint({
#'       input$mySQL_value
#'     })
#'
#'   }
#'
#'   runApp(
#'     appDir = shinyApp(ui, server),
#'     launch.browser = paneViewer()
#'   )
#'
#' }
#'
#' }
sq_proxy_clipboard <- function(shinyId, selector, session = shiny::getDefaultReactiveDomain()) {
  proxy <- .sq_proxy(shinyId, session = session)
  proxy$session$sendCustomMessage(
    type = "sqlquery-clipboard",
    message = list(id = proxy$id, selector = selector)
  )
}




