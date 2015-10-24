#' Write jobs to a queue file, overwriting the existing contents
#'
#' @param jobs Data.frame containing jobs to run
#' @param queue Directory the queue should be written to
write_queue <- function(jobs, queue){
  init_queue(queue)
  queue_file <- file.path(queue, "queue.dcf")
  write.dcf(jobs, file = queue_file)
}

#' Append jobs to the end of a queue file
#' If the file does not exist or is empty, simply call write_queue
#' (write.dcf does not help because it does not insert an empty line
#' before appending to indicate a new record)
#'
#' @param jobs Data.frame containing jobs to run
#' @param queue Directory the queue should be written to
append_queue <- function(jobs, queue){
  queue_file <- file.path(queue, "queue.dcf")
  if(!file.exists(queue_file) || nrow(read.dcf(queue_file)) == 0){
    write_queue(jobs, queue)
  } else {
    message("Appending to queue", queue_file)
    cat("\n", file = queue_file, append = TRUE)
    write.dcf(jobs, file = queue_file, append = TRUE)
  }
}