
# Package ----
library(sqlquery)
library(DBI)


# htmlwidget ----

# Default
sql_query(value = "SELECT * FROM mtcars")

sql_query(value = "SELECT * FROM mtcars", options = editor_options(lineNumbers = FALSE, theme = "duotone-dark"))

# Raw appearance
sql_query(value = "SELECT * FROM mtcars", raw = TRUE)


# With connection

con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbWriteTable(conn = con, name = "mtcars", value = mtcars)

sql_query(conn = con)





# shiny app ----

# default
sql_query_app()

# With connection
library(DBI)
con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbWriteTable(conn = con, name = "mtcars", value = mtcars)
sql_query_app(conn = con)

# options("sqlquery.connection" = function() {
#   dbConnect(RSQLite::SQLite(), "dev/test.sqlite")
# })



library(DBI)
con <- dbConnect(RSQLite::SQLite(), "dev/test.sqlite")
# options("sqlquery.display.mode" = "pane")
sql_query_app(conn = con)

query <- ""
rs <- dbSendQuery(conn = con, statement = query)
dbFetch(res = rs, n = 50)
View(dbFetch(res = rs, n = 50))
