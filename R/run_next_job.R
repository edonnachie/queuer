#' Run the highest priority job in a set of queued jobs
#'
#' @param jobs Data.frame containing jobs to run
#' @param queue Directory containing queue
#' @return Details of job run
run_next_job <- function(jobs, queue){
  if(nrow(jobs) > 0){
    job <- next_job(jobs)
    cat("Processing job: ", job$Name, "\n")
    job_out <- run_job(job)
    # Return
    return(job_out)
  } else {
    warning("No jobs to process")
  }
}

