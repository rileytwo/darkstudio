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

  switch(
    host, stop("Could not determine the operating system."),
    Darwin = {
      paths <- list(default = "/Applications/RStudio.app/",
                    user    = "~/Applications/RStudio.app/",
                    index   = "Contents/Resources/www/index.htm")
    },
    Windows = {
      paths <- list(default = "C:/Program Files/RStudio/",
                    user    = "~/R/RStudio/",
                    index   = "www/index.htm")
    },
    Linux = {
      rs_ver <- as.character(rstudioapi::getVersion())
      paths <- list(default = paste0("/usr/local/rstudio/", rs_ver),
                    user    = paste0("/usr/local/rstudio/", rs_ver),
                    index   = "www/index.htm")
    }
  )

  check_paths <- function(p) {
    .default <- fs::path_join(c(p$default, p$index))
    .user    <- fs::path_join(c(p$default, p$index))

    index_path <- which(fs::file_exists(.default), fs::file_exists(.user))
    if (length(index_path) == 0) {
      return(NULL)
    }

    index_path <- names(index_path)

    return(index_path)
  }

  index_file_path <- check_paths(p = paths)

  return(index_file_path)
}


backup_index_file <- function(.index_file_path = NULL) {
  if (length(.index_file_path) == 0) {
    err <- "A file must be specified for backup."
    stop(err)
  }

  parent_dir <- dirname(.index_file_path)
  ds_dir <- fs::path_join(c(parent_dir, "darkstudio"))

  backup_file_path <- fs::path_join(c(ds_dir, "index.htm.pre-ds"))

  if (fs::file_exists(backup_file_path)) {
    msg <- "A backup index file already exists. Not backing up."
    warning(msg)
  } else {
    fs::file_copy(.index_file_path, backup_file_path)
  }
}


restore_index_file <- function(.index_file_path = NULL) {
  if (length(.index_file_path) == 0) {
    err <- "A file must be specified for restoration."
    stop(err)
  }

  parent_dir <- dirname(.index_file_path)
  ds_dir <- fs::path_join(c(parent_dir, "darkstudio"))

  backup_file_path <- fs::path_join(c(ds_dir, "index.htm.pre-ds"))

  fs::file_copy(backup_file_path, .index_file_path, overwrite = TRUE)
}


read_index_file <- function(.index_file_path = NULL) {
  .con <- .index_file_path
  index_htm <- readLines(con = .con)
  return(index_htm)
}


modify_index_file <- function(.index_file = NULL, .ds_link = NULL) {
  if (length(.index_file) == 0) {
    err <- "A file must be specified for modification."
    stop(err)
  }

  # Dirty workaround to make sure we add our link in before the closing
  # </html> tag
  for (.line in seq_along(.index_file)) {
    .line_current  <- .line
    .line_next     <- .line_current + 1


    if (.index_file[[.line_current]] == "</html>") {

      # Append a line to the index with the content of the current index's
      # final line (which is hopefully "</html>")
      .index_file[[.line_next]] <- .index_file[[.line_current]]

      ## Add in the link
      .index_file[[.line]] <- .ds_link
    }
  }


  return(.index_file)
}
