#'
#' storage.R
#' Created by Riley Roach on 2020-05-27
#' @keywords internal
settings_dir_create <- function(path = NULL) {
  if (length(path) == 0) {
    err <- "No path name was given. (path = NULL)"
    stop(err)
  }
  dir_name <- dirname(path)
  darkstudio_dir <- fs::path_join(c(dir_name, "darkstudio"))
  fs::dir_create(darkstudio_dir)

  if (!fs::dir_exists(darkstudio_dir)) {
    stop("Could not create darkstudio directory.")
  }
  return(darkstudio_dir)
}


settings_dir_exists <- function(path = NULL, value = FALSE) {
  if (length(path) == 0) {
    path <- index_file_find()
  }
  dir_name <- dirname(path)
  darkstudio_dir <- fs::path_join(c(dir_name, "darkstudio"))

  if (value == TRUE) {
    return(darkstudio_dir)
  }

  if (fs::dir_exists(darkstudio_dir)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
