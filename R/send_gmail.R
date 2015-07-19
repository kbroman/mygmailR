#  send_gmail
#' Send an email
#'
#' Send an email, using google mail info from a private file
#'
#' @param subject Character string with subject for the email
#'     (Can't include single-quotes.)
#' @param body Character string or vector of character strings, with
#'     the body of the email; if it's a vector, it's combined with
#'     \code{collapse=body_sep} (default = \code{"\\n"}).
#'     (Contents can't include single-quotes, and you need to
#'     double-backslashed the backslashes.)
#'
#' @param to Character string with email address of recipient; if
#'     missing or NULL, send to self (taken from private info)
#' @param body_sep Character string for combining elements in the input \code{body}.
#' @param file_private Character string with file name containing the private information.
#' @param dir_private The directory containing \code{file}. If NULL or
#'     missing, we use the user's home directory \code{"~"}. Use \code{""}
#'     if the \code{file} argument includes the directory.
#'
#' @export
#' @importFrom gmailR gmail
#' @return Returns value from \code{\link[gmailR]{gmail}}.
#'
#' @details
#' Uses gmail address and password information in the
#' \code{~/.gmail_private} file (or another file, specified with
#' \code{dir_private} and \code{file_private}. This should contain records
#' \code{gmail}, \code{password}, and \code{text}, and (optionally) \code{to}.
#'
#' Email will be sent from the address defined in the private file as \code{gmail}.
#' If to is defined in that file, it is used as the default "to" email address;
#' otherwise, \code{gmail} is used as both the "from" and the "to" addresses.
#' You can specify a different recipient with the `to` argument to the function.
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
function(subject="", body="", to, body_sep="\\n",
         file_private=".gmail_private", dir_private=NULL)
{
    private <- read_private_info(file_private, dir_private)

    # if arg 'to' is not provided
    #     see if private$to is defined; if so, use it
    #     otherwise send email to private$gmail
    if(missing(to))
        to <- ifelse(is.null(private$to), private$gmail, private$to)

    body <- paste(body, collapse=body_sep)
    body <- paste0(body, "   ") # last few characters have been getting cut off

    # check for double or single quotes
    check4quotes(subject, "subject")
    check4quotes(body, "body")

    gmail(to=to, password=private$password, subject=subject, message=body,
          from=private$gmail, username=private$gmail)
}
