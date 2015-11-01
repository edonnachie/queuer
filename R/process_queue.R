#' Process all jobs in a queue
#'
#' @param queue Directory containing queue
#' @export
process_queue <- function(queue){
  # Correct if queue given as relative path
  if(dirname(queue) == "." & dir.exists(queue))
    queue <- normalizePath(queue)

  while (nrow({jobs <- read_queue(queue)}) > 0){
    # Announce job
    cat(format(Sys.time()), "\n")

    # Run job
    job_out <- run_next_job(jobs, queue)

    # Print results
    print.job(job_out)
    cat("\n")

    # Cleanup
    archive_job(job_out, queue)
    remove_job(job_out, queue)
  }
}
