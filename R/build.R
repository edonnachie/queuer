#' Give jobs specified in a control file, build a queue
#'
#' @param buildfile Buildfile in debian control format, containing fields "Script" (required) and (optional) "Name" and/or "Prerequisites". Further fields may be included, but will be ignored. In particular, and working directory specified will be overwritten by the wd arguement. Defailt is "build.dcf". If not present, the function will also look for "queuer/build.dcf". Otherweise, a custom file may be specified.
#' @param jobs Character vector giving the names of the jobs to be run or a regular expression to match with name
#' @param wd Working directory from which to run the jobs. If null (default), use current working directory.
#' @param queue Queue directory to add the jobs in cf to. If null (default), use a subdirectory "queuer" in the working directory.
#' @param priority Priority with which the jobs should be run. Defaults: 3.
#' @param process Should the queue be processed immediately? Default: No, if the queue is specified with the queue parameter (assume job is scheduled), otherwise yes.
#' @export
build <- function(buildfile = "build.dcf",
                  jobs = NULL,
                  wd = NULL,
                  queue = NULL,
                  priority = 3,
                  process = NULL){
  if(!file.exists(buildfile))
    buildfile <- "queuer/buildfile.dcf"

  stopifnot(file.exists(buildfile))

  cf <- read.dcf(buildfile, all = TRUE)

  # If jobs argument is present,
  # filter accordingly
  if(!is.null(jobs) && length(jobs) == 1){
    cf <- cf[grepl(jobs, cf$Name), ]
  }
  if(!is.null(jobs) && length(jobs) > 1){
    cf <- cf[(cf$Name %in% jobs), ]
  }

  # If no wd given, assume current working directory
  if(is.null(wd))
    wd <- getwd()

  # Add required fields that are not
  # given in build file
  cf <- within(cf, {
    Wd <- wd
    Priority <- priority
    Time_added <- as.character(Sys.time())
		Method = "batch"
  })

  # Append to existing queue file
  if(!is.null(queue)){
    if(is.null(process)) process <- FALSE
    append_queue(cf, queue)
  } else {
    queue <- file.path(wd, "queuer")
    write_queue(cf, queue)
    if(is.null(process)) process <- TRUE
  }

  if(process == TRUE) process_queue(queue)
}

