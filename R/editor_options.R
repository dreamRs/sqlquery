
#' Options for code editor
#'
#' @param lineNumbers Logical. Whether to show line numbers to the left of the editor.
#' @param lineWrapping Logical. Whether editor should scroll or wrap for long lines.
#' @param tabSize The width of a tab character. Defaults to 4.
#' @param indentWithTabs Logical. Whether, when indenting,
#'  the first N*\code{tabSize} spaces should be replaced by N tabs.
#' @param smartIndent Whether to use the context-sensitive indentation
#'  that the mode provides (or just indent the same as the line before).
#' @param autofocus Can be used to make editor focus itself on initialization.
#' @param theme The theme to style the editor with. See \url{https://codemirror.net/demo/theme.html}.
#' @param ... Additional parameters, see \url{http://codemirror.net/doc/manual.html#config}.
#'
#' @return a list
#' @export
#' @importFrom utils modifyList
#'
editor_options <- function(lineNumbers = TRUE, lineWrapping = TRUE,
                           tabSize = 4, indentWithTabs = TRUE,
                           smartIndent = TRUE, autofocus = TRUE,
                           theme = "eclipse", ...) {
  if (!is.null(theme))
    theme <- match.arg(arg = theme, choices = codemirror_themes())
  args <- list(...)
  options <- dropNulls(list(
    lineNumbers = lineNumbers,
    lineWrapping = lineWrapping,
    indentWithTabs = indentWithTabs,
    smartIndent = smartIndent,
    autofocus = autofocus,
    theme = theme
  ))
  options <- modifyList(options, args)
  return(options)
}


dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}



codemirror_themes <- function() {
  c(
    "3024-day",
    "3024-night",
    "abcdef",
    "ambiance",
    "base16-dark",
    "base16-light",
    "bespin",
    "blackboard",
    "cobalt",
    "colorforth",
    "dracula",
    "duotone-dark",
    "duotone-light",
    "eclipse",
    "elegant",
    "erlang-dark",
    "gruvbox-dark",
    "hopscotch",
    "icecoder",
    "idea",
    "isotope",
    "lesser-dark",
    "liquibyte",
    "lucario",
    "material",
    "mbo",
    "mdn-like",
    "midnight",
    "monokai",
    "neat",
    "neo",
    "night",
    "oceanic-next",
    "panda-syntax",
    "paraiso-dark",
    "paraiso-light",
    "pastel-on-dark",
    "railscasts",
    "rubyblue",
    "seti",
    "shadowfox",
    "solarized dark",
    "solarized light",
    "the-matrix",
    "tomorrow-night-bright",
    "tomorrow-night-eighties",
    "ttcn",
    "twilight",
    "vibrant-ink",
    "xq-dark",
    "xq-light",
    "yeti",
    "zenburn"
  )
}
