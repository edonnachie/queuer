#' Save a job to its own archive file
#' (e.g. after running and removing from the queue)
#'
#' @param job Job to archive
#' @param queue Directory containing queue
archive_job <- function(job, queue){
  dir <- file.path(queue, "archive")
  if(!dir.exists(dir)) dir.create(dir)
  fname = paste0(job$Script, ".log" )
  write.dcf(job, file = file.path(dir, fname))
}
