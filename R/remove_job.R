#' Remove a job from a queue file
#'
#' @param job Job to remove from queue
#' @param queue Directory containing queue
#' @return Nothing
#' @export
remove_job <- function(job, queue){
  jobs <- read_queue(queue)

  if(nrow(jobs) == 0){
    warning("remove_job: Queue is empty")
  } else {
    write_queue(
      jobs = jobs[!(jobs$Name %in% job$Name
                    & jobs$Wd %in% job$Wd
                    & jobs$Script %in% job$Script), ],
      queue = queue
    )
  }
}
