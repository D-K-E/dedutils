## term primitive maker
from dtype.term import TermId, Term
import json

proc mkIdStr(id: string, nb: int): string =
    ## make id string from a string and a number
    ## a number corresponds to the position of the
    ## term in the list. id is usually the list name
    ## a combined name from parent lists
    return id & "-" & $(nb)

proc str2id(idstr: string): TermId =
    ## produce an id from string
    return TermId(value: idstr)

proc mkTermId(id: string, nb: int): TermId =
    ## produce an id from string and number
    return str2id(mkIdStr(id, nb))

proc mkTerm(id: TermId, value: string, contain: seq[TermId]): Term =
    ## produce a term from id value and contain
    return Term(id: id, value: value, contain: contain)
