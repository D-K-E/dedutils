## deal with terms in term lists
import json  # parseFile
from os import joinPath, CurDir, existsFile
from system import newException, OSError, ValueError
import strutils  # string contains

proc getTermList*(lstname: string): JsonNode =
    ## get term list from lstname assuming we are at project base directory
    var tdir = joinPath($(CurDir), "data")
    tdir = joinPath(tdir, "term-list")
    let tpath = joinPath(tdir, lstname & ".json")
    if existsFile(tpath) == false:
        raise newException(OSError, 
            "term list " & lstname & " does not exists")
    return parseFile(tpath)

proc getTermById*(lst: JsonNode, idstr: string): JsonNode {.raises: [ValueError]} =
    ## get term by using id value raises ValueError if id is not found
    var foundTerm = newJNull()
    for term in lst.items():
        if term["id"].getStr() == idstr:
            foundTerm = term
    if foundTerm == newJNull():
        raise newException(ValueError, "id: " & idstr & " not present in lst")
    return foundTerm



proc getTermsFromList*(lst: JsonNode,
                      fuzzy: string): JsonNode {.raises: [ValueError]} =
    ## get terms from term list given a fuzzy identifier
    var foundTerms = newJArray()
    for term in lst.items():
        let termId = term["id"].getStr()
        let termValue = term["value"].getStr()
        if fuzzy in termId or fuzzy in termValue:
            foundTerms.add(term)
        else:
            if term.hasKey("contain") == true:
                let containedIds = term["contain"]
                for cid in containedIds.items():
                    if fuzzy in cid:
                        let contTerm = getTermById(lst, cid.getStr())
                        foundTerms.add(contTerm)
    #
    return foundTerms

proc getTermListFromList*(lst: JsonNode, fzlst: seq[string]): JsonNode = 
    ## get term list from fuzzy string matches
    let terms = newJArray()
    for fz in fzlst:
        let lst = getTermsFromList(lst, fz)
        for l in lst.items():
            if terms.contains(l) == false:
                terms.add(l)
    return terms


proc addTerm2List*(lst: JsonNode, term: string, 
                  lstname: string, contains: seq[string] = @[]): JsonNode =
    ## add term to term list if it does not exist
    let lstlen = lst.len()
    for el in lst.items():
        if el["value"].getStr() == term:
            raise newException(ValueError, "term: " & term & " already exists")
    #
    let termId = lstname & "-" & $(lstlen)
    var termel = %* {"id": termId, "value": term}
    if contains.len() > 0:
        termel["contain"] = %* contains
    lst.add(termel)
    return lst
