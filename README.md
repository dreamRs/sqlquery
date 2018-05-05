# sqlquery

> SQL query editor

[![Travis build status](https://travis-ci.org/dreamRs/sqlquery.svg?branch=master)](https://travis-ci.org/dreamRs/sqlquery)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

 

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
