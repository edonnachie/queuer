#' Read jobs from a queue file as a data.frame
#'
#' @param queue Directory containing queue
#' @export
read_queue <- function(queue){
  queue_file <- file.path(queue, "queue.dcf")
  if(file.exists(queue_file)){
    queue <- tryCatch(
      read.dcf(queue_file, all = TRUE),
      error = function(e){
        message("Queue is empty or cannot be read: returning empty data.frame")
        return(data.frame())
      }
    )
  } else {
    queue <- data.frame()
  }
  
  # Make sure all required fields are present,
	# otherwise set to NA to preserve data structure
	required_fields <- c("Name", "Script", "Wd", "Prerequisites", "Priority")
	for(var in required_fields){
		if (!(var %in% names(queue)))
			queue[var] <- NA
	}
  
  return(queue)
}
