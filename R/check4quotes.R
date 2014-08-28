# body and subject
check4quotes <-
function(vec, name_of_thing="Body")
{
    if(length(grep("'", vec)) > 0 ||
       length(grep('"', vec)) > 0)
        stop(name_of_thing, " can't contain any single- or double-quotes")
}

