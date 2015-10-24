#' Initialise a queue directory
#'
#' @param queue Directory in which queue should be created
#' @return Nothing
init_queue <- function(queue){
  if(!dir.exists(queue)){
    dir.create(paste0(queue, "/archive"), recursive = TRUE)
  }
}