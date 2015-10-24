#' Add a job to a queue
#'
#' @param job Object of class job (e.g. created using create_job)
#' @param queue Directory to use as a queue
#' @return Nothing
queue_job <- function(job, queue){
  jobs <- read_queue(queue)
  is_duplicate <- (job$Name %in% jobs$Name
                   & job$Wd %in% jobs$Wd
                   & job$Script %in% jobs$Script)
  # Test whether job is a duplicate
  if(is_duplicate){
    warning("Job already queued")
  } else {
    message("Adding job", job$Name, "to queue", queue, sep = " ")
    append_queue(job, queue)
  }
  read_queue(queue)
}