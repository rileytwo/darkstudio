#
# utils.R
# Created by Riley Roach on 2020-05-25
#
link_default <- function() {
  link <- '<link rel="stylesheet" href="darkstudio.css" type="text/css"/>'
  return(link)
}

link_custom <- function(href = NULL) {
  link <- paste0('<link rel="stylesheet" href="', href,'" type="text/css"/>')
  return(link)
}
