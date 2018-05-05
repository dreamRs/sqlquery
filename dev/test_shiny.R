
library(shiny)

ui <- fluidPage(
  tags$h2("sqlquery example"),
  sqlqueryOutput(outputId = "mySQL", height = "300px"),
  verbatimTextOutput(outputId = "res")
)

server <- function(input, output, session) {

  output$mySQL <- renderSqlquery({
    sql_query(font_size = "16px", raw = TRUE)
  })

  output$res <- renderPrint({
    input$mySQL_value
  })

}

runApp(shinyApp(ui, server), launch.browser = paneViewer())
