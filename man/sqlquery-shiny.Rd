% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sql_query.R
\name{sqlquery-shiny}
\alias{sqlquery-shiny}
\alias{sqlqueryOutput}
\alias{renderSqlquery}
\title{Shiny bindings for sqlquery}
\usage{
sqlqueryOutput(outputId, width = "100\%", height = "400px")

renderSqlquery(expr, env = parent.frame(), quoted = FALSE)
}
\arguments{
\item{outputId}{output variable to read from}

\item{width, height}{Must be a valid CSS unit (like \code{'100\%'},
\code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
string and have \code{'px'} appended.}

\item{expr}{An expression that generates a sqlquery}

\item{env}{The environment in which to evaluate \code{expr}.}

\item{quoted}{Is \code{expr} a quoted expression (with \code{quote()})? This
is useful if you want to save an expression in a variable.}
}
\description{
Output and render functions for using sqlquery within Shiny
applications and interactive Rmd documents.
}
\note{
You can retrieve editor's value server-side with \code{input$<outputId>_value}.
}
\examples{
\dontrun{

if (interactive()) {

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

}

}
}
