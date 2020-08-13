#'
#'  tools.R
#'  Created by Riley Roach on 2020-05-30
#'
#' @keywords internal
preview_changes <- function(path = ".") {
  darkstudio_css <- fs::path(path, "/inst/resources/darkstudio.css")

  index_file <- darkstudio:::index$find()

  darkstudio_dir <- darkstudio:::settings_dir_exists(
    path = index_file, value = TRUE
  )

  if (isTRUE(darkstudio_dir)) {
    fs::file_copy(darkstudio_css, darkstudio_dir, overwrite = TRUE)
  } else {
    stop("darkstudio is not activated.")
  }
}


load_functions <- function(path = NULL) {
  if (length(path) == 0) {
    path = "."
  }
  if ("R" %in% dir() && dir.exists("R")) {
    for (i in dir("R")) {
      source(paste("R", i, sep = "/"))
    }
  }
}
