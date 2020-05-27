#
# utils.R
# Created by Riley Roach on 2020-05-25
#
create_darkstudio_link <- function(href = NULL) {
  if (length(href) != 0) {
    link <- paste0('<link rel="stylesheet" href="', href,'" type="text/css"/>')
  } else {
    link <- '<link rel="stylesheet" href="darkstudio.css" type="text/css"/>'
  }
  return(link)
}
