#
# storage.R
# Created by Riley Roach on 2020-05-27
#
ds_dir_create <- function(.index_file_path = NULL) {
  index_file_dir <- dirname(.index_file_path)
  darkstudio_dir <- fs::path_join(c(index_file_dir, "darkstudio"))
  fs::dir_create(darkstudio_dir)

  if (!fs::dir_exists(darkstudio_dir)) {
    stop("Could not create darkstudio directory.")
  }
  return(darkstudio_dir)
}


ds_dir_exists <- function(.index_file_path = NULL, value = FALSE) {
  index_file_dir <- dirname(.index_file_path)
  darkstudio_dir <- fs::path_join(c(index_file_dir, "darkstudio"))

  if (value == TRUE) return(darkstudio_dir)

  if (fs::dir_exists(darkstudio_dir)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}
