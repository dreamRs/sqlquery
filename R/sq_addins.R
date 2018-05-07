
# funs for launching RStudio's addins
sq_addin <- function() {

  conn_fun <- getOption("sqlquery.connection")
  if (!is.null(conn_fun) & is.function(conn_fun)) {
    conn <- conn_fun()
  } else {
    conn <- NULL
  }
  schema <- getOption("sqlquery.schema")

  sql_query(conn = conn, schema = schema)
}

sq_addin_app <- function() {

  conn_fun <- getOption("sqlquery.connection")
  if (!is.null(conn_fun) & is.function(conn_fun)) {
    conn <- conn_fun()
  } else {
    conn <- NULL
  }
  schema <- getOption("sqlquery.schema")

  sql_query_app(conn = conn, schema = schema)
}


