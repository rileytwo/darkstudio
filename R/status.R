#'
#' status.R
#' Created by Riley Roach on 2020-06-27
#' @keywords internal
status <- function(path = NULL) {
  darkstudio_status <- list(
    dir_status = "",
    index_status = "",
    css_status = ""
  )
  if (!darkstudio:::settings_dir(path = path)) {
    darkstudio_status$dir_status <- paste(
      "No darkstudio directory exists, or one could not be found.",
      "If you know there is a directory, provide the path to ",
      "darkstudio::status().",
      "For example: darkstudio::status(path = <path_to_dir>)"
    )
  } else {
    darkstudio_status$dir_status <- darkstudio:::settings_dir(
      path = path,
      value = TRUE
    )
  }

  return(darkstudio_status)

}
