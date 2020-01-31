## term primitive maker
import "../../dtype/term"
from maker/term import mkTerm
import json

##
## Replace declarations
proc replace(t: Term, id: TermId): Term
proc replace(t: Term, val: string): Term
proc replace(t: Term, val: seq[TermId]): Term
# --------- end Replacer ----
## Contains declarations
proc contains(t: Term, v: TermId): bool
## Add/Remove declarations
proc add(t: Term, v: TermId): Term
proc add(t: Term, vs: seq[TermId]): Term
proc remove(t: Term, v: TermId): Term
proc remove(t: Term, vs: seq[TermId]): Term


## Implementations
proc replace(t: Term, id: TermId): Term =
    ## replace id of given term with id
    let c = t.contain
    let v = t.value
    return mkTerm(id, v, c)

proc replace(t: Term, val: string): Term =
    ## replace value of given term with val
    let c = t.contain
    let id = t.id
    return mkTerm(id, val, c)

proc replace(t: Term, val: seq[TermId]): Term =
    ## replace contain of given term with val
    return mkTerm(t.id, t.value, val)

proc contains(t: Term, v: TermId): bool =
    ## check if term contains term id
    let cs = t.contain
    result = false
    for c in cs:
        if c == v:
            result = true


proc add(t: Term, v: TermId): Term =
    ## add value to contain
    var cs = t.contain
    let check = contains(t, v)
    if check == false:
        cs.add(v)
    return replace(t, cs)

proc add(t: Term, vs: seq[TermId]): Term =
    ## add values to contain
    var cs = t.contain
    for v in vs:
        let check = contains(t, v)
        if check == false:
            cs.add(v)
    return replace(t, cs)

proc remove(t: Term, v: TermId): Term =
    ## remove value from contained terms
    var cs: seq[TermId]
    for c in t.contain:
        if c != v:
            cs.add(c)
    return replace(t, cs)

proc remove(t: Term, vs: seq[TermId]): Term =
    ## remove value from contained terms
    var cs: seq[TermId]
    for c in t.contain:
        if contains(vs, c) == false:
            cs.add(c)
    return replace(t, cs)
