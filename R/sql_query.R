#' Create a SQL Query editor
#'
#' @param conn A \code{DBIConnection} object, as returned by \code{dbConnect()}.
#'  Default to \code{NULL}.
#' @param schema Schema's name, by default \code{NULL}.
#' @param autocomplete A named list used for autocompletion.
#'  List's names represent tables, values tables' fields.
#' @param value Character. Value to display by default.
#' @param options Editor's options, see \code{\link{editor_options}}.
#' @param font_size Code editor font size.
#' @param raw Logical. If \code{TRUE} only code editor is displayed.
#' @param width A numeric input in pixels.
#' @param height A numeric input in pixels.
#' @param elementId Use an explicit element ID for the widget.
#'
#' @importFrom htmlwidgets createWidget
#' @importFrom htmltools validateCssUnit
#' @importFrom utils modifyList
#'
#' @export
sql_query <- function(conn = NULL, schema = NULL, autocomplete = NULL,
                      value = "",
                      options = editor_options(),
                      font_size = "16px", raw = FALSE,
                      width = NULL, height = NULL, elementId = NULL) {

  stopifnot(is.character(value))

  # Connection infos
  db_infos <- get_db_infos(conn = conn, schema = schema)
  if (!is.null(autocomplete) && is.list(autocomplete)) {
    db_infos <- modifyList(autocomplete, db_infos)
  }

  # editor's options
  if (is.null(options))
    options <- list()

  options <- modifyList(
    x = list(value = value, mode = "text/x-sql"),
    val = options
  )

  # htmlwidgets parameters
  x <- list(
    options = options, raw = raw,
    fontSize = htmltools::validateCssUnit(font_size),
    autocomplete = list(tables = db_infos)
  )

  if (!raw) {
    deps <- bs_light_dep()
  } else {
    deps <- NULL
  }

  # create widget
  htmlwidgets::createWidget(
    name = 'sqlquery',
    x,
    width = width,
    height = height,
    package = 'sqlquery',
    elementId = elementId,
    dependencies = deps
  )
}

#' @importFrom htmltools htmlDependency
bs_light_dep <- function(){
  htmlDependency(
    name = "bootstrap", version = "3.3.7",
    src = system.file("htmlwidgets", "lib", "bootstrap-light", package = "sqlquery"),
    meta = list(viewport = "width=device-width, initial-scale=1"),
    script = NULL,
    stylesheet = c("css/bootstrap.min.css", "css/bootstrap-theme.min.css")
  )
}

# cat(
#   " J\u2019ai tant r\u00eav\u00e9 de toi que tu perds ta r\u00e9alit\u00e9.", "\n",
#   "Est-il encore temps d\u2019atteindre ce corps vivant", "\n",
#   "et de baiser sur cette bouche la naissance", "\n",
#   "de la voix qui m\u2019est ch\u00e8re ?", "\n",
#   "J\u2019ai tant r\u00eav\u00e9 de toi que mes bras habitu\u00e9s en \u00e9treignant ton ombre", "\n",
#   "\u00e0 se croiser sur ma poitrine ne se plieraient pas", "\n",
#   "au contour de ton corps, peut-\u00eatre.", "\n",
#   "Et que, devant l\u2019apparence r\u00e9elle de ce qui me hante", "\n",
#   "et me gouverne depuis des jours et des ann\u00e9es", "\n",
#   "je deviendrais une ombre sans doute,", "\n",
#   "\u00d4 balances sentimentales.", "\n",
#   "J\u2019ai tant r\u00eav\u00e9 de toi qu\u2019il n\u2019est plus temps sans doute que je m\u2019\u00e9veille.", "\n",
#   "Je dors debout, le corps expos\u00e9 \u00e0 toutes les apparences de la vie", "\n",
#   "et de l\u2019amour et toi, la seule qui compte aujourd\u2019hui pour moi,", "\n",
#   "je pourrais moins toucher ton front et tes l\u00e8vres que les premi\u00e8res l\u00e8vres", "\n",
#   "et le premier front venu.", "\n",
#   "J\u2019ai tant r\u00eav\u00e9 de toi, tant march\u00e9, parl\u00e9, couch\u00e9 avec ton fant\u00f4me", "\n",
#   "qu\u2019il ne me reste plus peut-\u00eatre, et pourtant,", "\n",
#   "qu\u2019\u00e0 \u00eatre fant\u00f4me parmi les fant\u00f4mes et plus ombre cent fois", "\n",
#   "que l\u2019ombre qui se prom\u00e8ne et se prom\u00e8nera all\u00e8grement", "\n",
#   "sur le cadran solaire de ta vie.", "\n",
#   "\n",
#   "\u00c0 la myst\u00e9rieuse, Corps et Biens - Robert Desnos"
# )


#' Shiny bindings for sqlquery
#'
#' Output and render functions for using sqlquery within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a sqlquery
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name sqlquery-shiny
#'
#' @export
#' @importFrom htmlwidgets shinyWidgetOutput
sqlqueryOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'sqlquery', width, height, package = 'sqlquery')
}

#' @rdname sqlquery-shiny
#' @export
#' @importFrom htmlwidgets shinyRenderWidget
renderSqlquery <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, sqlqueryOutput, env, quoted = TRUE)
}
