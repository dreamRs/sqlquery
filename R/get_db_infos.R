#' Get tables and fields from a connection
#'
#' @param conn A \code{DBIConnection} object, as returned by \code{dbConnect()}.
#' @param schema Schema's name, by default \code{NULL}.
#'
#' @return a named \code{list} where names are tables and values tables' fields.
#' @export
#'
#' @importFrom DBI dbListTables dbListFields
#' @importFrom stats setNames
#'
#' @examples
#'
#' library(DBI)
#' con <- dbConnect(RSQLite::SQLite(), ":memory:")
#' dbWriteTable(conn = con, name = "mtcars", value = mtcars)
#' get_db_infos(con)
#'
get_db_infos <- function(conn, schema = NULL) {
  if (is.null(conn)) return(list())
  tables <- dbListTables(conn = conn, schema = schema)
  lapply(
    X = setNames(tables, tables),
    FUN = dbListFields, conn = conn, schema = schema
  )
}
