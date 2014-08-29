## mygmailR

This is an R package that uses the
[gmailR](https://github.com/trinker/gmailR/) package so I can send
myself emails and texts.

The [gmailR](https://github.com/trinker/gmailR/) package does all of
the work. The only thing the [mygmailR](https://github.com/kbroman/mygmailR) package does is handle the
private information so that I don't have to include my password or
gmail account in scripts.

The default is to have a text file `~/.gmail_private` (use `chmod 600`
or `chmod 400` to make it not readable by others) containing the following:

```
password this_is_my_gmail_password
gmail    my_gmail@gmail.com
text     1234567890@text.att.net
```

That is, two columns with first column being a key (`password`,
`gmail`, and `text`) and second column being the corresponding value.
The values (e.g. your password) can't include any spaces or
single- or double-quotes, I think. The value for `text` should be an email
address that will send a text to your cell phone.

**Note**: It seems like the subject and body of an email can't include
single- or double-quotes

### Installation

To install [mygmailR](https://github.com/kbroman/mygmailR), you first
need to install a set of packages from
[CRAN](http://cran.r-project.org).

    pkgs <- c("devtools", "rJava", "rjson", "RCurl", "XML")
    for(pkg in pkgs)
        if( !require(pkg, character.only=TRUE) )
            install.packages(pkg)

(The `if(!require( ))` checks to see if the package is installed; we
only install it if it hadn't already been installed.)

Now load the devtools package.

    library(devtools)

Now use `install_github()` to install
[gmailR](https://github.com/trinker/gmailR) and
[mygmailR](https://github.com/kbroman/mygmailR).

    install_github("trinker/gmailR")
    install_github("kbroman/mygmailR")

### Usage

First, you may need to set up an application-specific password for this,
by going to [Google](http://www.google.com) &rarr; Accounts &rarr;
Security &rarr;
[App passwords settings](https://security.google.com/settings/security/apppasswords?pli=1).

Create a file in your home directory, `~/.gmail_private` that contains
your gmail password (`password`), gmail account (`gmail`) and an email
address that your corresponds to texting to yourself (`text`).

```
password this_is_my_gmail_password
gmail    my_gmail@gmail.com
text     1234567890@text.att.net
```

Make this file not readable by others. At the UNIX command line, type

    chmod 600 ~/.gmail_private

Then within R, you just need to load
[mygmailR](https://github.com/kbroman/mygmailR)

    library(mygmailR)

and then use `send_text()` to send yourself a text or `send_gmail()`
to send yourself an email.

    send_text("sent from R", "Your R process is done.")

Each of these functions takes arguments
`subject` and `body`, which should be character strings with no
single- or double-quotes. `body` may be a vector of character strings,
in which case they are will be pasted together, separated by newline
characters.

    send_gmail("sent from R",
               c("Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                 "Sed maximus ultrices euismod.",
                 "Cras finibus nibh ut sagittis auctor."))

By default, `send_gmail` uses the same &ldquo;from&rdquo; and
&ldquo;to&rdquo; email address, taken from your `~/.gmail_private`
file. If you want to send to a different email address, use the `to`
argument.

    send_gmail("sent from R",
               c("Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                 "Sed maximus ultrices euismod.",
                 "Cras finibus nibh ut sagittis auctor."),
               to="someone_else@someplace.com")

---

Licensed under the [MIT license](LICENSE). ([More information here](http://en.wikipedia.org/wiki/MIT_License).)
