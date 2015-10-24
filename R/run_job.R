#' Run a given job
#'
#' The working directory is switched to job$wd while running the job
#'
#' @param job Job to run
#' @return The input is returned with additional fields "lastrun" (time started) and "lastrun_time" (time taken for script to complete in seconds)
run_job <- function(job){
  wd <- getwd()
  setwd(job$Wd)

  tryCatch({
    job$Lastrun <- as.character(Sys.time())
    t <- run_at(with(job, file.path(Wd, Script)), "now")
    job$Lastrun_time <- t
    },
    error = function(e){
      message("Error running job: ", job$Name, "\n", e)
    }
  )

  setwd(wd)
  return(job)
}