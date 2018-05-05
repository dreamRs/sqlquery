
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
#' @param ... Additional parameters, see \url{http://codemirror.net/doc/manual.html#config}.
#'
#' @return a list
#' @export
#' @importFrom utils modifyList
#'
editor_options <- function(lineNumbers = TRUE, lineWrapping = TRUE,
                        tabSize = 4,
                        indentWithTabs = TRUE, smartIndent = TRUE,
                        autofocus = TRUE, ...) {
  args <- list(...)
  options <- list(
    lineNumbers = lineNumbers,
    lineWrapping = lineWrapping,
    indentWithTabs = indentWithTabs,
    smartIndent = smartIndent,
    autofocus = autofocus
  )
  options <- modifyList(options, args)
  return(options)
}



