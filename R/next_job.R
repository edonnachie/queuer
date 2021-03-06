#' Give a data frame of jobs (generated by read_queue),
#' return the job to be run next. Jobs are sorted by priority and
#' then by the time added and the first job selected
#'
#' @param jobs Data frame containing jobs
#' @return The row of jobs containin the selected job
next_job <- function(jobs){
  jobs_ordered <- jobs[order(jobs$Priority, jobs$Time_added,
                             decreasing = FALSE), ]
  # Loop through jobs and select the first job
  # that has no dependencies in the queue
  for(j in 1:nrow(jobs_ordered)){
    prereq <- jobs_ordered[j, "Prerequisites"]
    if(is.na(prereq)) prereq <- ""
    prereq <- as.character(strsplit(prereq , split = ",\\s?"))
    prereq <- as.character(strsplit(
      jobs_ordered[j, "Prerequisites"],
      split = ", "
      ))
    if(prereq == "" |
			 !(prereq %in% with(jobs_ordered, c(Name, Script)))
			 )
      return(jobs_ordered[j, ])
  }
  warning("Cannot identify the next job to be run. Check queue and prerequisites!")
}
