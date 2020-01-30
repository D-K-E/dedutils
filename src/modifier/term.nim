## term primitive maker
from dtype.term import TermId, Term
from maker.term import mkTerm
import json

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
        if c.value == v.value:
            result = true

proc contains(ts: seq[TermId], v: TermId): bool =
    ## check if term is contained in term sequence
    result = false
    for t in ts:
        if t.value == v.value:
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
        if c.value != v.value:
            cs.add(c)
    return replace(t, cs)

proc remove(t: Term, vs: seq[TermId]): Term =
    ## remove value from contained terms
    var cs: seq[TermId]
    for c in t.contain:
        if contains(vs, c) == false:
            cs.add(c)
    return replace(t, cs)
