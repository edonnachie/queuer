#' Sleep until a specified time within the next 24 hours
#'
#' @param time Time in format HH:MM
#' @return Invisible
#' @export
sleep_until <- function(time){
	d <- difftime(as.POSIXct(paste(Sys.Date(), time)), Sys.time(), units = "secs")
  if (d < 0)
		d <- difftime(as.POSIXct(paste(Sys.Date() + 1, time)), Sys.time(), units = "secs")

  Sys.sleep(d)
	invisible()
}
#' Sleep until a specified time within the next 24 hours
#'
#' @param script Location of script, input to R CMD BATCH or source
#' @param time Time in format HH:MM
#' @param method How to run the script. Available options are "batch" (run using R CMD BATCH in a separate process), "rscript" (run using Rscript in a separate process) and "source" (source into current sesssion).
#' @param args String containing further arguments to pass to R CMD BATCH or Rscript, e.g. "--no-save". (ignored if sourcing). Default is NULL.
#' @return Time (in seconds) taken by batch script to complete (if "now", run straigt away)
#' @export
run_at <- function(script, time, method = "batch", args = NULL){
	if(tolower(time) != "now") sleep_until(time)
	t0 <- Sys.time()
  if(tolower(method) == "batch"){
    system(paste0("R CMD BATCH ", args, script))
  }
  if(tolower(method) == "rscript"){
    system(paste0("Rscript ", args, script))
  }
	if(tolower(method) == "source"){
    source(script)
  }
  return(difftime(Sys.time(), t0, units = "secs"))
}