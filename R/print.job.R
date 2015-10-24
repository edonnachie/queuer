
#' S3 method to print an object of class job
#'
#' #### Look up correct syntax to declare S3 class
#' @param job Object of class job
#' @export
print.job <- function(job){
  write.dcf(job)
}