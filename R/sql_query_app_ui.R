
#' @importFrom miniUI miniPage miniContentPanel
#' @importFrom shiny tags tagList fillPage fillCol fillRow actionLink icon
#' @importFrom shinyWidgets panel
sql_query_app_ui <- function() {
  miniPage(
    tags$head(
      tags$link(href="sqlquery/styles.css", rel="stylesheet", type="text/css")
    ),
    toggleInputUi(),
    tags$div(
      class = "gadget-title", style = "background-color: rgb(16,34,70);",
      tags$h1(
        icon("console", lib = "glyphicon"), "SQL editor",
        style = "font-weight: bold; color: #FFF;"
      ),
      tags$button(
        id="cancel", type="button", "Cancel",
        class="btn btn-default btn-sm action-button pull-right"
      )
    ),
    miniContentPanel(
      padding = 0,
      fillPage(
        padding = 5,
        fillCol(
          flex = c(5, 3),
          sqlqueryOutput(outputId = "SQLquery", height = "100%"),
          fillCol(
            flex = c(1, 9),
            fillRow(
              style = "text-align: center;",
              actionLink(
                inputId = "insert_code", label = "Insert code in script",
                icon = icon("circle-arrow-left", lib = "glyphicon"),
                style = "text-align: center; width: 100%;"
              ),
              actionLink(
                inputId = "copy_to_clipboard", label = "Copy to clipboard",
                icon = icon("copy", lib = "glyphicon"),
                style = "text-align: center; width: 100%;"
              )
            ),
            panel(
              heading = actionLink(
                inputId = "run_query",
                label = "Execute query",
                icon = icon("play", lib = "glyphicon"),
                style = "color: #FFF;"
              ), status = "primary",
              tags$div(
                id = "result-query"
              )
            )
          )
        )
      )
    )
  )
}
