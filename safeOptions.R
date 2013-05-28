#' safe way to set options
#' 
#' Thanks to Patrick Burns, this is from S Poetry
#'  
#' options() controls features of your R environment, like the warning level,
#' and what to do when an error occurs. 
#
#' You are free to create new options, which is good, but that means you are
#' also free to misspell options, which is bad. If you use soptions()
#' instead, it will warn you of a spelling error, when your name isn't one
#' of the already existing options.
#' 
#'  @param option The name of the option you'd like to set, and the value
#'
#' @references http://www.burns-stat.com/documents/books/s-poetry/
#' @export
#' @examples
#' soptions(warn=2) # warn is a standard option, set it to 2
#' soptions(wan=2)  # typo, will tell you there was an error, and you added a new option

"soptions" <- function(...) {
   args(soptions)
   in.names <- names(list(...))
   oldnames <- names(options())
   newnames <- in.names[!match(in.names, oldnames, nomatch = 0)]
   if(length(newnames)) {
      warning(paste("new options added: ",
                    paste(newnames, collapse = ", ")))
   }
   ans <- options(...)
   #if(.Auto.print)
   #  ans
   #else invisible(ans)
}
