#  send_gmail
#' Send an email
#'
#' Send an email, using google mail info from a private file
#'
#' @param subject Character string with subject for the email
#'     (Can't include single-quotes.)
#' @param body Character string or vector of character strings, with
#'     the body of the email; if it's a vector, it's combined with
#'     \code{collapse=body_sep} (default = \code{"\n"}).
#'     (Contents can't include single-quotes.)
#' @param to Character string with email address of recipient; if
#'     missing or NULL, send to self (taken from private info)
#' @param body_sep Character string for combining elements in the input \code{body}.
#' @param file_private Character string with file name containing the private information.
#' @param dir_private The directory containing \code{file}. If NULL or
#'     missing, we use the user's home directory \code{"~"}. Use \code{""}
#'     if the \code{file} argument includes the directory.
#'
#' @export
#' @return Returns value from \code{\link[gmailR]{gmail}}.
#'
#' @examples
#' \dontrun{
#' send_gmail("R message", "R process done")
#' send_gmail("R message", "R process done", to="someone@@somewhere.com")
#' }
#'
#' @seealso \code{\link{send_text}}
#' @keywords utilities
send_gmail <-
function(subject="", body="", to, body_sep="\n",
         file_private=".gmail_private", dir_private=NULL)
{
    library(gmailR)

    private <- read_private_info(file_private, dir_private)
    if(missing(to)) to <- private$gmail
    body <- paste(body, collapse=body_sep)
    body <- paste0(body, "   ") # last few characters have been getting cut off

    gmailR::gmail(to=to, password=private$password, subject=subject, message=body,
                  from=private$gmail, username=private$gmail)
}

