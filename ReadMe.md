## mygmailR

This is an R package that uses the
[gmailR](https://github.com/trinker/gmailR/) package so I can send
myself emails and texts.

The [gmailR](https://github.com/trinker/gmailR/) package does all of
the work. The only thing the mygmailR package does is handle the
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
double-quotes, I think. The value for `text` should be an email
address that will send a text to your cell phone.

**Note**: It seems like the subject and body of an email can't include
single-quotes.

---

Licensed under the [MIT license](LICENSE). ([More information here](http://en.wikipedia.org/wiki/MIT_License).)
