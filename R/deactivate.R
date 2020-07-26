#' Deactivate daRkStudio
#'
#' Remove and replace the modified \code{index.htm} with the backup
#' \code{index.htm.pre-ds} file. Also deletes the \code{darkstudio} directory.
#'
#' This function does NOT uninstall the daRkStudio package.
#' To uninstall the darkstudio package, copy and
#' paste remove.packages('darkstudio') into the console.
#'
#' @param file_index character:
#'   Path to RStudio's \code{index.htm}.
#'
#' @return Returns \code{TRUE} if the operation is successful.
#' @export
deactivate <- function(path = NULL) {
  path_index <- index_file_find(path = path)

  index_file_restore(path = path_index)

  if (!settings_dir_exists(path = path_index)) {
    warning("darkstudio directory does not exist.")
  } else {
    ds_dir <- settings_dir_exists(path = path_index, value = TRUE)
    fs::dir_delete(ds_dir)
  }
  return(TRUE)
}
