## separator primitive

import unicode

type
    US* = object
        d* = "" # unit separator:U+001F
                   # default value
        s* = "-"   # sensible value

proc `==`(s1, s2: US): bool =
    return s1.d == s2.d

proc `!=`(s1, s2: US): bool =
    return not(s1 == s2)

type
    RS* = object
        d* = "" # record separator: U+001E
                   # default value
        s* = "_"   # sensible value

proc `==`(s1, s2: RS): bool =
    return s1.d == s2.d

proc `!=`(s1, s2: RS): bool =
    return not(s1 == s2)


type
    GS* = object
        d* = "" # group separator: U+001D
                   # default value
        s* = ":"   # sensible value

proc `==`(s1, s2: GS): bool =
    return s1.d == s2.d

proc `!=`(s1, s2: GS): bool =
    return not(s1 == s2)


