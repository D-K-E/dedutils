## term primitive maker
import "../dtype/term"
import "../dtype/separator"
import json

proc mkSafeIdStr*(id: string, nb: int): string =
    ## make id string from a string and a number
    ## a number corresponds to the position of the
    ## term in the list. id is usually the list name
    ## a combined name from parent lists
    const us = safeSeparators[Seps.US]
    return id & us & $(nb)

proc mkReadableIdStr(id: string, nb: int): string =
    ## make id string from a string and a number
    ## a number corresponds to the position of the
    ## term in the list. id is usually the list name
    ## a combined name from parent lists
    const us = readableSeparators[Seps.US]
    return id & us & $(nb)


proc str2id*(idstr: string): TermId =
    ## produce an id from string
    return TermId(value: idstr)

proc mkSafeTermId(id: string, nb: int): TermId =
    ## produce an id from string and number
    return str2id(mkSafeIdStr(id, nb))

proc mkReadableTermId(id: string, nb: int): TermId =
    ## produce an id from string and number
    return str2id(mkReadableIdStr(id, nb))


proc mkTerm*(id: TermId, value: string, contain: seq[TermId]): Term =
    ## produce a term from id value and contain
    return Term(id: id, value: value, contain: contain)
