
# Package ----
library(sqlquery)
library(DBI)


# Default
sql_query(value = "SELECT * FROM mtcars")

sql_query(value = "SELECT * FROM mtcars", options = editor_options(lineNumbers = FALSE, theme = "duotone-dark"))

# Raw appearance
sql_query(value = "SELECT * FROM mtcars", raw = TRUE)


# With connection

con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbWriteTable(conn = con, name = "mtcars", value = mtcars)

sql_query(conn = con)
