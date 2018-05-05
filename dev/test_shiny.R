
library(shiny)
library(shinyWidgets)
library(sqlquery)

ui <- fluidPage(
  tags$h2("sqlquery example"),
  panel(
    heading = "SQL editor",
    status = "primary",
    sqlqueryOutput(outputId = "mySQL", height = "200px")
  ),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {

  output$mySQL <- renderSqlquery({
    sql_query(raw = TRUE)
  })

  output$res <- renderPrint({
    input$mySQL_value
  })

}

runApp(
  appDir = shinyApp(ui, server),
  launch.browser = paneViewer()
)
