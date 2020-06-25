#' Update Styles
#'
#' Updates the \code{darkstudio.css}. Meant to be used after upgrading
#' \code{daRkStudio} and/or after upgrading RStudio.
#'
#' @return Returns \code{TRUE} if the operation is successful.
#' @export
update_styles <- function() {
  if (deactivate() == TRUE) {
    activate()
  }
  return(TRUE)
}
