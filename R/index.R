#
# index.R
# Created by Riley Roach on 2020-05-24
#
find_index_file <- function(path = NULL) {
  # Allow user to manually specify path to index.htm
  if (length(path) != 0) {
    index_file <- path
    return(index_file)
  }

  host <- Sys.info()[["sysname"]]
  rs_version <- as.character(rstudioapi::getVersion())

  switch(
    host, "Could not determine the operating system.",
    Darwin = {
      paths <- list(default = "/Applications/RStudio.app/",
                    user    = "~/Applications/RStudio.app/",
                    index   = "Contents/Resources/www/index.htm")
    },
    Windows_NT = {
      paths <- list(default = "C:/Program Files/RStudio/",
                    user    = "~/R/RStudio/",
                    index   = "www/index.htm")
    },
    Linux = {
      paths <- list(default = paste0("/usr/local/rstudio/", rs_version),
                    user    = paste0("/usr/local/rstudio/", rs_version),
                    index   = "www/index.htm")
    }
  )

  check_paths <- function(p) {
    .default <- fs::path_join(c(p$default, p$index))
    .user    <- fs::path_join(c(p$default, p$index))

    index_path <- which(fs::file_exists(.default), fs::file_exists(.user))
    if (length(index_path) == 0) return(NULL)
    index_path <- names(index_path)

    return(index_path)
  }

  index_file <- check_paths(p = paths)

  return(index_file)
}


backup_index_file <- function(.index_file = NULL) {
  if (length(.index_file) == 0) {
    err <- "A file must be specified for backup."
    stop(err)
  }

  parent_dir <- dirname(.index_file)
  backup_file <- fs::path_join(c(parent_dir, "index.htm.backup"))
  if (fs::file_exists(backup_file)) {
    wmsg <- "A backup index file already exists. Aborting backup."
    warning(wmsg)
  } else {
    fs::file_copy(.index_file, backup_file)
  }
}


read_index_file <- function(.index_file = NULL) {
  .con = .index_file
  index_htm <- readLines(con = .con)
  return(index_htm)
}


modify_index_file <- function(.index_file = NULL) {
  if (length(.index_file) == 0) {
    err <- "A file must be specified for modification."
    stop(err)
  }


  endof_index_htm <- index_htm[length(index_htm)]
  index_htm[length(index_htm) + 1] <- endof_index_htm

}
