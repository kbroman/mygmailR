#  read_private_info.R
# Read private gmail info from a file
#
# Read private gmail info (password, gmail, text address) from a file.
#
# @param file Character string with file name containing the private information.
# @param dir The directory containing \code{file}. If NULL or
# missing, we use the user's home directory \code{"~"}. Use \code{""}
# if the \code{file} argument includes the directory.
#
# @return list with information from \code{file}
#
# @examples
# \donttest{private <- read_private_info()}
#
# @details
# The file should be set up with two columns separated by
# whitespace. The left column has the keys (password, gmail, text)
# and the right column has the values (the actual password, gmail
# account, and email address for sending a text)
#
# The default is for the file to be \code{"~/gmail_private.txt"}.
#
# @seealso \code{\link{send_gmail}}, \code{\link{send_text}}
# @keywords utilities
#
read_private_info <-
function(file="gmail_private.txt", dir)
{
    # if missing dir, use home directory
    if(missing(dir) || is.null(dir)) dir <- Sys.getenv("HOME")

    # if dir == "", file includes path
    # if dir != "", combine dir and file
    if(dir != "")
        file <- file.path(path.expand(dir), file)

    info <- read.table(file, header=FALSE, stringsAsFactors=FALSE)

    # data should have two columns, key and value
    # expected keys: password, gmail, text (email address to send text)
    result <- as.list(info[,2])
    names(result) <- info[,1]

    if(is.null(result$password))
        stop("private information doesn't include password")
    if(is.null(result$gmail))
        stop("private information doesn't include gmail address")

    # return list of values with keys as names
    result
}
