#' Create a new job
#'
#' @param script Script to run, either with full path or relative to working directory (wd)
#' @param queue Queue directory to which the job should be added. If not specified, the job is returned and not added to any queue.
#' @param name A descriptive name for the job (character)
#' @param wd Working directory from which the script should be run. If NULL (default), wd is inferred using dirname(script) or, if this is not a valid directory, using getwd()
#' @param method How to run the script. Either "batch" (default, using R CMD BATCH), "source" (source function) or "rscript" (Rscript). Alternatively, a custom call may be provided (e.g. "python" to run a python script)
#' @param priority Integer between 1 (high priority) and 5 (low priority)
#' @param prerequisites A character vector giving the names of any jobs that, if also present in the queue, should be run before this job (Default: NULL)
#' @return List with additional class "job"
#' @export
create_job <- function(
                       script,
                       queue = NULL,
                       name = NULL,
                       wd = NULL,
                       method = "batch",
                       priority = 3,
                       prerequisites = NULL){
  # No working directory specified ,
  # either in script or in wd
  if(dir.exists(dirname(script)) & is.null(wd)){
    wd <- normalizePath(dirname(script))
  }
  script <- basename(script)
  if(is.null(wd)){
    wd <- getwd()
  }

  # Sanity tests
  stopifnot(
    file.exists(file.path(wd, script)),
    priority %in% 1:5,
    method %in% c("batch", "source", "rscript")
  )

  # Create and return job object
  job <- data.frame(
    Name = if(!is.null(name)) name else script,
    Script = script,
    Wd = wd,
    Method = method,
    Priority = priority,
    Prerequisites = paste(prerequisites, collapse = ", "),
    Time_added = as.character(Sys.time())
  )
  class(job) <- c("data.frame", "job")

  if(!is.null(queue))
    queue_job(job, queue)

  return(job)
}
