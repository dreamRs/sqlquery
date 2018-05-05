# sqlquery

> SQL query editor

## Installation

You can install from Github:

``` r
source("https://install-github.me/dreamRs/sqlquery")
```

## Example

Basic usage:

``` r
library(sqlquery)
sql_query(value = "SELECT * FROM mtcars")
```

Get autocompletion for tables and fields in a Database:
``` r
library(DBI)
con <- dbConnect(RSQLite::SQLite(), ":memory:")
dbWriteTable(conn = con, name = "mtcars", value = mtcars)

sql_query(conn = con)
```
