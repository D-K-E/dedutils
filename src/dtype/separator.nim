## separator primitive

import unicode

type
    US* = object
        d* = "" # unit separator:U+001F
                   # default value
        s* = "-"   # sensible value

type
    RS* = object
        d* = "" # record separator: U+001E
                   # default value
        s* = "_"   # sensible value

type
    GS* = object
        d* = "" # group separator: U+001D
                   # default value
        s* = ":"   # sensible value
